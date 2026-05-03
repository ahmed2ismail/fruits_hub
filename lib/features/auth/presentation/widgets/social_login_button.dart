import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:svg_flutter/svg.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback onPressed;

  const SocialLoginButton({
    super.key,
    required this.text,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.5),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            // تحديد لون وسمك الإطار الخارجي
            side: const BorderSide(color: AppColors.whiteShift, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SvgPicture.asset(iconPath, height: 24, width: 24),
            title: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyles.semiBold16.copyWith(
                color: AppColors.grayscale950, // لون مقارب للأسود
                height: 1.40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
