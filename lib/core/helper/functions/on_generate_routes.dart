import 'package:flutter/material.dart';
import 'package:fruits_hub/features/auth/presentation/view/forgot_password_view.dart';
import 'package:fruits_hub/features/auth/presentation/view/signin_view.dart';
import 'package:fruits_hub/features/auth/presentation/view/password_recovery_view.dart';
import 'package:fruits_hub/features/auth/presentation/view/reset_password_view.dart';
import 'package:fruits_hub/features/auth/presentation/view/signup_view.dart';
import 'package:fruits_hub/features/best_seller_fruits/presentation/view/best_seller_fruits.dart';
import 'package:fruits_hub/features/home/presentation/view/home_view.dart';
import 'package:fruits_hub/features/onBoarding/presentation/view/on_boarding_view.dart';
import 'package:fruits_hub/features/splash/presentation/view/splash_view.dart';

// this function is declared in the lib/core/helper/functions/on_generate_routes.dart file and is used in the main.dart file to generate routes for the app. It takes a RouteSettings object as a parameter and returns a Route object. The RouteSettings object contains the name of the route that is being navigated to. The function uses a switch statement to determine which route to return based on the name of the route. If the name of the route matches one of the cases in the switch statement, it returns a MaterialPageRoute with the corresponding view. If the name of the route does not match any of the cases, it returns a MaterialPageRoute with the SplashView as the default view.
// في ال MaterialApp:
// onGenerateRoute: onGenerateRoute,
// initialRoute: SplashView.routeName,

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    // the route name is defined in the SplashView class as a static constant variable.
    // const String routeName = 'splash_view' is defined in SplashView class

    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());

    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());

    case SigninView.routeName:
      return MaterialPageRoute(builder: (context) => const SigninView());

    case SignupView.routeName:
      return MaterialPageRoute(builder: (context) => const SignupView());

    case ForgotPasswordView.routeName:
      return MaterialPageRoute(
        builder: (context) => const ForgotPasswordView(),
      );

    case PasswordRecoveryView.routeName:
      return MaterialPageRoute(
        builder: (context) => const PasswordRecoveryView(),
      );

    case ResetPasswordView.routeName:
      return MaterialPageRoute(builder: (context) => const ResetPasswordView());

    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());

    case BestSellerFruits.routeName:
      return MaterialPageRoute(builder: (context) => const BestSellerFruits());

    default:
      return MaterialPageRoute(builder: (context) => const SplashView());
  }
}
