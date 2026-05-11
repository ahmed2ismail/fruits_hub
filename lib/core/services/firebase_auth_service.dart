import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fruits_hub/core/error/exceptions.dart';
import 'package:fruits_hub/core/helper/functions/get_current_local.dart';
import 'package:google_sign_in/google_sign_in.dart';

CustomException _handleFirebaseAuthException(FirebaseAuthException e) {
  String message;
  final isArabicLocale = isArabic();

  switch (e.code) {
    // --- حالات بيانات الاعتماد وتسجيل الدخول ---
    case 'invalid-credential':
    case 'user-not-found':
    case 'wrong-password':
      message = isArabicLocale
          ? 'بيانات الاعتماد غير صالحة. يرجى التأكد من صحة البريد الإلكتروني وكلمة المرور.'
          : 'Invalid credentials. Please check your email and password.';
      break;

    // --- حالات إنشاء حساب جديد ---
    case 'email-already-in-use':
      message = isArabicLocale
          ? 'هذا البريد الإلكتروني مستخدم بالفعل. يرجى تسجيل الدخول بدلاً من ذلك.'
          : 'This email is already in use. Please sign in instead.';
      break;
    case 'weak-password':
      message = isArabicLocale
          ? 'كلمة المرور التي أدخلتها ضعيفة جدًا.'
          : 'The password provided is too weak.';
      break;

    // --- حالات التحقق من المدخلات ---
    case 'invalid-email':
      message = isArabicLocale
          ? 'البريد الإلكتروني الذي أدخلته غير صالح.'
          : 'The email address you entered is not valid.';
      break;
    case 'missing-email':
      message = isArabicLocale
          ? 'البريد الإلكتروني مفقود. يرجى إدخاله.'
          : 'The email address is missing. Please enter it.';
      break;
    case 'invalid-phone-number':
      message = isArabicLocale
          ? 'رقم الهاتف الذي أدخلته غير صالح.'
          : 'The phone number you entered is not valid.';
      break;
    case 'missing-phone-number':
      message = isArabicLocale
          ? 'رقم الهاتف مفقود. يرجى إدخاله.'
          : 'The phone number is missing. Please enter it.';
      break;

    // --- حالات حالة الحساب ---
    case 'user-disabled':
      message = isArabicLocale
          ? 'تم تعطيل هذا الحساب. يرجى التواصل مع الدعم.'
          : 'This user account has been disabled.';
      break;

    // --- حالات تسجيل الدخول الاجتماعي (Google, Apple, etc.) ---
    case 'account-exists-with-different-credential':
      message = isArabicLocale
          ? 'يوجد حساب بالفعل بنفس البريد الإلكتروني ولكن ببيانات اعتماد مختلفة (مثل جوجل أو فيسبوك). حاول تسجيل الدخول بالطريقة الأخرى.'
          : 'An account already exists with the same email address but different sign-in credentials. Try signing in with the other method.';
      break;
    case 'credential-already-in-use':
      message = isArabicLocale
          ? 'هذا الحساب الاجتماعي (مثل جوجل) مرتبط بالفعل بحساب مستخدم آخر.'
          : 'This social account (e.g., Google) is already linked to another user account.';
      break;
    case 'no-such-provider':
      message = isArabicLocale
          ? 'طريقة تسجيل الدخول هذه غير مفعلة.'
          : 'This sign-in provider is not enabled.';
      break;

    // --- حالات رموز التحقق وإعادة تعيين كلمة المرور ---
    case 'invalid-verification-code':
      message = isArabicLocale
          ? 'رمز التحقق الذي أدخلته غير صالح.'
          : 'The verification code you entered is invalid.';
      break;
    case 'invalid-verification-id':
      message = isArabicLocale
          ? 'معرّف التحقق غير صالح. يرجى إعادة إرسال الرمز.'
          : 'The verification ID is invalid. Please resend the code.';
      break;
    case 'expired-action-code':
      message = isArabicLocale
          ? 'انتهت صلاحية الرمز. يرجى طلب رمز جديد.'
          : 'The action code has expired. Please request a new one.';
      break;
    case 'invalid-action-code':
      message = isArabicLocale
          ? 'رمز الإجراء غير صالح. قد يكون الرمز غير صحيح أو منتهي الصلاحية أو تم استخدامه بالفعل.'
          : 'The action code is invalid. This may have happened if the code is malformed, expired, or has already been used.';
      break;

    // --- حالات الشبكة والسيرفر ---
    case 'network-request-failed':
      message = isArabicLocale
          ? 'فشل طلب الشبكة. يرجى التحقق من اتصالك بالإنترنت.'
          : 'Network request failed. Please check your internet connection.';
      break;
    case 'too-many-requests':
      message = isArabicLocale
          ? 'لقد تجاوزت الحد المسموح به من المحاولات. يرجى المحاولة مرة أخرى لاحقاً أو التواصل مع الدعم.'
          : 'Too many requests. Please try again later or contact support.';
      break;
    case 'timeout':
      message = isArabicLocale
          ? 'انتهت مهلة العملية. يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى.'
          : 'The operation timed out. Please check your internet connection and try again.';
      break;
    case 'channel-error':
      message = isArabicLocale
          ? 'حدث خطأ في الاتصال. يرجى التأكد من إدخال جميع البيانات بشكل صحيح.'
          : 'A channel error occurred. Please ensure all fields are filled correctly.';
      break;

    // --- حالات إعدادات Firebase والمشروع ---
    case 'operation-not-allowed':
      message = isArabicLocale
          ? 'هذه العملية غير مسموح بها. (قد تكون طريقة تسجيل الدخول غير مفعلة في Firebase).'
          : 'This operation is not allowed. (The sign-in method may be disabled in Firebase).';
      break;
    case 'app-not-authorized':
      message = isArabicLocale
          ? 'التطبيق غير مصرح له باستخدام مصادقة Firebase مع مفتاح API المقدم.'
          : 'This app is not authorized to use Firebase Authentication with the provided API key.';
      break;
    case 'invalid-api-key':
      message = isArabicLocale
          ? 'مفتاح API المستخدم غير صالح. يرجى مراجعة إعدادات المشروع.'
          : 'The API key used is invalid. Please check your project configuration.';
      break;
    case 'app-deleted':
      message = isArabicLocale
          ? 'تم حذف مشروع Firebase هذا.'
          : 'This Firebase project has been deleted.';
      break;
    case 'quota-exceeded':
      message = isArabicLocale
          ? 'تم تجاوز الحصة المسموح بها للمشروع. يرجى المحاولة لاحقاً.'
          : 'The project quota has been exceeded. Please try again later.';
      break;

    // --- حالات الجلسة (Session) والأمان ---
    case 'requires-recent-login':
      message = isArabicLocale
          ? 'هذه العملية حساسة وتتطلب إعادة تسجيل الدخول لضمان الأمان.'
          : 'This operation requires recent authentication. Please log in again.';
      break;
    case 'user-token-expired':
      message = isArabicLocale
          ? 'انتهت صلاحية الجلسة. يرجى تسجيل الدخول مرة أخرى.'
          : 'The user token has expired. Please log in again.';
      break;

    // --- حالات خاصة بالويب ---
    case 'web-context-cancelled':
      message = isArabicLocale
          ? 'تم إلغاء العملية من قبل المستخدم.'
          : 'The operation was cancelled by the user.';
      break;
    case 'web-storage-unsupported':
      message = isArabicLocale
          ? 'هذا المتصفح لا يدعم التخزين المطلوب للمصادقة.'
          : 'This browser does not support the required storage for authentication.';
      break;

    // --- الحالة الافتراضية للأخطاء غير المتوقعة ---
    default:
      message = isArabicLocale
          ? "حدث خطأ غير معروف. يرجى المحاولة مرة أخرى."
          : 'An unknown error occurred. Please try again.';
  }
  return CustomException(message);
}

class FirebaseAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // After creating the user, update their profile with the provided name.
      if (credential.user != null) {
        await credential.user!.updateDisplayName(name);
      }
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        log(
          'Exception in FirebaseAuthService.createUserWithEmailAndPassword(FirebaseAuthException): ${e.toString()} and code is ${e.code}',
        );
      }
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      // Handle other exceptions.
      if (kDebugMode) {
        log(
          'Exception in FirebaseAuthService.createUserWithEmailAndPassword(catch_Exception): ${e.toString()} and code is ${e.runtimeType}',
        );
      }
      throw CustomException(
        isArabic()
            ? "حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى."
            : 'An unexpected error occurred. Please try again.',
      );
    }
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        log(
          'Exception in FirebaseAuthService.signInWithEmailAndPassword(FirebaseAuthException): ${e.toString()} and code is ${e.code}',
        );
      }
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      if (kDebugMode) {
        log(
          'Exception in FirebaseAuthService.signInWithEmailAndPassword(catch_Exception): ${e.toString()} and code is ${e.runtimeType}',
        );
      }
      throw CustomException(
        isArabic()
            ? "حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى."
            : 'An unexpected error occurred. Please try again.',
      );
    }
  }

  Future<User> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // If the user cancels the sign-in flow, googleUser will be null.
      if (googleUser == null) {
        // User cancelled the login
        throw FirebaseAuthException(code: 'web-context-cancelled');
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        log(
          'Exception in FirebaseAuthService.signInWithGoogle(FirebaseAuthException): ${e.toString()} and code is ${e.code}',
        );
      }
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      if (kDebugMode) {
        log(
          'Exception in FirebaseAuthService.signInWithGoogle(catch_Exception): ${e.toString()} and code is ${e.runtimeType}',
        );
      }
      throw CustomException(
        isArabic()
            ? "حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى."
            : 'An unexpected error occurred. Please try again.',
      );
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
