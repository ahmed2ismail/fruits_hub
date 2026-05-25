import 'package:flutter/material.dart';
import 'package:fruits_hub/features/best_seller_fruits/presentation/widgets/best_seller_fruits_body.dart';
import 'package:fruits_hub/features/best_seller_fruits/presentation/widgets/custom_%20best_seller_fruits_appbar.dart';

class BestSellerFruits extends StatelessWidget {
  const BestSellerFruits({super.key});

  static const routeName = 'best_seller_fruits';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBestSellerFruitsAppbar(),
      body: SafeArea(child: BestSellerFruitsBody()),
    );
  }
}
