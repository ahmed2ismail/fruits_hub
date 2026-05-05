import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:svg_flutter/svg.dart';

class CustomSuccessDialog extends StatelessWidget {
  const CustomSuccessDialog({
    super.key,
    required this.message,
    required this.iconPath,
  });

  final String message;
  final String iconPath;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: AppColors.backgroundWhiteColor,
      // التحكم في المسافات الخارجية للـ Dialog عشان ميكونش لازق في الشاشة
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        child: Column(
          // mainAxisSize: MainAxisSize.min مهمة جداً عشان الـ Dialog ياخد مساحة المحتوى بس وميمتدش بطول الشاشة
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(iconPath),
            const SizedBox(height: 24),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyles.bold16.copyWith(color: AppColors.grayscale950),
            ),
          ],
        ),
      ),
    );
  }
}
