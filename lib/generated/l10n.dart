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

  /// `Login`
  String get loginAppBarTitle {
    return Intl.message(
      'Login',
      name: 'loginAppBarTitle',
      desc: 'Title for the app bar on the login screen',
      args: [],
    );
  }

  /// `Email`
  String get emailTextFieldLabel {
    return Intl.message(
      'Email',
      name: 'emailTextFieldLabel',
      desc: 'Label for the email text field on the login screen',
      args: [],
    );
  }

  /// `Password`
  String get passwordTextFieldLabel {
    return Intl.message(
      'Password',
      name: 'passwordTextFieldLabel',
      desc: 'Label for the password text field on the login screen',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPasswordText {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPasswordText',
      desc: 'Text for the forgot password option on the login screen',
      args: [],
    );
  }

  /// `Login`
  String get loginButtonText {
    return Intl.message(
      'Login',
      name: 'loginButtonText',
      desc: 'Text for the login button on the login screen',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAccountText {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAccountText',
      desc: 'Text for the don\'t have account option on the login screen',
      args: [],
    );
  }

  /// ` Create an account`
  String get registerText {
    return Intl.message(
      ' Create an account',
      name: 'registerText',
      desc: 'Text for the register option on the login screen',
      args: [],
    );
  }

  /// `Or`
  String get orText {
    return Intl.message(
      'Or',
      name: 'orText',
      desc: 'Text for the \'or\' separator on the login screen',
      args: [],
    );
  }

  /// `Login with Google`
  String get loginWithGoogleText {
    return Intl.message(
      'Login with Google',
      name: 'loginWithGoogleText',
      desc: 'Text for the login with Google option on the login screen',
      args: [],
    );
  }

  /// `Login with Facebook`
  String get loginWithFacebookText {
    return Intl.message(
      'Login with Facebook',
      name: 'loginWithFacebookText',
      desc: 'Text for the login with Facebook option on the login screen',
      args: [],
    );
  }

  /// `Login with Apple`
  String get loginWithAppleText {
    return Intl.message(
      'Login with Apple',
      name: 'loginWithAppleText',
      desc: 'Text for the login with Apple option on the login screen',
      args: [],
    );
  }

  /// `New Account`
  String get newAccount {
    return Intl.message(
      'New Account',
      name: 'newAccount',
      desc: 'Text for the new account option on the login screen',
      args: [],
    );
  }

  /// `Full Name`
  String get FullName {
    return Intl.message(
      'Full Name',
      name: 'FullName',
      desc: 'Label for the full name text field on the login screen',
      args: [],
    );
  }

  /// `By creating an account, you agree to our `
  String get byCreatingAnAccountYouAgree {
    return Intl.message(
      'By creating an account, you agree to our ',
      name: 'byCreatingAnAccountYouAgree',
      desc:
          'Text for the \'by creating an account\' section on the login screen',
      args: [],
    );
  }

  /// `Terms and Conditions`
  String get toOurTermsAndConditions {
    return Intl.message(
      'Terms and Conditions',
      name: 'toOurTermsAndConditions',
      desc: 'Text for the \'Terms and Conditions\' link on the login screen',
      args: [],
    );
  }

  /// `Create New Account`
  String get createNewAccount {
    return Intl.message(
      'Create New Account',
      name: 'createNewAccount',
      desc: 'Text for the \'Create New Account\' button on the login screen',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccountText {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccountText',
      desc:
          'Text for the \'Already have an account?\' option on the login screen',
      args: [],
    );
  }

  /// ` Login`
  String get loginText {
    return Intl.message(
      ' Login',
      name: 'loginText',
      desc: 'Text for the \'Login\' button on the login screen',
      args: [],
    );
  }

  /// `Forgot Password`
  String get ForgotPasswordAppBarTitle {
    return Intl.message(
      'Forgot Password',
      name: 'ForgotPasswordAppBarTitle',
      desc: 'Title for the app bar on the forgot password screen',
      args: [],
    );
  }

  /// `Don't worry, just enter your phone number and we'll send you a verification code.`
  String get ForgotPasswordHelperMessage {
    return Intl.message(
      'Don\'t worry, just enter your phone number and we\'ll send you a verification code.',
      name: 'ForgotPasswordHelperMessage',
      desc: 'Helper message for the forgot password screen',
      args: [],
    );
  }

  /// `Phone number with country code`
  String get phoneNumberWithCountryCode {
    return Intl.message(
      'Phone number with country code',
      name: 'phoneNumberWithCountryCode',
      desc:
          'Label for the phone number text field on the forgot password screen',
      args: [],
    );
  }

  /// `I Forgot My Password`
  String get IForgotMyPassword {
    return Intl.message(
      'I Forgot My Password',
      name: 'IForgotMyPassword',
      desc:
          'Text for the \'I Forgot My Password\' option on the forgot password screen',
      args: [],
    );
  }

  /// `Code Verification`
  String get CodeVerificationAppBarTitle {
    return Intl.message(
      'Code Verification',
      name: 'CodeVerificationAppBarTitle',
      desc: 'Title for the app bar on the code verification screen',
      args: [],
    );
  }

  /// `Enter the code we sent to this email address`
  String get CodeVerificationHelperMessage {
    return Intl.message(
      'Enter the code we sent to this email address',
      name: 'CodeVerificationHelperMessage',
      desc: 'Helper message for the code verification screen',
      args: [],
    );
  }

  /// `Verify Code`
  String get CodeVerificationTextButton {
    return Intl.message(
      'Verify Code',
      name: 'CodeVerificationTextButton',
      desc:
          'Text for the \'Verify Code\' button on the code verification screen',
      args: [],
    );
  }

  /// `Resend Code`
  String get ResendCode {
    return Intl.message(
      'Resend Code',
      name: 'ResendCode',
      desc:
          'Text for the \'Resend Code\' button on the code verification screen',
      args: [],
    );
  }

  /// `Reset Your Password`
  String get ResetYourPasswordAppBarTitle {
    return Intl.message(
      'Reset Your Password',
      name: 'ResetYourPasswordAppBarTitle',
      desc: 'Title for the app bar on the reset password screen',
      args: [],
    );
  }

  /// `Create a new password to log in`
  String get ResetYourPasswordHelperMessage {
    return Intl.message(
      'Create a new password to log in',
      name: 'ResetYourPasswordHelperMessage',
      desc: 'Helper message for the reset password screen',
      args: [],
    );
  }

  /// `New Password`
  String get NewPassword {
    return Intl.message(
      'New Password',
      name: 'NewPassword',
      desc:
          'Label for the new password text field on the reset password screen',
      args: [],
    );
  }

  /// `Confirm Password`
  String get ConfirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'ConfirmPassword',
      desc:
          'Label for the confirm password text field on the reset password screen',
      args: [],
    );
  }

  /// `Create New Password`
  String get CreateNewPasswordTextButton {
    return Intl.message(
      'Create New Password',
      name: 'CreateNewPasswordTextButton',
      desc:
          'Text for the \'Create New Password\' button on the reset password screen',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get SuccefulChangedPasswordMessage {
    return Intl.message(
      'Password changed successfully',
      name: 'SuccefulChangedPasswordMessage',
      desc: 'Message for a successful password change',
      args: [],
    );
  }

  /// `An error occured. Please try again later.`
  String get generalFailureMessage {
    return Intl.message(
      'An error occured. Please try again later.',
      name: 'generalFailureMessage',
      desc: 'Message for a general failure',
      args: [],
    );
  }

  /// `You must agree to our Terms and Conditions`
  String get termsAndConditionErrorMessage {
    return Intl.message(
      'You must agree to our Terms and Conditions',
      name: 'termsAndConditionErrorMessage',
      desc: 'Message for agreeing to our Terms and Conditions',
      args: [],
    );
  }

  /// `Account created successfully`
  String get SignupSuccessMessage {
    return Intl.message(
      'Account created successfully',
      name: 'SignupSuccessMessage',
      desc: 'Message for a successful account creation',
      args: [],
    );
  }

  /// `Failed to create account. Please try again.`
  String get SignupFailureMessage {
    return Intl.message(
      'Failed to create account. Please try again.',
      name: 'SignupFailureMessage',
      desc: 'Message for a failed account creation',
      args: [],
    );
  }

  /// `Logged in successfully`
  String get SigninSuccessMessage {
    return Intl.message(
      'Logged in successfully',
      name: 'SigninSuccessMessage',
      desc: 'Message for a successful login',
      args: [],
    );
  }

  /// `Failed to log in. Please try again.`
  String get SigninFailureMessage {
    return Intl.message(
      'Failed to log in. Please try again.',
      name: 'SigninFailureMessage',
      desc: 'Message for a failed login',
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
