import 'package:flutter/material.dart';
import 'package:learningplatformapp/HomePages/HomePage.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn>{
  bool isObscure = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> checkLogin(String username, String password) async {
    String apiUrl = 'http://192.168.1.55/EduPlatForm/CMS/api/TrainerCrudOperation.php?operation=Login';
    var response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'username': username,
        'password': password,
      },
    );
    var responseData = json.decode(response.body);
    if (!responseData['error']) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text(responseData['message']),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK',style: TextStyle(color: tdBlue),),
              ),
            ],
          );
        },
      );
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
                ])
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
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.3,
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
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    const Text('Welcome Back', style: TextStyle(
                        fontSize: 40,
                        color: tdbrown,
                        fontWeight: FontWeight.bold
                    ),),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50),
                          TextField(
                            controller: usernameController,
                            decoration: InputDecoration(
                              labelText: 'UserName',
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: tdBlue,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(color: tdBlue, width: 1),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 1),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: passwordController,
                            obscureText: isObscure,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: tdBlue,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(color: tdBlue, width: 1),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isObscure ? Icons.visibility_off : Icons
                                      .visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (value) {},
                              ),
                              const Text(
                                'Remember me', style: TextStyle(fontSize: 15,
                                  color: tdBlue),),
                              const Spacer(),
                              TextButton(onPressed: () {}, child:
                              const Text('Forget Password?', style: TextStyle(
                                fontSize: 15, color: tdBlue,
                                decoration: TextDecoration.underline,
                              ),))
                            ],
                          ),
                          const SizedBox(height: 14),
                          Container(
                            height: 50,
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                gradient: const LinearGradient(colors: [
                                  Color(0xFFEC9D52),
                                  Color(0xFF004296),
                                ])),
                            child: TextButton(
                                onPressed: () {
                                  checkLogin(usernameController.text,
                                      passwordController.text);
                                },
                              child: const Text(
                                'SIGN IN',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don`t Have Account?', style: TextStyle(
                                  fontSize: 15,
                                  color: tdBlue,
                                  fontWeight: FontWeight.bold
                              ),),
                              TextButton(onPressed: () {}, child: const Text(
                                'SIGNUP', style: TextStyle(fontSize: 15,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}