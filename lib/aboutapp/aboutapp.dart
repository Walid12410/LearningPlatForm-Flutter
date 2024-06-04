import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/colors/color.dart';

import '../generated/l10n.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).aboutOurAppFullSentence,
          style:  TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: tdbrown,
      ),
      body:  SafeArea(
        child: Stack(
          children: [
            const Positioned(
                child: Image(
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              image:AssetImage(
                'assets/Signup.jpeg',
              ),
            )),
             Padding(
              padding:const EdgeInsets.all(5).w,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).aboutDetails,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp,
                          color: Colors.black),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
