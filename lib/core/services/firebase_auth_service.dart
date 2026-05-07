import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_hub/core/error/exceptions.dart';
import 'package:fruits_hub/core/helper/functions/get_current_local.dart';

class FirebaseAuthService {
  Future<User> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // After creating the user, update their profile with the provided name.
      if (credential.user != null) {
        await credential.user!.updateDisplayName(name);
      }
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomException(
          isArabic()
              ? 'كلمة المرور ضعيفة جدا.'
              : 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
          isArabic()
              ? 'البريد الإلكتروني مستخدم بالفعل. قم بتسجيل الدخول'
              : 'The account already exists for that email. Signin instead.',
        );
      } else if (e.code == 'invalid-email') {
        throw CustomException(
          isArabic()
              ? 'البريد الإلكتروني الذي أدخلته غير صالح.'
              : 'The email address you entered is not valid.',
        );
      } else {
        throw CustomException(
          isArabic()
              ? "حدث خطأ. يرجى المحاولة مرة أخرى في وقت لاحق.\n رسالة الخطأ هي: ${e.message}"
              : 'An error occured. Please try again later.\n error message is: ${e.message}',
        );
      }
    } catch (e) {
      throw CustomException(
        isArabic()
            ? "حدث خطأ. يرجى المحاولة مرة أخرى في وقت لاحق.\n رسالة الخطأ هي: $e"
            : 'An error occured. Please try again later.\n error message is: $e',
      );
    }
  }
}
