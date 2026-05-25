import 'package:dartz/dartz.dart';
import 'package:fruits_hub/core/error/failures.dart';
import 'package:fruits_hub/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  // ===========================================================================
  // 1. دوال إنشاء الحساب وتسجيل الدخول الأساسية
  // ===========================================================================

  /// لإنشاء حساب جديد باستخدام الإيميل والباسورد
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  );

  /// لتسجيل الدخول باستخدام الإيميل والباسورد للمستخدمين الحاليين
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  );

  // ===========================================================================
  // 2. دوال تسجيل الدخول بالسوشيال ميديا (مقدمي الخدمة الخارجيين)
  // ===========================================================================
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> signInWithApple();
  Future<Either<Failure, UserEntity>> signInWithFacebook();

  // ===========================================================================
  // 3. دالة تسجيل الخروج من التطبيق
  // ===========================================================================
  Future<void> signOut();

  // ===========================================================================
  // 4. دوال التعامل مع قاعدة البيانات (Database - Firestore) والكاش (Cache)
  // ===========================================================================

  /// لحفظ بيانات المستخدم في قاعدة البيانات (Firestore) بعد إنشاء حساب جديد أو تسجيل دخول السوشيال ميديا
  Future addUserData({required UserEntity user});

  /// لجلب بيانات المستخدم من قاعدة البيانات (Firestore) باستخدام الـ uId بتاعه (عشان نعرض بياناته في الـ Profile)
  Future<UserEntity> getUserData({required String uId});

  /// لحفظ بيانات المستخدم محلياً في الكاش (الموبايل) عشان لما يفتح التطبيق تاني ميعملش تسجيل دخول من أول وجديد
  Future saveUserDataToCache({required UserEntity user});

  // Future<UserEntity> getUserDataFromCache();
  // Future<Either<Failure, Unit>> updateUserData({
  //   required String uId,
  //   String? name,
  //   String? email,
  //   String? phone,
  //   String? image,
  // });
}
