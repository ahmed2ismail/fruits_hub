import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/features/home/domain/entities/bottom_navigation_bar_entity.dart';

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({
    super.key,
    required this.isActive,
    required this.item,
  });

  final bool isActive;
  final BottomNavigationBarEntity item;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: isActive
          ? ActiveItem(image: item.activeImage, sectionName: item.sectionName)
          : InActiveItem(image: item.inActiveImage),
    );
  }
}

class InActiveItem extends StatelessWidget {
  const InActiveItem({super.key, required this.image});

  final String image;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      image,
      width: 20,
      height: 20,
      fit: BoxFit.scaleDown,
    );
  }
}

class ActiveItem extends StatelessWidget {
  const ActiveItem({super.key, required this.image, required this.sectionName});

  final String image, sectionName;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: AppColors.white_2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: ShapeDecoration(
              color: AppColors.green1_500,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: SvgPicture.asset(image, fit: BoxFit.scaleDown),
          ),
          SizedBox(width: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              sectionName,
              style: TextStyles.semiBold11.copyWith(
                color: AppColors.green1_500,
                height: 1.40,
              ),
            ),
          ),
          SizedBox(width: 7),
        ],
      ),
    );
  }
}
