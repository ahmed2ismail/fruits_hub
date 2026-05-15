import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fruits_hub/core/error/exceptions.dart';
import 'package:fruits_hub/core/helper/functions/get_current_local.dart';
import 'package:fruits_hub/features/auth/data/models/user_model.dart';
import 'package:fruits_hub/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:fruits_hub/core/error/failures.dart';

Future<Either<Failure, UserEntity>> authHandler(
  Future<User> Function() authFunction, {
  required String errMessageFrom,
}) async {
  try {
    final user = await authFunction();
    return Right(UserModel.fromFirebaseUser(user));
  } on CustomException catch (e) {
    return Left(ServerFailure(e.message));
  } catch (e) {
    if (kDebugMode) {
      log(
        'Exception in AuthRepoImpl.$errMessageFrom(catch_Exception): ${e.toString()} and code is ${e.runtimeType}',
      );
    }
    return Left(
      ServerFailure(
        isArabic()
            ? "حدث خطأ. يرجى المحاولة مرة أخرى في وقت لاحق."
            : 'An error occurred. Please try again later.',
      ),
    );
  }
}
