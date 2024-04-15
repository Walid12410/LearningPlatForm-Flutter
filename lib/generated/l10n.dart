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

  /// `Learning Platform App`
  String get LearningPlatformApp {
    return Intl.message(
      'Learning Platform App',
      name: 'LearningPlatformApp',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get WelcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'WelcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Start learning now!`
  String get StartLeaning {
    return Intl.message(
      'Start learning now!',
      name: 'StartLeaning',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get Categories {
    return Intl.message(
      'Categories',
      name: 'Categories',
      desc: '',
      args: [],
    );
  }

  /// `Most Viewed Courses`
  String get MViewCourse {
    return Intl.message(
      'Most Viewed Courses',
      name: 'MViewCourse',
      desc: '',
      args: [],
    );
  }

  /// `Latest Course Added`
  String get LatestCAdded {
    return Intl.message(
      'Latest Course Added',
      name: 'LatestCAdded',
      desc: '',
      args: [],
    );
  }

  /// `For You`
  String get ForYou {
    return Intl.message(
      'For You',
      name: 'ForYou',
      desc: '',
      args: [],
    );
  }

  /// `Personal Info`
  String get PersonalInfo {
    return Intl.message(
      'Personal Info',
      name: 'PersonalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get LogOut {
    return Intl.message(
      'Logout',
      name: 'LogOut',
      desc: '',
      args: [],
    );
  }

  /// `see more`
  String get SeeMore {
    return Intl.message(
      'see more',
      name: 'SeeMore',
      desc: '',
      args: [],
    );
  }

  /// `Recommend Courses For You`
  String get RecommendCFY {
    return Intl.message(
      'Recommend Courses For You',
      name: 'RecommendCFY',
      desc: '',
      args: [],
    );
  }

  /// `All Categories`
  String get AllCategories {
    return Intl.message(
      'All Categories',
      name: 'AllCategories',
      desc: '',
      args: [],
    );
  }

  /// `All Instructor`
  String get AllInstructor {
    return Intl.message(
      'All Instructor',
      name: 'AllInstructor',
      desc: '',
      args: [],
    );
  }

  /// `No Categories available`
  String get NoCategoriesAvailable {
    return Intl.message(
      'No Categories available',
      name: 'NoCategoriesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Go Back`
  String get GoBack {
    return Intl.message(
      'Go Back',
      name: 'GoBack',
      desc: '',
      args: [],
    );
  }

  /// `No Course available`
  String get NoCourseAvailable {
    return Intl.message(
      'No Course available',
      name: 'NoCourseAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get HomePage {
    return Intl.message(
      'Home',
      name: 'HomePage',
      desc: '',
      args: [],
    );
  }

  /// `MyCourse`
  String get MyCourse {
    return Intl.message(
      'MyCourse',
      name: 'MyCourse',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get Search {
    return Intl.message(
      'Search',
      name: 'Search',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Profile {
    return Intl.message(
      'Profile',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `No Instructor available`
  String get NoTrainerAvailable {
    return Intl.message(
      'No Instructor available',
      name: 'NoTrainerAvailable',
      desc: '',
      args: [],
    );
  }

  /// `All Courses`
  String get AllCourses {
    return Intl.message(
      'All Courses',
      name: 'AllCourses',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get OK {
    return Intl.message(
      'OK',
      name: 'OK',
      desc: '',
      args: [],
    );
  }

  /// `Quick Filters`
  String get QuickFilter {
    return Intl.message(
      'Quick Filters',
      name: 'QuickFilter',
      desc: '',
      args: [],
    );
  }

  /// `All Category Selected`
  String get AllCategoriesSelected {
    return Intl.message(
      'All Category Selected',
      name: 'AllCategoriesSelected',
      desc: '',
      args: [],
    );
  }

  /// `Minimum Price`
  String get MinimumPrice {
    return Intl.message(
      'Minimum Price',
      name: 'MinimumPrice',
      desc: '',
      args: [],
    );
  }

  /// `Maximum Price`
  String get MaximumPrice {
    return Intl.message(
      'Maximum Price',
      name: 'MaximumPrice',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get Done {
    return Intl.message(
      'Done',
      name: 'Done',
      desc: '',
      args: [],
    );
  }

  /// `Course not found`
  String get CourseNotFound {
    return Intl.message(
      'Course not found',
      name: 'CourseNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Setting & Profile`
  String get settingProfile {
    return Intl.message(
      'Setting & Profile',
      name: 'settingProfile',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get EditProfile {
    return Intl.message(
      'Edit Profile',
      name: 'EditProfile',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get ChangePassword {
    return Intl.message(
      'Change Password',
      name: 'ChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get information {
    return Intl.message(
      'Information',
      name: 'information',
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

  /// `Save Edit`
  String get SaveEdit {
    return Intl.message(
      'Save Edit',
      name: 'SaveEdit',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get Success {
    return Intl.message(
      'Success',
      name: 'Success',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get ProfileUpdateS {
    return Intl.message(
      'Profile updated successfully',
      name: 'ProfileUpdateS',
      desc: '',
      args: [],
    );
  }

  /// `Unlock your potential today and take the next step towards success by purchasing our comprehensive course`
  String get CourseDetailDesc {
    return Intl.message(
      'Unlock your potential today and take the next step towards success by purchasing our comprehensive course',
      name: 'CourseDetailDesc',
      desc: '',
      args: [],
    );
  }

  /// `You Already Have This Course`
  String get CourseEnroll {
    return Intl.message(
      'You Already Have This Course',
      name: 'CourseEnroll',
      desc: '',
      args: [],
    );
  }

  /// `Enroll Now`
  String get EnrollNow {
    return Intl.message(
      'Enroll Now',
      name: 'EnrollNow',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get InfoCourse {
    return Intl.message(
      'Info',
      name: 'InfoCourse',
      desc: '',
      args: [],
    );
  }

  /// `Chapters`
  String get Chapters {
    return Intl.message(
      'Chapters',
      name: 'Chapters',
      desc: '',
      args: [],
    );
  }

  /// `Quizzes`
  String get Quiz {
    return Intl.message(
      'Quizzes',
      name: 'Quiz',
      desc: '',
      args: [],
    );
  }

  /// `No chapters available`
  String get NoChapterAvailable {
    return Intl.message(
      'No chapters available',
      name: 'NoChapterAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Lesson`
  String get Lesson {
    return Intl.message(
      'Lesson',
      name: 'Lesson',
      desc: '',
      args: [],
    );
  }

  /// `No lessons available for this chapter`
  String get NoLessonOfChapter {
    return Intl.message(
      'No lessons available for this chapter',
      name: 'NoLessonOfChapter',
      desc: '',
      args: [],
    );
  }

  /// `no feedback for this course`
  String get NoFeedBackOfThisCourse {
    return Intl.message(
      'no feedback for this course',
      name: 'NoFeedBackOfThisCourse',
      desc: '',
      args: [],
    );
  }

  /// `Rating & Review`
  String get RatingAndReview {
    return Intl.message(
      'Rating & Review',
      name: 'RatingAndReview',
      desc: '',
      args: [],
    );
  }

  /// `Unlock the potential of collaborative learning by contributing your unique insights and experiences to Course Review. Join our vibrant community in shaping the future of online education, one review at a time.`
  String get RatingDesc {
    return Intl.message(
      'Unlock the potential of collaborative learning by contributing your unique insights and experiences to Course Review. Join our vibrant community in shaping the future of online education, one review at a time.',
      name: 'RatingDesc',
      desc: '',
      args: [],
    );
  }

  /// `show more`
  String get ShowMore {
    return Intl.message(
      'show more',
      name: 'ShowMore',
      desc: '',
      args: [],
    );
  }

  /// `show less`
  String get ShowLess {
    return Intl.message(
      'show less',
      name: 'ShowLess',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get HourCourse {
    return Intl.message(
      'Hours',
      name: 'HourCourse',
      desc: '',
      args: [],
    );
  }

  /// `Lessons`
  String get Lessons {
    return Intl.message(
      'Lessons',
      name: 'Lessons',
      desc: '',
      args: [],
    );
  }

  /// `Certification Available`
  String get Certification {
    return Intl.message(
      'Certification Available',
      name: 'Certification',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get CourseLanguage {
    return Intl.message(
      'Arabic',
      name: 'CourseLanguage',
      desc: '',
      args: [],
    );
  }

  /// `About The Course`
  String get AboutCourse {
    return Intl.message(
      'About The Course',
      name: 'AboutCourse',
      desc: '',
      args: [],
    );
  }

  /// `No Details Yet`
  String get NoDetailYet {
    return Intl.message(
      'No Details Yet',
      name: 'NoDetailYet',
      desc: '',
      args: [],
    );
  }

  /// `Score:`
  String get Score {
    return Intl.message(
      'Score:',
      name: 'Score',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!`
  String get Congrats {
    return Intl.message(
      'Congratulations!',
      name: 'Congrats',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully passed the exam. Well done!`
  String get CongratsDetails {
    return Intl.message(
      'You have successfully passed the exam. Well done!',
      name: 'CongratsDetails',
      desc: '',
      args: [],
    );
  }

  /// `Back To HomePage`
  String get BackToHome {
    return Intl.message(
      'Back To HomePage',
      name: 'BackToHome',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, you did not pass the exam.`
  String get DidNotPass {
    return Intl.message(
      'Sorry, you did not pass the exam.',
      name: 'DidNotPass',
      desc: '',
      args: [],
    );
  }

  /// `No quiz added yet for this chapter`
  String get NoQuizAddYet {
    return Intl.message(
      'No quiz added yet for this chapter',
      name: 'NoQuizAddYet',
      desc: '',
      args: [],
    );
  }

  /// `Quiz`
  String get quiz {
    return Intl.message(
      'Quiz',
      name: 'quiz',
      desc: '',
      args: [],
    );
  }

  /// `Challenge`
  String get challenge {
    return Intl.message(
      'Challenge',
      name: 'challenge',
      desc: '',
      args: [],
    );
  }

  /// `Submit Quiz`
  String get SubmitQuiz {
    return Intl.message(
      'Submit Quiz',
      name: 'SubmitQuiz',
      desc: '',
      args: [],
    );
  }

  /// `No Quiz Available`
  String get NoQuizAvailable {
    return Intl.message(
      'No Quiz Available',
      name: 'NoQuizAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No choices available`
  String get NoChoicesAvailable {
    return Intl.message(
      'No choices available',
      name: 'NoChoicesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Your Courses`
  String get YourCourse {
    return Intl.message(
      'Your Courses',
      name: 'YourCourse',
      desc: '',
      args: [],
    );
  }

  /// `Your Favorite Course`
  String get YourFavoriteCourse {
    return Intl.message(
      'Your Favorite Course',
      name: 'YourFavoriteCourse',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get SelectLanguage {
    return Intl.message(
      'Select Language',
      name: 'SelectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get Arabic {
    return Intl.message(
      'Arabic',
      name: 'Arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message(
      'English',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `Restart App`
  String get restartApp {
    return Intl.message(
      'Restart App',
      name: 'restartApp',
      desc: '',
      args: [],
    );
  }

  /// `You need to restart the app for the language change to take effect.`
  String get restartAppDetails {
    return Intl.message(
      'You need to restart the app for the language change to take effect.',
      name: 'restartAppDetails',
      desc: '',
      args: [],
    );
  }

  /// `You Do Not Have Courses Yet! Buy Now`
  String get YouDoNotHaveCourse {
    return Intl.message(
      'You Do Not Have Courses Yet! Buy Now',
      name: 'YouDoNotHaveCourse',
      desc: '',
      args: [],
    );
  }

  /// `You Do not Added Any Course In Favorite`
  String get NoFavCourse {
    return Intl.message(
      'You Do not Added Any Course In Favorite',
      name: 'NoFavCourse',
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
