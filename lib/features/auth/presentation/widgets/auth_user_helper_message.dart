import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';

class AuthUserHelperMessage extends StatelessWidget {
  const AuthUserHelperMessage({super.key, required this.text, this.color});

  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: TextStyles.semiBold16.copyWith(
          color: color ?? AppColors.grayscale600,
          height: 1.40,
        ),
      ),
    );
  }
}
