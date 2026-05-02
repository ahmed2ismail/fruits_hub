import 'package:flutter/material.dart';
import 'package:fruits_hub/features/onBoarding/presentation/widgets/dots_indicator.dart';
import 'package:fruits_hub/features/onBoarding/presentation/widgets/get_started_button.dart';
import 'package:fruits_hub/features/onBoarding/presentation/widgets/on_boarding_page_view.dart';
import 'package:fruits_hub/features/onBoarding/presentation/widgets/skip_button.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late final PageController _pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              // للتأكد من أن المحتوى يملأ الشاشة حتى لو كان قصيرًا
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top content (PageView, Skip button, Dots)
                  Column(
                    children: [
                      Stack(
                        children: [
                          OnBoardingPageView(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPageIndex = index;
                              });
                            },
                          ),
                          Positioned(
                            right: 16,
                            top: 20,
                            child: SkipButton(
                              pageController: _pageController,
                              currentPageIndex: _currentPageIndex,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 64),
                      CustomDotsIndicator(
                        currentPageIndex: _currentPageIndex,
                        dotsCount: 2,
                      ),
                    ],
                  ),
                  // Bottom content (Get Started button)
                  GetStartedButton(currentPageIndex: _currentPageIndex),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
