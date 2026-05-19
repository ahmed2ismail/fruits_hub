import 'package:dartz/dartz.dart';
import 'package:fruits_hub/core/error/failures.dart';
import 'package:fruits_hub/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  );

  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  );

  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> signInWithApple();
  Future<Either<Failure, UserEntity>> signInWithFacebook();

  // هتستخدم عشان اعمل تسجيل خروج من التطبيق await FirebaseAuth.instance.signOut();
  Future<void> signOut();

// عشان اضيف بيانات المستخدم في ال database بعد ما اعمل تسجيل دخول او تسجيل حساب جديد عشان اقدر اعرضها في ال profile page
  Future addUserData({required UserEntity user});

// هتستخدم عشان اعرض بيانات المستخدم في ال profile page بعد ما اعمل تسجيل دخول او تسجيل حساب جديد عشان اقدر اعرضها في ال profile page عن طريق ال uId اللي بترجعلي من ال createUserWithEmailAndPassword او signInWithEmailAndPassword او signInWithGoogle او signInWithApple او signInWithFacebook عشان اقدر اعرض بيانات المستخدم في ال profile page
  Future<UserEntity> getUserData({required String uId});
}
