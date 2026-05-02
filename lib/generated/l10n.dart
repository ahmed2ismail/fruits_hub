// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Skip`
  String get skipButton {
    return Intl.message(
      'Skip',
      name: 'skipButton',
      desc: 'Text for the skip button on onboarding screen',
      args: [],
    );
  }

  /// `Welcome to `
  String get onBoardingWelcomePrefix {
    return Intl.message(
      'Welcome to ',
      name: 'onBoardingWelcomePrefix',
      desc: 'Prefix for the welcome message on the onboarding screen',
      args: [],
    );
  }

  /// `Discover a unique shopping experience with FruitHUB. Explore our wide range of premium fresh fruits and get the best deals and high quality.`
  String get onBoardingSubtitle1 {
    return Intl.message(
      'Discover a unique shopping experience with FruitHUB. Explore our wide range of premium fresh fruits and get the best deals and high quality.',
      name: 'onBoardingSubtitle1',
      desc: 'Subtitle for the first onboarding screen',
      args: [],
    );
  }

  /// `Search and Shopping`
  String get onBoardingFreshFruitsPrefix {
    return Intl.message(
      'Search and Shopping',
      name: 'onBoardingFreshFruitsPrefix',
      desc: 'Prefix for the fresh fruits section on the onboarding screen',
      args: [],
    );
  }

  /// `We offer you the best selected fruits. Check out the details, images, and reviews to ensure you choose the perfect fruit.`
  String get onBoardingSubtitle2 {
    return Intl.message(
      'We offer you the best selected fruits. Check out the details, images, and reviews to ensure you choose the perfect fruit.',
      name: 'onBoardingSubtitle2',
      desc: 'Subtitle for the second onboarding screen',
      args: [],
    );
  }

  /// `Get Started`
  String get OnBoardingWelcomePrefixButton {
    return Intl.message(
      'Get Started',
      name: 'OnBoardingWelcomePrefixButton',
      desc: 'Text for the welcome button on the onboarding screen',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
