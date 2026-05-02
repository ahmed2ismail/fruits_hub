import 'package:flutter/material.dart';
import 'package:fruits_hub/core/services/shared_preferences_singleton.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_constants.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/generated/l10n.dart';
import 'package:fruits_hub/features/auth/presentation/view/login_view.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key, required this.currentPageIndex});

  final int currentPageIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.5),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: currentPageIndex == 1
          ? Column(
              key: const ValueKey('GetStarted'),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16, top: 29),
                  child: MaterialButton(
                    onPressed: () {
                      Prefs.setBool(
                        key: AppConstants.kOnboardingVisitedKey,
                        value: true,
                      );
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        LoginView.routeName,
                        (route) => false,
                      );
                    },
                    minWidth: double.infinity,
                    height: 54,
                    color: AppColors.green1_500,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      S.of(context).OnBoardingWelcomePrefixButton,
                      textAlign: TextAlign.center,
                      style: TextStyles.bold16.copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 43),
              ],
            )
          // Use a SizedBox with the same total height to prevent layout jumps during animation.
          : const SizedBox(key: ValueKey('Empty'), height: 54 + 43),
    );
  }
}
