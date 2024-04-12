import 'package:flutter/material.dart';
import 'package:learningplatformapp/SignInUp/signup.dart';
import 'package:learningplatformapp/TrainerPage/Homepage/homepage.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/mainpages/HomePage.dart';
import 'package:learningplatformapp/SignInUp/Dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:animated_switch/animated_switch.dart';
import 'package:intl/intl.dart';
import '../generated/l10n.dart';

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

  void toggleRememberMe() {
    setState(() {
      rememberMe = !rememberMe;
    });
  }

  Future<void> saveLoginInfo(
      BuildContext context, String username, int uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    prefs.setString('username', username);
    prefs.setInt('uid', uid);
    Provider.of<AppDataProvider>(context, listen: false)
        .setUserId(uid); // Update the user ID in the provider
  }

  Future<void> checkLogin(
      BuildContext context, String username, String password) async {
    String apiUrl = 'http://192.168.1.4/api/walid/login.php';
    var response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'username': username,
        'password': password,
      },
    );
    if (response.body.isNotEmpty) {
      var responseData = json.decode(response.body);
      if (responseData['status'] != null &&
          responseData['status'] is bool &&
          responseData['status']) {
        int? userID = responseData['userID']?.toInt();
        String? userType = responseData['usertype'];
        if (userID != null) {
          if (rememberMe) {
            await saveLoginInfo(context, username, userID);
          }
          if (userType == 'TR') {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePageTrainer()));
          } else if (userType == 'ST') {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          }
        }
      } else {
        ShowDialog(context, S.of(context).LoginFail, responseData['message']);
      }
    }
  }

  bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage('assets/loginwelcome.jpeg'),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.black,
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.15),
              Colors.black.withOpacity(0.5),
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    S.of(context).signIn,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: S.of(context).emailAddress,
                        fillColor: Color(0xffD8D8DD),
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        hintText: S.of(context).password,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscure ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                        ),
                        fillColor: const Color(0xffD8D8DD),
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        AnimatedSwitch(
                          value: rememberMe,
                          colorOn: tdbrown,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          S.of(context).RememberMe,
                          style:  TextStyle(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          S.of(context).forgetPassword,
                          style:  TextStyle(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      String username = usernameController.text;
                      String password = passwordController.text;
                      checkLogin(context, username, password);
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEC9D52),
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).signIn,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: isArabic()
                        ? const EdgeInsets.only(right: 100.0, top: 30)
                        : const EdgeInsets.only(left: 100.0, top: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).DoNotHaveAccount,
                          style:  TextStyle(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()),
                            );
                          },
                          child: Text(
                            S.of(context).Signup,
                            style: const TextStyle(
                              color: tdbrown,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
