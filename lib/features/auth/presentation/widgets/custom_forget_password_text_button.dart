import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:fruits_hub/generated/l10n.dart';

class CustomForgetPasswordAndRecoveryTextButton extends StatelessWidget {
  const CustomForgetPasswordAndRecoveryTextButton({
    super.key,
    this.onPressed,
    this.text,
    this.textStyle,
    this.alignment,
  });

  final Function()? onPressed;
  final String? text;
  final TextStyle? textStyle;
  final AlignmentGeometry? alignment;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? AlignmentDirectional.centerEnd,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          overlayColor: Colors.transparent,
        ),
        child: Text(
          text ?? S.of(context).forgotPasswordText,
          style:
              textStyle ??
              TextStyles.semiBold13.copyWith(
                color: AppColors.green1_600,
                height: 1.70,
              ),
        ),
      ),
    );
  }
}
