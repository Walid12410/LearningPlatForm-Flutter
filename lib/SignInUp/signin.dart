import 'package:flutter/material.dart';
import 'package:learningplatformapp/TrainerPage/Homepage/homepage.dart';
import 'package:learningplatformapp/mainpages/HomePage.dart';
import 'package:learningplatformapp/SignInUp/Dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/SignInUp/WidgetsForSignIn/siginform.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';

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


  Future<void> saveLoginInfo(BuildContext context, String username, int uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    prefs.setString('username', username);
    prefs.setInt('uid', uid);
    Provider.of<AppDataProvider>(context, listen: false).setUserId(uid); // Update the user ID in the provider
  }

  Future<void> checkLogin(BuildContext context, String username, String password) async {
    String apiUrl = 'http://192.168.1.12/EduPlatform/CMS/api/LoginPage.php';
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
        String? userType = responseData['usertype']; // Assuming 'usertype' is the key for the user type in the response
        if (userID != null) {
          if (rememberMe) {
            await saveLoginInfo(context, username, userID);
          }
          if (userType == 'TR') {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePageTrainer()));
          } else if (userType == 'ST') {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
          }
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
                Color(0xFF000000),
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

