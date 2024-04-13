import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({Key? key}) : super(key: key);

  Future<void> _changeLanguage(BuildContext context, Locale newLocale) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('language_code', newLocale.languageCode);
    } catch (e) {
      print("Error saving language: $e");
    }
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
