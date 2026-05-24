import 'package:flutter/material.dart';
import 'package:fruits_hub/core/helper/functions/get_current_local.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/features/home/presentation/widgets/featured_item_text_button.dart';
import 'package:fruits_hub/generated/l10n.dart';
import 'package:svg_flutter/svg.dart';
import 'package:svg_image_provider/svg_image_provider.dart';

class FeaturedItem extends StatelessWidget {
  const FeaturedItem({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width - 32;
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(4),
      child: SizedBox(
        width: screenWidth,
        child: AspectRatio(
          aspectRatio: 342 / 158,
          child: Stack(
            children: [
              Positioned.directional(
                textDirection: isArabic()
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                start: screenWidth * 0.4,
                end: 0,
                top: 0,
                bottom: 0,
                child: SvgPicture.asset(
                  AppAssets.imagesPageViewItem2Image,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: screenWidth * 0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: SvgImageProvider(
                      AppAssets.imagesFeaturedItemBackground,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsGeometry.directional(start: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25),
                      Text(
                        S.of(context).featuredDealsText,
                        style: TextStyles.regular13.copyWith(
                          color: Colors.white,
                          height: 1.60,
                        ),
                      ),
                      Spacer(),
                      Text(
                        S.of(context).featuredDealsDiscountText,
                        style: TextStyles.bold19.copyWith(color: Colors.white),
                      ),
                      SizedBox(height: 11),
                      FeaturedItemTextButton(),
                      SizedBox(height: 29),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
