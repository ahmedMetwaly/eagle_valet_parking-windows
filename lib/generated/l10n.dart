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

  /// `Eagle valet parking`
  String get Eagle_valet_parking {
    return Intl.message(
      'Eagle valet parking',
      name: 'Eagle_valet_parking',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to the News App`
  String get onboarding1Title {
    return Intl.message(
      'Welcome to the News App',
      name: 'onboarding1Title',
      desc: '',
      args: [],
    );
  }

  /// `Stay ahead of the curve with News! Personalize your news feed, receive breaking news alerts, and explore a world of information at your fingertips`
  String get onboarding1Body {
    return Intl.message(
      'Stay ahead of the curve with News! Personalize your news feed, receive breaking news alerts, and explore a world of information at your fingertips',
      name: 'onboarding1Body',
      desc: '',
      args: [],
    );
  }

  /// `Explore the World of News`
  String get onboarding2Title {
    return Intl.message(
      'Explore the World of News',
      name: 'onboarding2Title',
      desc: '',
      args: [],
    );
  }

  /// `Customize your news experience by choosing your favorite topics. From global events to niche interests, our app covers it all.`
  String get onboarding2Body {
    return Intl.message(
      'Customize your news experience by choosing your favorite topics. From global events to niche interests, our app covers it all.',
      name: 'onboarding2Body',
      desc: '',
      args: [],
    );
  }

  /// `Stay Informed, Anywhere`
  String get onboarding3Title {
    return Intl.message(
      'Stay Informed, Anywhere',
      name: 'onboarding3Title',
      desc: '',
      args: [],
    );
  }

  /// `Access breaking news and save articles. Share and discuss with your community, and dive into a world of knowledge on the go.`
  String get onboarding3Body {
    return Intl.message(
      'Access breaking news and save articles. Share and discuss with your community, and dive into a world of knowledge on the go.',
      name: 'onboarding3Body',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
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

  /// `Forget Password`
  String get forgetPassword {
    return Intl.message(
      'Forget Password',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't worry sometimes people can forget too, enter your email and we will send you a password reset link.`
  String get forgotPasswordDetails {
    return Intl.message(
      'Don\'t worry sometimes people can forget too, enter your email and we will send you a password reset link.',
      name: 'forgotPasswordDetails',
      desc: '',
      args: [],
    );
  }

  /// `Required field`
  String get requiredField {
    return Intl.message(
      'Required field',
      name: 'requiredField',
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

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to logout ?`
  String get logoutDescription {
    return Intl.message(
      'Do you want to logout ?',
      name: 'logoutDescription',
      desc: '',
      args: [],
    );
  }

  /// ` Confirm logout`
  String get confirmLogout {
    return Intl.message(
      ' Confirm logout',
      name: 'confirmLogout',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
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

  /// `Use 8 characters or more for your password`
  String get passErrorSignUp {
    return Intl.message(
      'Use 8 characters or more for your password',
      name: 'passErrorSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Not valid email`
  String get notValidEmail {
    return Intl.message(
      'Not valid email',
      name: 'notValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Login error`
  String get loginError {
    return Intl.message(
      'Login error',
      name: 'loginError',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Resend email`
  String get resendEmail {
    return Intl.message(
      'Resend email',
      name: 'resendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Your account security is our priority ! we've sent you a secure link to safely change your password and keep your account protected.`
  String get passwordResetDetails {
    return Intl.message(
      'Your account security is our priority ! we\'ve sent you a secure link to safely change your password and keep your account protected.',
      name: 'passwordResetDetails',
      desc: '',
      args: [],
    );
  }

  /// `Password reset link sent to your email!`
  String get passwordReset {
    return Intl.message(
      'Password reset link sent to your email!',
      name: 'passwordReset',
      desc: '',
      args: [],
    );
  }

  /// `Password reset email sent check your account.`
  String get checkYourEmail {
    return Intl.message(
      'Password reset email sent check your account.',
      name: 'checkYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Sent`
  String get sent {
    return Intl.message(
      'Sent',
      name: 'sent',
      desc: '',
      args: [],
    );
  }

  /// `Not valid name`
  String get notValidName {
    return Intl.message(
      'Not valid name',
      name: 'notValidName',
      desc: '',
      args: [],
    );
  }

  /// `User is not found`
  String get userNotFound {
    return Intl.message(
      'User is not found',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Password is wrong`
  String get wrongPass {
    return Intl.message(
      'Password is wrong',
      name: 'wrongPass',
      desc: '',
      args: [],
    );
  }

  /// `Connection error`
  String get connectionError {
    return Intl.message(
      'Connection error',
      name: 'connectionError',
      desc: '',
      args: [],
    );
  }

  /// `Email already exist try sign up with another email.`
  String get emailErrorSignUp {
    return Intl.message(
      'Email already exist try sign up with another email.',
      name: 'emailErrorSignUp',
      desc: '',
      args: [],
    );
  }

  /// `User Error`
  String get userError {
    return Intl.message(
      'User Error',
      name: 'userError',
      desc: '',
      args: [],
    );
  }

  /// `Check your email and password or your connection with internet`
  String get unknown_error {
    return Intl.message(
      'Check your email and password or your connection with internet',
      name: 'unknown_error',
      desc: '',
      args: [],
    );
  }

  /// `My profile`
  String get myProfile {
    return Intl.message(
      'My profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
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

  /// `Print Ticket`
  String get printTicket {
    return Intl.message(
      'Print Ticket',
      name: 'printTicket',
      desc: '',
      args: [],
    );
  }

  /// `Calculate Parking Duration`
  String get calculateParkingDuration {
    return Intl.message(
      'Calculate Parking Duration',
      name: 'calculateParkingDuration',
      desc: '',
      args: [],
    );
  }

  /// `Calculate Duration`
  String get calculateDuration {
    return Intl.message(
      'Calculate Duration',
      name: 'calculateDuration',
      desc: '',
      args: [],
    );
  }

  /// `Calculate`
  String get calculate {
    return Intl.message(
      'Calculate',
      name: 'calculate',
      desc: '',
      args: [],
    );
  }

  /// `Live Overview`
  String get liveOverview {
    return Intl.message(
      'Live Overview',
      name: 'liveOverview',
      desc: '',
      args: [],
    );
  }

  /// `Parking lots occupied`
  String get parkingLotsOccupied {
    return Intl.message(
      'Parking lots occupied',
      name: 'parkingLotsOccupied',
      desc: '',
      args: [],
    );
  }

  /// `Empty parking`
  String get emptyParking {
    return Intl.message(
      'Empty parking',
      name: 'emptyParking',
      desc: '',
      args: [],
    );
  }

  /// `Total customers today`
  String get totalCustomersToday {
    return Intl.message(
      'Total customers today',
      name: 'totalCustomersToday',
      desc: '',
      args: [],
    );
  }

  /// `Today's collection`
  String get todaysCollection {
    return Intl.message(
      'Today\'s collection',
      name: 'todaysCollection',
      desc: '',
      args: [],
    );
  }

  /// `LE`
  String get currencySign {
    return Intl.message(
      'LE',
      name: 'currencySign',
      desc: '',
      args: [],
    );
  }

  /// `Print`
  String get print {
    return Intl.message(
      'Print',
      name: 'print',
      desc: '',
      args: [],
    );
  }

  /// `© 2024 Eagle valet parking All rights reserved`
  String get copyRight {
    return Intl.message(
      '© 2024 Eagle valet parking All rights reserved',
      name: 'copyRight',
      desc: '',
      args: [],
    );
  }

  /// `Email verfication sent`
  String get emailVerficationSent {
    return Intl.message(
      'Email verfication sent',
      name: 'emailVerficationSent',
      desc: '',
      args: [],
    );
  }

  /// `Email verfication sent check your email and click on the link then press done to login.\nif the email not sent to you please press on Resend email.`
  String get emailVerficationDescription {
    return Intl.message(
      'Email verfication sent check your email and click on the link then press done to login.\nif the email not sent to you please press on Resend email.',
      name: 'emailVerficationDescription',
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

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Warnning`
  String get warnning {
    return Intl.message(
      'Warnning',
      name: 'warnning',
      desc: '',
      args: [],
    );
  }

  /// `Parking is full do you want to print ticket ?`
  String get parking_full {
    return Intl.message(
      'Parking is full do you want to print ticket ?',
      name: 'parking_full',
      desc: '',
      args: [],
    );
  }

  /// `Ticket Number`
  String get ticketNumber {
    return Intl.message(
      'Ticket Number',
      name: 'ticketNumber',
      desc: '',
      args: [],
    );
  }

  /// `Total Duration`
  String get totalDuration {
    return Intl.message(
      'Total Duration',
      name: 'totalDuration',
      desc: '',
      args: [],
    );
  }

  /// `Parking Fee`
  String get parkingFee {
    return Intl.message(
      'Parking Fee',
      name: 'parkingFee',
      desc: '',
      args: [],
    );
  }

  /// `hours`
  String get hours {
    return Intl.message(
      'hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `minutes`
  String get minutes {
    return Intl.message(
      'minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid ticket number`
  String get enterValidTicketNumber {
    return Intl.message(
      'Enter valid ticket number',
      name: 'enterValidTicketNumber',
      desc: '',
      args: [],
    );
  }

  /// `Check the ticket number, please!`
  String get ticketNumberIsNotValid {
    return Intl.message(
      'Check the ticket number, please!',
      name: 'ticketNumberIsNotValid',
      desc: '',
      args: [],
    );
  }

  /// `branch`
  String get branch {
    return Intl.message(
      'branch',
      name: 'branch',
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
