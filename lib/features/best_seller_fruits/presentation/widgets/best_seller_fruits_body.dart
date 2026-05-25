import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fruits_hub/features/home/presentation/widgets/best_seller_heading.dart';
import 'package:fruits_hub/features/home/presentation/widgets/best_seller_list_grid_view.dart';

class BestSellerFruitsBody extends StatelessWidget {
  const BestSellerFruitsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          },
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24),
                  BestSellerHeading(showSeeMore: false),
                  SizedBox(height: 8),
                ],
              ),
            ),
            BestSellerListGridView(),
          ],
        ),
      ),
    );
  }
}
