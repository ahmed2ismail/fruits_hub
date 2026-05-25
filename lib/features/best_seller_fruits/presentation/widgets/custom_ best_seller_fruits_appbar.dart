// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/core/widgets/notification_widget.dart';
import 'package:fruits_hub/generated/l10n.dart';

class CustomBestSellerFruitsAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomBestSellerFruitsAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // يمنع تغيير لون الـ AppBar عند التمرير في Material 3
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      centerTitle: true,
      title: Text(
        S.of(context).bestSeller,
        textAlign: TextAlign.right,
        style: TextStyles.bold19.copyWith(color: AppColors.grayscale950),
      ),
      actions: [NotificationWidget()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
