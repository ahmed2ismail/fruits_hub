import 'package:dartz/dartz.dart';
import 'package:fruits_hub/core/error/failures.dart';
import 'package:fruits_hub/core/helper/functions/auth_handler.dart';
import 'package:fruits_hub/core/services/firebase_auth_service.dart';
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
  ) {
    return authHandler(
      () => _firebaseAuthService.createUserWithEmailAndPassword(
        email,
        password,
        name,
      ),
      errMessageFrom: 'createUserWithEmailAndPassword',
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  ) {
    return authHandler(
      () => _firebaseAuthService.signInWithEmailAndPassword(email, password),
      errMessageFrom: 'signInWithEmailAndPassword',
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    return authHandler(
      () => _firebaseAuthService.signInWithGoogle(),
      errMessageFrom: 'signInWithGoogle',
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    return authHandler(
      () => _firebaseAuthService.signInWithFacebook(),
      errMessageFrom: 'signInWithFacebook',
    );
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithApple() async {
    return authHandler(
      () => _firebaseAuthService.signInWithApple(),
      errMessageFrom: 'signInWithApple',
    );
  }

  @override
  Future<void> signOut() async {
    // No need for try-catch here as signOut rarely fails and doesn't return a value.
    await _firebaseAuthService.signOut();
  }
}
