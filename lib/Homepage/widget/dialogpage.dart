import 'package:flutter/material.dart';
import 'package:learningplatformapp/SignInUp/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/l10n.dart';

class DialogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding:const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading:const Icon(Icons.person),
              title: Text(S.of(context).PersonalInfo),
              onTap: () {
                 Navigator.pushNamed(context, '/information');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(S.of(context).LogOut),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear(); // Clear all stored preferences
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) =>const SignIn()),
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
