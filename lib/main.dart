import 'package:flutter/material.dart';
import 'package:learningplatformapp/GetStart/pageview.dart';
import 'package:learningplatformapp/SignInUp/signin.dart';
import 'package:learningplatformapp/mainpages/HomePage.dart';
import 'package:learningplatformapp/mainpages/PortalPage.dart';
import 'package:learningplatformapp/mainpages/Trainer.dart';
import 'package:learningplatformapp/mainpages/TrainerCourses.dart';
import 'package:learningplatformapp/userprofiler/information.dart';
import 'package:learningplatformapp/userprofiler/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider( // Provide AppDataProvider to the widget tree
      create: (context) => AppDataProvider(), // Create an instance of AppDataProvider
      child: MaterialApp(
        title: 'App',
        debugShowCheckedModeBanner: false,
        color: Colors.red,
        home: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(), // Get SharedPreferences instance asynchronously
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final prefs = snapshot.data; // Retrieve SharedPreferences instance
              final isLoggedIn = prefs?.getBool('isLoggedIn') ?? false; // Check if user is logged in
              final userId = prefs?.getInt('uid') ?? 0; // Get user ID from SharedPreferences
              if (isLoggedIn) {
                Provider.of<AppDataProvider>(context, listen: false)
                    .setUserId(userId); // Set user ID in AppDataProvider
                return const HomePage(); // Navigate to HomePage if user is logged in
              } else {
                return const PageViewScreen(); // Navigate to PageViewScreen if user is not logged in
              }
            } else {
              return const Scaffold( // Show loading indicator while SharedPreferences is being fetched
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
        routes: { // Define named routes
          "/SignIn": (context) => const SignIn(), // SignIn route
          "/portal": (context) => const PortalPage(), // portal route
          "/trainer" : (context) => const TrainerPage(),
          "/profile" : (context) => const Profile(),
          "/information" : (context) =>const Information()
        },
      ),
    );
  }
}
