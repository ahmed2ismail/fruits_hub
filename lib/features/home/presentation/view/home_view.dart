import 'package:flutter/material.dart';
import 'package:fruits_hub/features/home/presentation/widgets/custom_home_appbar.dart';
import 'package:fruits_hub/features/home/presentation/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const routeName = 'home_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHomeAppbar(),
      body: SafeArea(child: HomeViewBody()),
    );
  }
}
