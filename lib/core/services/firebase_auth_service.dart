import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_hub/core/error/exceptions.dart';

class FirebaseAuthService {
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomExceptions('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomExceptions('The account already exists for that email.');
      } else {
        throw CustomExceptions(
          e.message ?? 'An error occured. Please try again later.',
        );
      }
    } catch (e) {
      throw CustomExceptions('An error occured. Please try again later.');
    }
  }
}
