import 'package:flutter/material.dart';
import 'dart:async';
import '../colors/color.dart';
import 'AppBuild.dart';

class SplashScreen extends StatefulWidget {
  final Locale savedLocale;

  const SplashScreen({Key? key, required this.savedLocale}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 4),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MyApp(savedLocale: widget.savedLocale),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/gif-unscreen.gif',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              )
            ],
          ),
          const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Learning',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'PlatForm',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: tdbrown,
                  ),
                )
              ])
        ],
      ),
    );
  }
}
