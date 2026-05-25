import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fruits_hub/core/error/exceptions.dart';
import 'package:fruits_hub/core/error/failures.dart';
import 'package:fruits_hub/core/helper/functions/auth_handler.dart';
import 'package:fruits_hub/core/helper/functions/get_current_local.dart';
import 'package:fruits_hub/core/services/database_service.dart';
import 'package:fruits_hub/core/services/firebase_auth_service.dart';
import 'package:fruits_hub/core/services/shared_preferences_singleton.dart';
import 'package:fruits_hub/core/utils/app_constants.dart';
import 'package:fruits_hub/core/utils/backend_endpoints.dart';
import 'package:fruits_hub/features/auth/data/models/user_model.dart';
import 'package:fruits_hub/features/auth/domain/entities/user_entity.dart';
import 'package:fruits_hub/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuthService _firebaseAuthService;
  final DatabaseService _databaseService;

  AuthRepoImpl(
    this._firebaseAuthService, {
    required DatabaseService databaseService,
  }) : _databaseService = databaseService;

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    // الخطوة 1: نكلم المطبخ (Firebase Auth) عشان يكريت الحساب بالإيميل والباسورد
    // بنستخدم authHandler عشان لو حصل خطأ يمسكه ويرجعه بشكل منظم
    final result = await authHandler(
      () => _firebaseAuthService.createUserWithEmailAndPassword(
        email,
        password,
        name,
      ),
      errMessageFrom: 'createUserWithEmailAndPassword',
    );

    // الخطوة 2: لو الحساب اتكأريت بنجاح، فايربيز هيرجعلنا uId. هنبدأ نحفظ بقية بياناته
    return await result.fold((failure) async => Left(failure), (
      userEntity,
    ) async {
      // بنجهز البيانات اللي هنحفظها في شكل كرتونة نظيفة (Entity)
      final newUser = UserEntity(name: name, email: email, uId: userEntity.uId);

      try {
        // الخطوة 3: نحفظ البيانات دي في السيرفر (Firestore Database)
        await addUserData(user: newUser);
        // الخطوة 4: نحفظ البيانات دي على الموبايل (Cache) عشان تفضل موجودة لما يقفل ويفتح
        await saveUserDataToCache(user: newUser);
        return Right(newUser);
      } catch (e) {
        // الخطوة 5 (Rollback): لو حصلت مشكلة في الداتابيز واحنا بنحفظ الداتا، بنمسح الحساب اللي اتكأريت في فايربيز اوث
        // عشان الداتا متبقاش ناقصة، ويقدر اليوزر يحاول يسجل تاني
        try {
          await _firebaseAuthService.deleteUser();
        } catch (deleteError) {
          if (kDebugMode) {
            log('Rollback failed (deleteUser): $deleteError');
          }
        }
        if (e is CustomException) {
          return Left(ServerFailure(e.message));
        }
        if (kDebugMode) {
          log(
            'Exception in AuthRepoImpl.createUserWithEmailAndPassword(addUserData): ${e.toString()} and code is ${e.runtimeType}',
          );
        }
        return Left(
          ServerFailure(
            isArabic()
                ? 'حدث خطأ أثناء حفظ بيانات المستخدم. يرجى المحاولة مرة أخرى.'
                : 'An error occurred while saving user data. Please try again.',
          ),
        );
      }
    });
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    // الخطوة 1: نكلم فايربيز اوث عشان يتأكد إن الإيميل والباسورد صح
    final result = await authHandler(
      () => _firebaseAuthService.signInWithEmailAndPassword(email, password),
      errMessageFrom: 'signInWithEmailAndPassword',
    );

    // الخطوة 2: لو تسجيل الدخول نجح، هنبدأ نجيب بياناته
    return await result.fold((failure) async => Left(failure), (
      userEntity,
    ) async {
      try {
        // الخطوة 3: نجيب بيانات اليوزر الكاملة (الاسم والصورة الخ) من قاعدة البيانات باستخدام الـ uId
        final user = await getUserData(uId: userEntity.uId);
        // الخطوة 4: نحفظها في الكاش عشان نعرضها في التطبيق بسهولة
        await saveUserDataToCache(user: user);
        return Right(user);
      } catch (e) {
        if (e is CustomException) {
          return Left(ServerFailure(e.message));
        }
        return Left(
          ServerFailure(
            isArabic()
                ? "حدث خطأ أثناء جلب بيانات المستخدم."
                : 'An error occurred while fetching user data.',
          ),
        );
      }
    });
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    return _handleSocialLogin(
      () => _firebaseAuthService.signInWithGoogle(),
      'signInWithGoogle',
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    return _handleSocialLogin(
      () => _firebaseAuthService.signInWithFacebook(),
      'signInWithFacebook',
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithApple() async {
    return _handleSocialLogin(
      () => _firebaseAuthService.signInWithApple(),
      'signInWithApple',
    );
  }

  @override
  Future<void> signOut() async {
    // No need for try-catch here as signOut rarely fails and doesn't return a value.
    await _firebaseAuthService.signOut();
  }

  @override
  Future<dynamic> addUserData({required UserEntity user}) async {
    // الدالة دي بتاخد الكرتونة (Entity) وتحولها لـ Map (الформаت اللي بيفهمه الفايرستور)
    // وبترفعها على السيرفر في collection اسمها users
    await _databaseService.addData(
      path: BackendEndpoints.usersCollection,
      data: UserModel.fromEntity(user).toMap(),
      documentId: user.uId,
    );
  }

  @override
  Future<UserEntity> getUserData({required String uId}) async {
    // الدالة دي بتجيب الداتا من الفايرستور كـ Map
    // وبعدين بتحولها تاني لـ Entity عشان نقدر نستخدمها جوه التطبيق بتاعنا
    final data = await _databaseService.getData(
      path: BackendEndpoints.usersCollection,
      documentId: uId,
    );
    return UserModel.fromjson(data);
  }

  @override
  Future saveUserDataToCache({required UserEntity user}) async {
    // SharedPreferences بياخد البيانات كـ String، فبنحول الـ Map بتاع اليوزر لـ JSON String ونحفظه
    String encodedJsonData = jsonEncode(UserModel.fromEntity(user).toMap());
    await Prefs.setString(key: AppConstants.kUserData, value: encodedJsonData);
  }

  // ---------------------------------------------------------
  // --- Helper Methods (دوال مساعدة لتقليل تكرار الكود) ---
  // ---------------------------------------------------------

  /// دالة مساعدة لمعالجة تسجيل الدخول بحسابات السوشيال ميديا (جوجل، فيسبوك، آبل)
  /// تقوم بالمصادقة، ثم تتحقق إذا كان المستخدم جديداً لتقوم بحفظ بياناته في قاعدة البيانات
  Future<Either<Failure, UserEntity>> _handleSocialLogin(
    Future<User> Function() authFunction,
    String errMessageFrom,
  ) async {
    // الخطوة 1: بنفذ عملية تسجيل الدخول من فايربيز حسب مقدم الخدمة (جوجل مثلاً)
    final result = await authHandler(
      authFunction,
      errMessageFrom: errMessageFrom,
    );

    // الخطوة 2: لو المستخدم سجل بنجاح ووافق على الصلاحيات
    return await result.fold((failure) async => Left(failure), (
      userEntity,
    ) async {
      try {
        // الخطوة 3: نسأل الداتابيز: هل اليوزر ده سجل دخول قبل كده؟
        final exists = await _databaseService.checkIfDataExists(
          path: BackendEndpoints.usersCollection,
          documentId: userEntity.uId,
        );

        if (!exists) {
          // الخطوة 4 (مستخدم جديد): نحفظ بياناته في الداتابيز لأول مرة، ونحفظها في الكاش
          await addUserData(user: userEntity);
          await saveUserDataToCache(user: userEntity);
          return Right(userEntity);
        } else {
          // الخطوة 4 (مستخدم قديم): نجيب بياناته الموجودة بالفعل في الداتابيز، ونحفظها في الكاش
          final existingUser = await getUserData(uId: userEntity.uId);
          await saveUserDataToCache(user: existingUser);
          return Right(existingUser);
        }
      } catch (e) {
        if (e is CustomException) {
          return Left(ServerFailure(e.message));
        }
        if (kDebugMode) {
          log(
            'Exception in AuthRepoImpl.$errMessageFrom (addUserData): ${e.toString()}',
          );
        }
        return Left(
          ServerFailure(
            isArabic()
                ? 'حدث خطأ أثناء حفظ بيانات المستخدم. يرجى المحاولة مرة أخرى.'
                : 'An error occurred while saving user data. Please try again.',
          ),
        );
      }
    });
  }
}
