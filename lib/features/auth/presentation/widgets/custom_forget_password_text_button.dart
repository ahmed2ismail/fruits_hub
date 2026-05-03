import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_constants.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:fruits_hub/generated/l10n.dart';

class CustomForgetPasswordTextButton extends StatelessWidget {
  const CustomForgetPasswordTextButton({
    super.key, this.onPressed,
  });

  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.kHorizontalPadding16,
      ),
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            overlayColor: Colors.transparent,
          ),
          child: Text(
            S.of(context).forgotPasswordText,
            style: TextStyles.semiBold13.copyWith(
              color: AppColors.green1_600,
              height: 1.70,
            ),
          ),
        ),
      ),
    );
  }
}
