import 'package:flutter/material.dart';
import 'package:fruits_hub/core/helper/functions/get_current_local.dart';
import 'package:fruits_hub/core/services/shared_preferences_singleton.dart';
import 'package:fruits_hub/core/utils/app_constants.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/features/auth/presentation/view/login_view.dart';
import 'package:fruits_hub/features/onBoarding/presentation/view/on_boarding_view.dart';
import 'package:svg_flutter/svg.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    super.initState();

    _executeNavigation();
  }

  void _executeNavigation() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        final bool onboardingVisited = Prefs.getBool(
          AppConstants.kOnboardingVisitedKey,
        );

        if (onboardingVisited) {
          // If onboarding was visited, go to login and remove splash from stack
          Navigator.pushReplacementNamed(context, LoginView.routeName);
        } else {
          // If onboarding was not visited, go to onboarding and remove splash from stack
          Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: isEnglish()
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [SvgPicture.asset(AppAssets.imagesPlant)],
          ),
          SvgPicture.asset(AppAssets.imagesLogo),
          SvgPicture.asset(AppAssets.imagesSplashBottom),
        ],
      ),
    );
  }
}
