import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Language extends StatefulWidget {
  const Language({Key? key}) : super(key: key);

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  Future<void> _changeLanguage(BuildContext context, Locale newLocale) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('language_code', newLocale.languageCode);
      _showRestartDialog(context);
    } catch (e) {
      print("Error saving language: $e");
    }
  }

  Future<void> _showRestartDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // Disallow dismissing dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Restart App'),
          content: const SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text('You need to restart the app for the language change to take effect.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: const Text('Arabic'),
            onTap: () {
              _changeLanguage(context, const Locale('ar'));
            },
          ),
          ListTile(
            title: const Text('English'),
            onTap: () {
              _changeLanguage(context, const Locale('en'));
            },
          ),
        ],
      ),
    );
  }
}
