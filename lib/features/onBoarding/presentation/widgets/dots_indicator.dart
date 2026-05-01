import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';

class CustomDotsIndicator extends StatelessWidget {
  const CustomDotsIndicator({
    super.key,
    required this.dotsCount,
    required this.currentPageIndex,
  });

  final int dotsCount;
  final int currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: dotsCount,
      position: currentPageIndex.toDouble(),
      // الخاصية الأهم هنا هي position. هذه الخاصية تخبر DotsIndicator أي نقطة يجب أن تكون "نشطة" (active).
      animate: true,
      decorator: DotsDecorator(
        activeColor: AppColors.green1_500,
        color: AppColors.greenLight.withValues(alpha: 0.5),
        activeSize: const Size(11, 11),
        size: const Size(9, 9),
        spacing: const EdgeInsets.symmetric(horizontal: 5),
        activeShape: const CircleBorder(),
        shape: const CircleBorder(),
      ),
    );
  }
}
