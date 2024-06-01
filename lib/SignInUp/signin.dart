import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    Provider.of<AppDataProvider>(context, listen: false).setUserId(uid);
  }

  Future<void> checkLogin(
      BuildContext context, String username, String password) async {
    String apiUrl = 'http://192.168.1.5/api/walid/login.php';
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
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0).w,
                    child: TextField(
                      controller: usernameController,
                      style: TextStyle(fontSize: 12.sp),
                      decoration: InputDecoration(
                        hintText: S.of(context).UserName,
                        fillColor: const Color(0xffD8D8DD),
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0).w,
                    child: TextField(
                      controller: passwordController,
                      obscureText: isObscure,
                      style: TextStyle(fontSize: 12.sp),
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
                    padding: const EdgeInsets.all(15).w,
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
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          S.of(context).RememberMe,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey.shade200,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          S.of(context).forgetPassword,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
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
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        S.of(context).DoNotHaveAccount,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey.shade200,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()),
                          );
                        },
                        child: Text(
                          S.of(context).Signup,
                          style:  TextStyle(
                            color: tdbrown,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
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
