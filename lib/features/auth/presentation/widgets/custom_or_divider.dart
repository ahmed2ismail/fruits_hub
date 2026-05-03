import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/generated/l10n.dart';

class CustomOrDivider extends StatelessWidget {
  const CustomOrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // الخط الأفقي الأيسر
        const Expanded(
          child: Divider(
            color: AppColors.graylight,
            thickness: 1.0, // سمك الخط
          ),
        ),

        // مسافة صغيرة بين الخط والنص
        const SizedBox(width: 16.0),

        Text(
          S.of(context).orText,
          style: TextStyles.semiBold16.copyWith(
            color: AppColors.grayscale950,
            height: 1.40,
          ),
        ),

        // مسافة صغيرة بين النص والخط
        const SizedBox(width: 16.0),

        // الخط الأفقي الأيمن
        const Expanded(
          child: Divider(color: AppColors.graylight, thickness: 1.0),
        ),
      ],
    );
  }
}
