import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/generated/l10n.dart';

class CustomDefaultAppButton extends StatelessWidget {
  const CustomDefaultAppButton({super.key, this.onPressed, this.text});

  final Function()? onPressed;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.green1_500,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(
        text ?? S.of(context).loginButtonText,
        textAlign: TextAlign.center,
        style: TextStyles.bold16.copyWith(color: Colors.white),
      ),
    );
  }
}
