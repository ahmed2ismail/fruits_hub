import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/generated/l10n.dart';

class FeaturedItemTextButton extends StatelessWidget {
  const FeaturedItemTextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(const EdgeInsets.all(3)),
        backgroundColor: WidgetStateProperty.all(Colors.white),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 4),
        child: Text(
          S.of(context).shopNowText,
          style: TextStyles.bold13.copyWith(color: AppColors.green1_500),
        ),
      ),
      onPressed: () {},
    );
  }
}
