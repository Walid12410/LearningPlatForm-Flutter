import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/SignInUp/WidgetsForSignUp/signupform.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
             const Positioned.fill(
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/Signup.jpeg'),
              ),
            ),
             Padding(
              padding: const  EdgeInsets.all(10).w,
              child:const SignUpForm(),
            )
          ],
        ),
      ),
    );
  }
}





