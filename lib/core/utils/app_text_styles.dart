import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_constants.dart';

/// Calculates a responsive font size based on the screen width.
///
/// This function uses [PlatformDispatcher] to get the screen width, so it
/// doesn't require a [BuildContext].
double getResponsiveFontSize({required double fontSize}) {
  // Get screen width from PlatformDispatcher to avoid context dependency.
  final dispatcher = ui.PlatformDispatcher.instance;
  final physicalWidth = dispatcher.views.first.physicalSize.width;
  final devicePixelRatio = dispatcher.views.first.devicePixelRatio;
  final width = physicalWidth / devicePixelRatio;

  // Determine the scale factor based on screen width breakpoints.
  double scaleFactor = width < 600
      ? width / 400
      : width < 900
      ? width / 700
      : width / 1000;
  double responsiveFontSize = fontSize * scaleFactor;

  // Clamp the font size to prevent it from becoming too small or too large.
  // A more effective approach is to clamp based on the original `fontSize`.
  // Here, we clamp it to be between 80% and 120% of the *original* font size.
  double lowerLimit = fontSize * 0.8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

abstract class TextStyles {
  static const String fontFamily = AppConstants.kFontFamily;

  static final TextStyle bold13 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: getResponsiveFontSize(fontSize: 13),
  );

  static final TextStyle bold23 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: getResponsiveFontSize(fontSize: 23),
  );

  static final TextStyle semiBold13 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: getResponsiveFontSize(fontSize: 13),
  );

  static final TextStyle regular13 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: getResponsiveFontSize(fontSize: 13),
  );

  static final TextStyle bold16 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: getResponsiveFontSize(fontSize: 16),
  );

  static final TextStyle bold19 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: getResponsiveFontSize(fontSize: 19),
  );

  static final TextStyle semiBold16 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: getResponsiveFontSize(fontSize: 16),
  );

  static final TextStyle bold28 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: getResponsiveFontSize(fontSize: 28),
  );

  static final TextStyle regular22 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: getResponsiveFontSize(fontSize: 22),
  );

  static final TextStyle semiBold11 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: getResponsiveFontSize(fontSize: 11),
  );

  static final TextStyle medium15 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: getResponsiveFontSize(fontSize: 15),
  );

  static final TextStyle regular26 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: getResponsiveFontSize(fontSize: 26),
  );

  static final TextStyle regular16 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: getResponsiveFontSize(fontSize: 16),
  );

  static final TextStyle regular11 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: getResponsiveFontSize(fontSize: 11),
  );
}
