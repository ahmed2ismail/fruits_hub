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
    // 1. إنشاء الحساب في Firebase Auth
    final result = await authHandler(
      () => _firebaseAuthService.createUserWithEmailAndPassword(
        email,
        password,
        name,
      ),
      errMessageFrom: 'createUserWithEmailAndPassword',
    );

    // 2. التحقق من النتيجة: إذا نجحت، نقوم بحفظ البيانات في Firestore
    return await result.fold((failure) async => Left(failure), (
      userEntity,
    ) async {
      final newUser = UserEntity(name: name, email: email, uId: userEntity.uId);

      try {
        await addUserData(user: newUser);
        return Right(newUser);
      } catch (e) {
        // عملية تراجع (Rollback): حذف المستخدم من Firebase Auth إذا فشل حفظ بياناته
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
    final result = await authHandler(
      () => _firebaseAuthService.signInWithEmailAndPassword(email, password),
      errMessageFrom: 'signInWithEmailAndPassword',
    );

    return await result.fold((failure) async => Left(failure), (
      userEntity,
    ) async {
      try {
        final user = await getUserData(uId: userEntity.uId);
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
    await _databaseService.addData(
      path: BackendEndpoints.usersCollection,
      data: user.toMap(),
      documentId: user.uId,
    );
  }

  @override
  Future<UserEntity> getUserData({required String uId}) async {
    final data = await _databaseService.getData(
      path: BackendEndpoints.usersCollection,
      documentId: uId,
    );
    return UserModel.fromjson(data);
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
    final result = await authHandler(
      authFunction,
      errMessageFrom: errMessageFrom,
    );

    return await result.fold((failure) async => Left(failure), (
      userEntity,
    ) async {
      try {
        // 1. التحقق هل المستخدم موجود بالفعل في قاعدة البيانات؟ (هل سجل دخول قبل كده؟)
        final exists = await _databaseService.checkIfDataExists(
          path: BackendEndpoints.usersCollection,
          documentId: userEntity.uId,
        );

        // 2. إذا لم يكن موجوداً (مستخدم جديد)، نقوم بحفظ بياناته
        if (!exists) {
          await addUserData(user: userEntity);
          return Right(userEntity);
        } else {
          // 3. إذا كان موجوداً، نجلب بياناته من قاعدة البيانات ونرجعها
          final existingUser = await getUserData(uId: userEntity.uId);
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
