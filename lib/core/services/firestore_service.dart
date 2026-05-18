import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fruits_hub/core/error/exceptions.dart';
import 'package:fruits_hub/core/helper/functions/get_current_local.dart';
import 'package:fruits_hub/core/services/database_service.dart';

CustomException _handleFirebaseException(FirebaseException e) {
  String message;
  final isArabicLocale = isArabic();

  switch (e.code) {
    case 'permission-denied':
      message = isArabicLocale
          ? 'ليس لديك صلاحية للوصول إلى هذه البيانات.'
          : 'You do not have permission to access this data.';
      break;
    case 'unavailable':
      message = isArabicLocale
          ? 'الخدمة غير متوفرة حالياً. يرجى التحقق من اتصالك بالإنترنت.'
          : 'The service is currently unavailable. Please check your internet connection.';
      break;
    case 'not-found':
      message = isArabicLocale
          ? 'المستند المطلوب غير موجود.'
          : 'The requested document was not found.';
      break;
    case 'already-exists':
      message = isArabicLocale
          ? 'هذه البيانات موجودة بالفعل.'
          : 'This data already exists.';
      break;
    case 'deadline-exceeded':
      message = isArabicLocale
          ? 'انتهت مهلة الاتصال. يرجى المحاولة مرة أخرى.'
          : 'The connection timed out. Please try again.';
      break;
    case 'unauthenticated':
      message = isArabicLocale
          ? 'يجب تسجيل الدخول للقيام بهذه العملية.'
          : 'You must be authenticated to perform this operation.';
      break;
    default:
      message = isArabicLocale
          ? "حدث خطأ غير معروف. يرجى المحاولة مرة أخرى."
          : 'An unknown error occurred. Please try again.';
  }
  return CustomException(message);
}

class FireStoreService implements DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    try {
      if (documentId != null) {
        await _firestore.collection(path).doc(documentId).set(data);
      } else {
        await _firestore.collection(path).add(data);
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        log(
          'Exception in FireStoreService.addData(FirebaseException): ${e.toString()} and code is ${e.code}',
        );
      }
      throw _handleFirebaseException(e);
    } catch (e) {
      if (kDebugMode) {
        log(
          'Exception in FireStoreService.addData(catch_Exception): ${e.toString()} and code is ${e.runtimeType}',
        );
      }
      throw CustomException(
        isArabic()
            ? "حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى."
            : 'An unexpected error occurred. Please try again.',
      );
    }
  }

  @override
  Future<bool> checkIfDataExists({
    required String path,
    required String documentId,
  }) async {
    try {
      final document = await _firestore.collection(path).doc(documentId).get();
      return document.exists;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        log(
          'Exception in FireStoreService.checkIfDataExists(FirebaseException): ${e.toString()} and code is ${e.code}',
        );
      }
      throw _handleFirebaseException(e);
    } catch (e) {
      if (kDebugMode) {
        log(
          'Exception in FireStoreService.checkIfDataExists(catch_Exception): ${e.toString()} and code is ${e.runtimeType}',
        );
      }
      throw CustomException(
        isArabic()
            ? "حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى."
            : 'An unexpected error occurred. Please try again.',
      );
    }
  }

  @override
  Future<Map<String,dynamic>> getData({
    required String path,
    required String documentId,
  }) async {
    try {
      final document = await _firestore.collection(path).doc(documentId).get();
      if (document.exists && document.data() != null) {
        return document.data()!;
      } else {
        throw CustomException(
          isArabic()
              ? 'المستند المطلوب غير موجود.'
              : 'The requested document was not found.',
        );
      }
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        log(
          'Exception in FireStoreService.getData(FirebaseException): ${e.toString()} and code is ${e.code}',
        );
      }
      throw _handleFirebaseException(e);
    } on CustomException {
      // إعادة رمي الخطأ حتى لا يتم اصطياده في الـ catch العام
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        log(
          'Exception in FireStoreService.getData(catch_Exception): ${e.toString()} and code is ${e.runtimeType}',
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
