import 'package:learningplatformapp/GetStart/pageview.dart';
import 'package:learningplatformapp/mainpages/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import '../generated/l10n.dart';


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
            if (isLoggedIn) {
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
