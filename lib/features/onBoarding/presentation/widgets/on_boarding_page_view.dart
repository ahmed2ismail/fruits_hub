import 'dart:ui';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/generated/l10n.dart';
import 'package:fruits_hub/features/onBoarding/presentation/widgets/page_view_item.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key, this.onPageChanged, this.controller});

  final ValueChanged<int>? onPageChanged;
  final PageController? controller;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad,
        },
      ),
      child: ExpandablePageView(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        animateFirstPage: true,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
        onPageChanged: onPageChanged,
        children: [
          PageViewItem(
            backgroundImage: AppAssets.imagesPageViewItem1BackgroundImage,
            image: AppAssets.imagesPageViewItem1Image,
            title: TextSpan(
              text: S.of(context).onBoardingWelcomePrefix,
              style: TextStyles.bold23.copyWith(color: AppColors.grayscale950),
              children: [
                TextSpan(
                  text: 'Fruit',
                  style: TextStyles.bold23.copyWith(
                    color: AppColors.green1_500,
                  ),
                ),
                TextSpan(
                  text: 'HUB',
                  style: TextStyles.bold23.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
            subTitle: S.of(context).onBoardingSubtitle1,
          ),
          PageViewItem(
            backgroundImage: AppAssets.imagesPageViewItem2BackgroundImage,
            image: AppAssets.imagesPageViewItem2Image,
            title: TextSpan(
              text: S.of(context).onBoardingFreshFruitsPrefix,
              style: TextStyles.bold23.copyWith(color: AppColors.grayscale950),
            ),
            subTitle: S.of(context).onBoardingSubtitle2,
          ),
        ],
      ),
    );
  }
}
