import 'package:flutter/material.dart';
import 'package:learningplatformapp/mainpages/HomePage.dart';
import 'package:learningplatformapp/SignInUp/Dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/SignInUp/WidgetsForSignIn/siginform.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isObscure = true;
  bool rememberMe = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void toggleRememberMe() {
    setState(() {
      rememberMe = !rememberMe;
    });
  }

  Future<void> saveLoginInfo(String username, int uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    prefs.setString('username', username);
    prefs.setInt('uid', uid);
  }

  Future<void> checkLogin(BuildContext context, String username, String password) async {
    String apiUrl = 'http://192.168.1.34/EduPlatform/CMS/api/LoginPage.php';
    var response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'username': username,
        'password': password,
      },
    );
    if (response.body.isNotEmpty) {
      var responseData = json.decode(response.body);
      if (responseData['status'] != null && responseData['status'] is bool &&
          responseData['status']) {
        int? userID = responseData['userID']?.toInt();
        if (userID != null) {
          if (rememberMe) {
            await saveLoginInfo(username, userID);
          }
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage(uid: userID)));
        }
      } else {
        ShowDialog(context, 'Login Failed', responseData['message']);
      }
    }
  }


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
                Color(0xFF004296),
              ]),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/loginwelcome.png', // Replace with your actual image asset
              fit: BoxFit.fill,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 270),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: SignInForm(
                  formKey: _formKey,
                  rememberMe: rememberMe,
                  toggleRememberMe: toggleRememberMe,
                  isObscure: isObscure,
                  usernameController: usernameController,
                  passwordController: passwordController,
                  toggleVisibility: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await checkLogin(context, usernameController.text, passwordController.text);
                    }
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

