import 'dart:io';
import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../generated/l10n.dart';

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
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            S.of(context).restartApp,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  S.of(context).restartAppDetails,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                S.of(context).OK,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: tdbrown),
              ),
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
          title: Text(S.of(context).SelectLanguage),
          centerTitle: true,
          backgroundColor: tdbrown,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    _changeLanguage(context, const Locale('ar'));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: tdbrown),
                    child: Center(
                      child: Text(
                        S.of(context).Arabic,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: tdBlue),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    _changeLanguage(context, const Locale('en'));
                  },
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: tdbrown),
                    child: Center(
                      child: Text(
                        S.of(context).English,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: tdBlue),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
