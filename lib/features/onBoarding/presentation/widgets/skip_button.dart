import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/generated/l10n.dart';
import 'package:fruits_hub/features/auth/presentation/view/login_view.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    super.key,
    required this.pageController,
    required this.currentPageIndex,
  });

  final PageController pageController;
  final int currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: currentPageIndex == 0 ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: IgnorePointer(
        ignoring: currentPageIndex != 0,
        child: TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginView.routeName,
              (route) => false,
            );
          },
          style: TextButton.styleFrom(overlayColor: Colors.transparent),
          child: Text(
            S.of(context).skipButton,
            style: TextStyles.regular13.copyWith(color: AppColors.grayscale400),
          ),
        ),
      ),
    );
  }
}
