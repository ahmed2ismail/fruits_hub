import 'package:flutter/material.dart';
import 'package:fruits_hub/core/helper/functions/get_current_local.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:svg_flutter/svg.dart';

class FruitItem extends StatelessWidget {
  const FruitItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: AppColors.white_1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: Stack(
        children: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppAssets.imagesHeart,
              fit: BoxFit.fill,
              width: 22,
              height: 22,
            ),
          ),
          Positioned.directional(
            textDirection: isArabic() ? TextDirection.rtl : TextDirection.ltr,
            start: 0,
            end: 0,
            top: 0,
            bottom: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 20.0,
                    bottom: 24.0,
                    start: 16,
                    end: 16,
                  ),
                  child: Image.asset(
                    AppAssets.imagesWatermelonTest,
                    fit: BoxFit.fill,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  title: Text(
                    'بطيخ',
                    textAlign: TextAlign.right,
                    style: TextStyles.semiBold13.copyWith(
                      color: AppColors.grayscale950,
                      height: 1.70,
                    ),
                  ),
                  subtitle: Text.rich(
                    textAlign: isArabic() ? TextAlign.right : TextAlign.left,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '20جنية ',
                          style: TextStyles.bold13.copyWith(
                            color: AppColors.orange500,
                          ),
                        ),
                        TextSpan(
                          text: '/',
                          style: TextStyles.bold13.copyWith(
                            color: AppColors.orange300,
                          ),
                        ),
                        TextSpan(
                          text: ' الكيلو',
                          style: TextStyles.semiBold13.copyWith(
                            color: AppColors.orange300,
                            height: 1.70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.green1_500,
                    child: Icon(Icons.add, color: Colors.white, size: 24),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
