import 'package:flutter/material.dart';
import 'package:fruits_hub/features/best_seller_fruits/presentation/view/best_seller_fruits.dart';
import 'package:fruits_hub/generated/l10n.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';

class BestSellerHeading extends StatelessWidget {
  const BestSellerHeading({super.key, this.showSeeMore = true});

  final bool showSeeMore;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).bestSeller,
          textAlign: TextAlign.right,
          style: TextStyles.bold16.copyWith(color: AppColors.grayscale950),
        ),
        showSeeMore
            ? TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, BestSellerFruits.routeName);
                },
                style: TextButton.styleFrom(overlayColor: Colors.transparent),
                child: Text(
                  S.of(context).seeMore,
                  textAlign: TextAlign.center,
                  style: TextStyles.regular13.copyWith(
                    color: AppColors.grayscale400,
                    height: 1.60,
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
