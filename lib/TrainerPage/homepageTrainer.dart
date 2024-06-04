import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../SignInUp/signin.dart';

class HomePageTrainer extends StatefulWidget {
  const HomePageTrainer({super.key});

  @override
  State<HomePageTrainer> createState() => _HomePageTrainerState();
}

class _HomePageTrainerState extends State<HomePageTrainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 200.w,
              height: 150.h,
              child: Image.asset('assets/emptypage.png',fit: BoxFit.contain,),
            ),
          ),
          Center(
              child: Text('Should Pay To Show Trainer Pages',
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold))),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('isLoggedIn');
              await prefs.remove('username');
              await prefs.remove('uid');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SignIn()),
                (route) => false,
              );
            },
            child: Container(
              width: 150.w,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: tdbrown,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      spreadRadius: 5
                    )
                  ],
                  borderRadius: BorderRadius.circular(200).w),
              child: Padding(
                padding: const EdgeInsets.all(8.0).w,
                child: Center(
                    child: Text(
                  'LogOut',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: Colors.black),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
