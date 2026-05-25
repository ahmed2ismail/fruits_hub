import 'package:flutter/material.dart';
import 'package:fruits_hub/core/widgets/fruit_item.dart';

class BestSellerListGridView extends StatelessWidget {
  const BestSellerListGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 16,
        childAspectRatio: 163 / 214,
      ),
      itemBuilder: (context, index) => FruitItem(),
      itemCount: 6,
    );
  }
}
