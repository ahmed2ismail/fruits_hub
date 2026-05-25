import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/features/home/domain/entities/bottom_navigation_bar_entity.dart';
import 'package:fruits_hub/features/home/presentation/widgets/bottom_navigation_bar_item.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 375 / 70,
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          shadows: [
            BoxShadow(
              color: AppColors.shadowColorSide,
              blurRadius: 7,
              offset: Offset(0, -2),
              spreadRadius: 4,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: bottomNavigationBarItems(context)
              .asMap()
              .entries
              .map(
                (entry) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = entry.key;
                    });
                  },
                  child: NavigationBarItem(
                    isActive: entry.key == selectedIndex,
                    item: entry.value,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
