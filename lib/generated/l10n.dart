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

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Please login to continue with your account`
  String get loginTitle {
    return Intl.message(
      'Please login to continue with your account',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `New User? Create Account`
  String get newUser {
    return Intl.message(
      'New User? Create Account',
      name: 'newUser',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email and password`
  String get enterEmailAndPassword {
    return Intl.message(
      'Please enter email and password',
      name: 'enterEmailAndPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter email`
  String get enterEmail {
    return Intl.message(
      'Please enter email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct email`
  String get enterCorrectEmail {
    return Intl.message(
      'Please enter correct email',
      name: 'enterCorrectEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter password`
  String get enterPassword {
    return Intl.message(
      'Please enter password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct password`
  String get enterCorrectPassword {
    return Intl.message(
      'Please enter correct password',
      name: 'enterCorrectPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter confirm password`
  String get enterConfirmPassword {
    return Intl.message(
      'Please enter confirm password',
      name: 'enterConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter correct confirm password`
  String get enterCorrectConfirmPassword {
    return Intl.message(
      'Please enter correct confirm password',
      name: 'enterCorrectConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Entered email and password is incorrect`
  String get enterEmailAndPasswordIncorrect {
    return Intl.message(
      'Entered email and password is incorrect',
      name: 'enterEmailAndPasswordIncorrect',
      desc: '',
      args: [],
    );
  }

  /// `Password mismatch`
  String get passwordMismatch {
    return Intl.message(
      'Password mismatch',
      name: 'passwordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `userData`
  String get userData {
    return Intl.message(
      'userData',
      name: 'userData',
      desc: '',
      args: [],
    );
  }

  /// `Signup`
  String get signup {
    return Intl.message(
      'Signup',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get dateOfBirth {
    return Intl.message(
      'Date of Birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Please enter user name`
  String get enterUserName {
    return Intl.message(
      'Please enter user name',
      name: 'enterUserName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter date of birth`
  String get enterDOB {
    return Intl.message(
      'Please enter date of birth',
      name: 'enterDOB',
      desc: '',
      args: [],
    );
  }

  /// `Favourites`
  String get favourites {
    return Intl.message(
      'Favourites',
      name: 'favourites',
      desc: '',
      args: [],
    );
  }

  /// `No Favourites Yet`
  String get noFavouritesYet {
    return Intl.message(
      'No Favourites Yet',
      name: 'noFavouritesYet',
      desc: '',
      args: [],
    );
  }

  /// `Email Address is invalid`
  String get invalidEmail {
    return Intl.message(
      'Email Address is invalid',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `At least 8 characters long`
  String get passwordValidation {
    return Intl.message(
      'At least 8 characters long',
      name: 'passwordValidation',
      desc: '',
      args: [],
    );
  }

  /// `Successfully add`
  String get addSuccessfully {
    return Intl.message(
      'Successfully add',
      name: 'addSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Successfully removed`
  String get removeSuccessfully {
    return Intl.message(
      'Successfully removed',
      name: 'removeSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Not add`
  String get notAdd {
    return Intl.message(
      'Not add',
      name: 'notAdd',
      desc: '',
      args: [],
    );
  }

  /// `error`
  String get error {
    return Intl.message(
      'error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `page`
  String get page {
    return Intl.message(
      'page',
      name: 'page',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to logout?`
  String get logoutTitle {
    return Intl.message(
      'Are you sure to logout?',
      name: 'logoutTitle',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Splash Screen`
  String get splashScreen {
    return Intl.message(
      'Splash Screen',
      name: 'splashScreen',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get overview {
    return Intl.message(
      'Overview',
      name: 'overview',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Transgender`
  String get transgender {
    return Intl.message(
      'Transgender',
      name: 'transgender',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `EditProfile`
  String get editProfile {
    return Intl.message(
      'EditProfile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Accounts`
  String get accounts {
    return Intl.message(
      'Accounts',
      name: 'accounts',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `OnBoarding`
  String get onboarding {
    return Intl.message(
      'OnBoarding',
      name: 'onboarding',
      desc: '',
      args: [],
    );
  }

  /// `Loading`
  String get loading {
    return Intl.message(
      'Loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
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
