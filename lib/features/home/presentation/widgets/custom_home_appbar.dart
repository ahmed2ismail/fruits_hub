import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/generated/l10n.dart';
import 'package:svg_flutter/svg.dart';

class CustomHomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // يمنع تغيير لون الـ AppBar عند التمرير في Material 3
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Image.asset(AppAssets.imagesProfileImage),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).goodMorningProfileText,
            style: TextStyles.regular16.copyWith(color: AppColors.grayscale400),
          ),
          SizedBox(height: 5),
          Text(
            // TODO: Display User name from Firestore after logged in
            'أحمد مصطفي',
            style: TextStyles.bold16.copyWith(color: AppColors.grayscale950),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CircleAvatar(
            radius: 17,
            backgroundColor: AppColors.green60,
            child: SvgPicture.asset(AppAssets.imagesNotification),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
