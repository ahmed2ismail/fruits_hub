import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundWhiteColor,
      centerTitle: true,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyles.bold19.copyWith(color: AppColors.grayscale950),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new),
      ),
    );
  }

  // الارتفاع المفضل للـ AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  // kToolbarHeight هو ارتفاع الـ AppBar الافتراضي في فلاتر، ويمكن تغييره و تعديله
}
