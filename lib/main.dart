import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/GetStart/pageview.dart';
import 'package:learningplatformapp/HomePages/CoursePage.dart';
import 'package:learningplatformapp/HomePages/HomePage.dart';
import 'package:learningplatformapp/HomePages/PortalPage.dart';
import 'package:learningplatformapp/SignInUp/signin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'App',
      debugShowCheckedModeBanner: false,
      color: Colors.red,
      home: SignIn(),
    );
  }
}

