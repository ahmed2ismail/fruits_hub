import 'package:flutter/material.dart';
import 'package:fruits_hub/features/home/presentation/widgets/featured_item.dart';

class FeaturedList extends StatelessWidget {
  const FeaturedList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(
          5,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: FeaturedItem(),
          ),
        ),
      ),
    );
  }
}
