import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fruits_hub/core/error/exceptions.dart';
import 'package:fruits_hub/core/helper/functions/get_current_local.dart';

CustomException _handleFirebaseAuthException(FirebaseAuthException e) {
  String message;
  final isArabicLocale = isArabic();
  switch (e.code) {
    case 'weak-password':
      message = isArabicLocale
          ? 'كلمة المرور ضعيفة جدا.'
          : 'The password provided is too weak.';
      break;
    case 'email-already-in-use':
      message = isArabicLocale
          ? 'البريد الإلكتروني مستخدم بالفعل. قم بتسجيل الدخول'
          : 'The account already exists for that email. Signin instead.';
      break;
    case 'invalid-email':
      message = isArabicLocale
          ? 'البريد الإلكتروني الذي أدخلته غير صالح.'
          : 'The email address you entered is not valid.';
      break;
    case 'user-not-found':
      message = isArabicLocale
          ? 'هذا المستخدم غير موجود. اسم المستخدم أو كلمة المرور غير صحيحة'
          : 'No user found for that email or username.';
      break;
    case 'wrong-password':
      message = isArabicLocale
          ? 'كلمة المرور التي أدخلتها غير صحيحة.'
          : 'Wrong password provided for that user.';
      break;
    case 'network-request-failed':
      message = isArabicLocale
          ? 'لا يوجد اتصال بالإنترنت. تأكد من اتصالك بالإنترنت وحاول مرة أخرى.'
          : 'No internet connection. Please check your internet connection and try again.';
      break;
    case 'too-many-requests':
      message = isArabicLocale
          ? 'لقد تجاوزت الحد المسموح به من المحاولات. يرجى المحاولة مرة أخرى لاحقاً.'
          : 'Too many requests. Please try again later.';
      break;
    case 'operation-not-allowed':
      message = isArabicLocale
          ? 'هذه العملية غير مسموح بها حالياً.'
          : 'Operation not allowed. Please contact support.';
      break;
    case 'user-disabled':
      message = isArabicLocale
          ? 'تم تعطيل هذا الحساب.'
          : 'This user account has been disabled.';
      break;
    case 'requires-recent-login':
      message = isArabicLocale
          ? 'هذه العملية تتطلب تسجيل الدخول مرة أخرى.'
          : 'This operation requires recent authentication. Please log in again.';
      break;
    case 'invalid-credential':
      message = isArabicLocale
          ? 'بيانات الاعتماد غير صالحة. يرجى التأكد من صحة البريد الإلكتروني وكلمة المرور.'
          : 'Invalid credentials. Please check your email and password.';
      break;
    case 'account-exists-with-different-credential':
      message = isArabicLocale
          ? 'الحساب موجود بالفعل مع بيانات اعتماد مختلفة.'
          : 'Account exists with different credentials.';
      break;
    case 'channel-error':
      message = isArabicLocale
          ? 'حدث خطأ في الاتصال. يرجى التأكد من إدخال جميع البيانات بشكل صحيح.'
          : 'Authentication error. Please make sure all fields are filled correctly.';
      break;
    case 'invalid-verification-code':
      message = isArabicLocale
          ? 'رمز التحقق غير صالح.'
          : 'The verification code is invalid.';
      break;
    case 'invalid-verification-id':
      message = isArabicLocale
          ? 'معرف التحقق غير صالح.'
          : 'The verification ID is invalid.';
      break;
    case 'quota-exceeded':
      message = isArabicLocale
          ? 'تم تجاوز الحصة المسموح بها. يرجى المحاولة لاحقاً.'
          : 'Quota exceeded. Please try again later.';
      break;
    case 'timeout':
      message = isArabicLocale
          ? 'انتهت مهلة العملية. يرجى المحاولة مرة أخرى.'
          : 'The operation timed out. Please try again.';
      break;
    case 'user-token-expired':
      message = isArabicLocale
          ? 'انتهت صلاحية الجلسة. يرجى تسجيل الدخول مرة أخرى.'
          : 'The user token has expired. Please log in again.';
      break;
    case 'null-user':
      message = isArabicLocale
          ? 'لم يتم العثور على بيانات المستخدم.'
          : 'No user data found.';
      break;
    case 'web-context-cancelled':
      message = isArabicLocale
          ? 'تم إلغاء العملية من قبل المستخدم.'
          : 'The operation was cancelled by the user.';
      break;
    case 'missing-email':
      message = isArabicLocale
          ? 'البريد الإلكتروني مفقود.'
          : 'The email address is missing.';
      break;
    case 'wrong-password-reset-code':
      message = isArabicLocale
          ? 'رمز إعادة تعيين كلمة المرور غير صالح.'
          : 'The password reset code is invalid.';
      break;
    case 'expired-action-code':
      message = isArabicLocale
          ? 'انتهت صلاحية الرمز. يرجى طلب رمز جديد.'
          : 'The action code has expired. Please request a new one.';
      break;

    default:
      message = isArabicLocale
          ? "حدث خطأ. يرجى المحاولة مرة أخرى في وقت لاحق."
          : 'An error occurred. Please try again later.';
  }
  return CustomException(message);
}

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
}
