import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:svg_flutter/svg.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.image,
    required this.backgroundImage,
    required this.subTitle,
    required this.title,
  });

  final String image, backgroundImage, subTitle;
  final TextSpan title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.5,
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(backgroundImage, fit: BoxFit.fill),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SvgPicture.asset(image, fit: BoxFit.scaleDown),
              ),
            ],
          ),
        ),
        const SizedBox(height: 64), // المسافة بين قسم الصورة والعنوان
        Text.rich(title, textAlign: TextAlign.center),
        const SizedBox(height: 24), // المسافة بين العنوان والعنوان الفرعي
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 37),
          child: Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyles.semiBold13.copyWith(
              color: AppColors.grayscale500,
            ),
          ),
        ),
      ],
    );
  }
}
