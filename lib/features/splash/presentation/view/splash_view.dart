import 'package:flutter/material.dart';
import 'package:fruits_hub/features/splash/presentation/view/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  static const String routeName = 'splash_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const SplashViewBody());
  }
}
