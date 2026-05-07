import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_hub/core/error/exceptions.dart';

class FirebaseAuthService {
  Future<User> signInWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomException('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException('The account already exists for that email.');
      } else {
        throw CustomException(
          e.message ?? 'An error occured. Please try again later.',
        );
      }
    } catch (e) {
      throw CustomException('An error occured. Please try again later.');
    }
  }
}
