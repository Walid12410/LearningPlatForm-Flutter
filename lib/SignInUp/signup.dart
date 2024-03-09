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
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFFEC9D52),
                Color(0xFF000000)
              ]),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/signupimage.png',
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
          ),
          const Padding(
            padding:  EdgeInsets.only(top: 235),
            child: SignUpForm(),
          )
        ],
      ),
    );
  }
}





