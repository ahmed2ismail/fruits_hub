import 'package:flutter/material.dart';
import 'package:fruits_hub/core/di/injection_container.dart' as di;
import 'package:fruits_hub/core/helper/functions/get_current_local.dart';
import 'package:fruits_hub/core/services/firebase_auth_service.dart';
import 'package:fruits_hub/core/services/shared_preferences_singleton.dart';
import 'package:fruits_hub/core/utils/app_constants.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/features/auth/presentation/view/signin_view.dart';
import 'package:fruits_hub/features/home/presentation/view/home_view.dart';
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

    _checkUserAndExecuteNavigation();
  }

  void _checkUserAndExecuteNavigation() async {
    await Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        final bool onboardingVisited = Prefs.getBool(
          AppConstants.kOnboardingVisitedKey,
        );

        if (onboardingVisited) {
          // If onboarding was visited, go to signin and remove splash from stack

          // بنفحص هل فايربيز مخزن مستخدم حالياً؟
          bool isUserLoggedIn = di.sl<FirebaseAuthService>().isLoggedIn();
          // bool isUserLoggedIn =FirebaseAuth.instance.currentUser != null;
          if (isUserLoggedIn) {
            Navigator.pushReplacementNamed(context, HomeView.routeName);
          } else {
            Navigator.pushReplacementNamed(context, SigninView.routeName);
          }
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
