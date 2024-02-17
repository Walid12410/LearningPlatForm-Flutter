import 'package:flutter/material.dart';
import 'package:learningplatformapp/SignInUp/signin.dart';

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
              title: const Text('Personal Info'),
              onTap: () {
                // Navigate to personal info page
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => PersonalInfoPage()),
                // );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>const SignIn()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
