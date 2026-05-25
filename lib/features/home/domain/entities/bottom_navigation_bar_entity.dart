import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/generated/l10n.dart';

class BottomNavigationBarEntity {
  final String activeImage, inActiveImage, sectionName;

  BottomNavigationBarEntity({
    required this.activeImage,
    required this.inActiveImage,
    required this.sectionName,
  });
}

List<BottomNavigationBarEntity> bottomNavigationBarItems(BuildContext context) {
  return [
    BottomNavigationBarEntity(
      activeImage: AppAssets.imagesVuesaxBoldHome,
      inActiveImage: AppAssets.imagesVuesaxOutlineHome,
      sectionName: S.of(context).main,
    ),
    BottomNavigationBarEntity(
      activeImage: AppAssets.imagesVuesaxBoldProducts,
      inActiveImage: AppAssets.imagesVuesaxOutlineProducts,
      sectionName: S.of(context).products,
    ),
    BottomNavigationBarEntity(
      activeImage: AppAssets.imagesVuesaxBoldShoppingCart,
      inActiveImage: AppAssets.imagesVuesaxOutlineShoppingCart,
      sectionName: S.of(context).cart,
    ),
    BottomNavigationBarEntity(
      activeImage: AppAssets.imagesVuesaxBoldUser,
      inActiveImage: AppAssets.imagesVuesaxOutlineUser,
      sectionName: S.of(context).profile,
    ),
  ];
}
