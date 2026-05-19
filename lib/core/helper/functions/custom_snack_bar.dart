import 'package:flutter/material.dart';

// بنحدد أنواع الرسائل عشان نغير اللون والأيقونة بناءً عليها
enum SnackBarType { success, error, warning }

void showCustomSnackBar(
  BuildContext context, {
  required String message,
  SnackBarType type = SnackBarType.error, // الخطأ هو الافتراضي
}) {
  Color backgroundColor;
  IconData icon;

  // تحديد الشكل بناءً على نوع الرسالة
  switch (type) {
    case SnackBarType.success:
      backgroundColor = const Color(0xFF2ECC71); // لون أخضر للنجاح
      icon = Icons.check_circle_outline_rounded;
      break;
    case SnackBarType.error:
      backgroundColor = const Color(0xFFE74C3C); // لون أحمر للخطأ
      icon = Icons.error_outline_rounded;
      break;
    case SnackBarType.warning:
      backgroundColor = const Color(0xFFF39C12); // لون برتقالي للتحذير
      icon = Icons.warning_amber_rounded;
      break;
  }

  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor:
        Colors.transparent, // بنخلي الخلفية شفافة عشان الـ Container يظهر
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12), // حواف دائرية احترافية
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withValues(
              alpha: 0.4,
            ), // ظل خفيف بنفس لون الرسالة
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // إخفاء أي رسالة قديمة قبل عرض الجديدة
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
