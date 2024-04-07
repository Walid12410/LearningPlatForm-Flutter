import 'package:flutter/material.dart';
import 'package:learningplatformapp/SignInUp/WidgetsForSignUp/signupform.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
             Positioned.fill(
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/Signup.jpeg'),
              ),
            ),
             Padding(
              padding:  EdgeInsets.all(10),
              child: SignUpForm(),
            )
          ],
        ),
      ),
    );
  }
}





