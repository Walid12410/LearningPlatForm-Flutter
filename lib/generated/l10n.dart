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

  /// `StudyLink: Your Ultimate Education Destination Online`
  String get getStartP1 {
    return Intl.message(
      'StudyLink: Your Ultimate Education Destination Online',
      name: 'getStartP1',
      desc: '',
      args: [],
    );
  }

  /// `SmartStudy: Your Comprehensive Digital Learning Platform`
  String get getStartP2 {
    return Intl.message(
      'SmartStudy: Your Comprehensive Digital Learning Platform',
      name: 'getStartP2',
      desc: '',
      args: [],
    );
  }

  /// `SkillBoost: Empowering You with Dynamic Online Education`
  String get getStartP3 {
    return Intl.message(
      'SkillBoost: Empowering You with Dynamic Online Education',
      name: 'getStartP3',
      desc: '',
      args: [],
    );
  }

  /// `LearnX: Your Gateway to Innovative Digital Learning`
  String get getStartP4 {
    return Intl.message(
      'LearnX: Your Gateway to Innovative Digital Learning',
      name: 'getStartP4',
      desc: '',
      args: [],
    );
  }

  /// `About Our App`
  String get aboutOurApp {
    return Intl.message(
      'About Our App',
      name: 'aboutOurApp',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `About Our Application`
  String get aboutOurAppFullSentence {
    return Intl.message(
      'About Our Application',
      name: 'aboutOurAppFullSentence',
      desc: '',
      args: [],
    );
  }

  /// `Embark on a transformative journey of learning and personal development through our cutting-edge learning platform app, where boundless knowledge meets endless possibilities for growth and exploration.`
  String get aboutDetails {
    return Intl.message(
      'Embark on a transformative journey of learning and personal development through our cutting-edge learning platform app, where boundless knowledge meets endless possibilities for growth and exploration.',
      name: 'aboutDetails',
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

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get RememberMe {
    return Intl.message(
      'Remember me',
      name: 'RememberMe',
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

  /// `Don't have an account?`
  String get DoNotHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'DoNotHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Signup`
  String get Signup {
    return Intl.message(
      'Signup',
      name: 'Signup',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get SignupSpace {
    return Intl.message(
      'Sign Up',
      name: 'SignupSpace',
      desc: '',
      args: [],
    );
  }

  /// `Already Have Account?`
  String get AlreadyHaveAcc {
    return Intl.message(
      'Already Have Account?',
      name: 'AlreadyHaveAcc',
      desc: '',
      args: [],
    );
  }

  /// `SignUp Successfully Done`
  String get SuccessSignUp {
    return Intl.message(
      'SignUp Successfully Done',
      name: 'SuccessSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Welcome To Our Learning Platform App,Please Login To Your App`
  String get WelcomeSignUp {
    return Intl.message(
      'Welcome To Our Learning Platform App,Please Login To Your App',
      name: 'WelcomeSignUp',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get FirstName {
    return Intl.message(
      'First Name',
      name: 'FirstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get LastName {
    return Intl.message(
      'Last Name',
      name: 'LastName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your first name`
  String get PlzEnterFn {
    return Intl.message(
      'Please enter your first name',
      name: 'PlzEnterFn',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your last name`
  String get PlzEnterLn {
    return Intl.message(
      'Please enter your last name',
      name: 'PlzEnterLn',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get InvalidEmail {
    return Intl.message(
      'Please enter your email',
      name: 'InvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email domain. Use @gmail.com or @hotmail.com`
  String get InvalidDomainEmail {
    return Intl.message(
      'Invalid email domain. Use @gmail.com or @hotmail.com',
      name: 'InvalidDomainEmail',
      desc: '',
      args: [],
    );
  }

  /// `Telephone`
  String get Telephone {
    return Intl.message(
      'Telephone',
      name: 'Telephone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your telephone number`
  String get PlzEnterPhone {
    return Intl.message(
      'Please enter your telephone number',
      name: 'PlzEnterPhone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter only numeric values`
  String get PlzEnterNumPhone {
    return Intl.message(
      'Please enter only numeric values',
      name: 'PlzEnterNumPhone',
      desc: '',
      args: [],
    );
  }

  /// `UserName`
  String get UserName {
    return Intl.message(
      'UserName',
      name: 'UserName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a username`
  String get PlzEnterUserName {
    return Intl.message(
      'Please enter a username',
      name: 'PlzEnterUserName',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get Male {
    return Intl.message(
      'Male',
      name: 'Male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get Female {
    return Intl.message(
      'Female',
      name: 'Female',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a password`
  String get PlzEnterPassword {
    return Intl.message(
      'Please enter a password',
      name: 'PlzEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters long`
  String get PasswordLong {
    return Intl.message(
      'Password must be at least 8 characters long',
      name: 'PasswordLong',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one uppercase letter`
  String get PasswordLetter {
    return Intl.message(
      'Password must contain at least one uppercase letter',
      name: 'PasswordLetter',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get PasswordConfirm {
    return Intl.message(
      'Confirm Password',
      name: 'PasswordConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password again`
  String get EnterPassAgain {
    return Intl.message(
      'Please enter your password again',
      name: 'EnterPassAgain',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get PassNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'PassNotMatch',
      desc: '',
      args: [],
    );
  }

  /// ` By clicking in signup You agree to our `
  String get ByClicking {
    return Intl.message(
      ' By clicking in signup You agree to our ',
      name: 'ByClicking',
      desc: '',
      args: [],
    );
  }

  /// `Terms`
  String get Terms {
    return Intl.message(
      'Terms',
      name: 'Terms',
      desc: '',
      args: [],
    );
  }

  /// `By accessing and using our services, you agree to abide by our Terms and Conditions. These terms govern your use of our platform and outline your rights and responsibilities as a user.`
  String get TermsDetails {
    return Intl.message(
      'By accessing and using our services, you agree to abide by our Terms and Conditions. These terms govern your use of our platform and outline your rights and responsibilities as a user.',
      name: 'TermsDetails',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get PrivacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'PrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Our Privacy Policy outlines how we collect, use, and protect your personal information when you use our services. We are committed to safeguarding your privacy and ensuring the security of your data.`
  String get PrivacyDetails {
    return Intl.message(
      'Our Privacy Policy outlines how we collect, use, and protect your personal information when you use our services. We are committed to safeguarding your privacy and ensuring the security of your data.',
      name: 'PrivacyDetails',
      desc: '',
      args: [],
    );
  }

  /// `, and `
  String get and {
    return Intl.message(
      ', and ',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Cookies Policy`
  String get cookiesPolicy {
    return Intl.message(
      'Cookies Policy',
      name: 'cookiesPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Our Cookies Policy explains how we use cookies and similar technologies to enhance your browsing experience and improve our services. We use cookies for analytics, personalization, and targeted advertising.`
  String get cookiesDetails {
    return Intl.message(
      'Our Cookies Policy explains how we use cookies and similar technologies to enhance your browsing experience and improve our services. We use cookies for analytics, personalization, and targeted advertising.',
      name: 'cookiesDetails',
      desc: '',
      args: [],
    );
  }

  /// `Login Failed`
  String get LoginFail {
    return Intl.message(
      'Login Failed',
      name: 'LoginFail',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get Close {
    return Intl.message(
      'Close',
      name: 'Close',
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
