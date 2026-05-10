import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:fruits_hub/core/error/exceptions.dart';
import 'package:fruits_hub/core/error/failures.dart';
import 'package:fruits_hub/core/helper/functions/get_current_local.dart';
import 'package:fruits_hub/core/services/firebase_auth_service.dart';
import 'package:fruits_hub/features/auth/data/models/user_model.dart';
import 'package:fruits_hub/features/auth/domain/entities/user_entity.dart';
import 'package:fruits_hub/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuthService _firebaseAuthService;

  AuthRepoImpl(this._firebaseAuthService);

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      var user = await _firebaseAuthService.createUserWithEmailAndPassword(
        email,
        password,
        name,
      );
      return Right(UserModel.fromFirebaseUser(user));
    } on CustomException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      if (kDebugMode) {
        log(
          'Exception in AuthRepoImpl.createUserWithEmailAndPassword(catch_Exception): ${e.toString()} and code is ${e.runtimeType}',
        );
      }
      return Left(
        ServerFailure(
          isArabic()
              ? "حدث خطأ. يرجى المحاولة مرة أخرى في وقت لاحق.\n رسالة الخطأ هي: $e"
              : 'An error occured. Please try again later.\n error message is: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithApple() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }
}
