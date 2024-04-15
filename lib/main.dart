import 'package:flutter/material.dart';
import 'package:learningplatformapp/GetStart/pageview.dart';
import 'package:learningplatformapp/SeeMoreCourse/MostViewCourse.dart';
import 'package:learningplatformapp/SignInUp/signin.dart';
import 'package:learningplatformapp/mainpages/HomePage.dart';
import 'package:learningplatformapp/mainpages/PortalPage.dart';
import 'package:learningplatformapp/mainpages/Trainer.dart';
import 'package:learningplatformapp/userprofiler/information.dart';
import 'package:learningplatformapp/userprofiler/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Locale savedLocale = Locale(prefs.getString('language_code') ?? 'ar');

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppDataProvider(),
      child: MyApp(savedLocale: savedLocale),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Locale savedLocale;

  const MyApp({Key? key, required this.savedLocale}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      debugShowCheckedModeBanner: false,
      color: Colors.red,
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final prefs = snapshot.data;
            final isLoggedIn = prefs?.getBool('isLoggedIn') ?? false;
            final userId = prefs?.getInt('uid') ?? 0;
            if (isLoggedIn) {
              Provider.of<AppDataProvider>(context, listen: false).setUserId(userId);
              return const HomePage();
            } else {
              return const PageViewScreen();
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
      routes: {
        "/SignIn": (context) => const SignIn(),
        "/portal": (context) => const PortalPage(),
        "/trainer": (context) => const TrainerPage(),
        "/profile": (context) => const Profile(),
        "/information": (context) => const Information(),
        "/mostview": (context) => const MostView(),
      },
      locale: savedLocale,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}