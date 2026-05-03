import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';

class CustomCheckHaveAccountTextSpan extends StatelessWidget {
  const CustomCheckHaveAccountTextSpan({
    super.key,
    required this.mainText,
    required this.subText,
    required this.subTextOnTap,
  });

  final String mainText;
  final String subText;
  final VoidCallback? subTextOnTap;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: mainText,
        style: TextStyles.semiBold16.copyWith(
          color: AppColors.grayscale400,
          height: 1.40,
        ),
        children: [
          TextSpan(
            text: subText,
            // السطر دا لجعل النص قابلاً للضغط
            recognizer: TapGestureRecognizer()..onTap = subTextOnTap,
            style: TextStyles.semiBold16.copyWith(
              color: AppColors.green1_500,
              height: 1.40,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
