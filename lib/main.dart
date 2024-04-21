import 'package:flutter/material.dart';
import 'package:learningplatformapp/userprofiler/information.dart';
import 'package:learningplatformapp/userprofiler/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'SeeMoreCourse/MostViewCourse.dart';
import 'SignInUp/signin.dart';
import 'SplashScreen/splash.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'mainpages/PortalPage.dart';
import 'mainpages/Trainer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Locale savedLocale = Locale(prefs.getString('language_code') ?? 'ar');

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppDataProvider(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(savedLocale: savedLocale),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routes: {
              "/SignIn": (context) => const SignIn(),
              "/portal": (context) => const PortalPage(),
              "/trainer": (context) => const TrainerPage(),
              "/profile": (context) => const Profile(),
              "/information": (context) => const Information(),
              "/mostview": (context) => const MostView(),
            },
          ),

    ),
  );
}
