import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';

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
        title: const Text(
          'About Our Application',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: tdbrown,
      ),
      body: const SafeArea(
        child: Stack(
          children: [
            Positioned(
                child: Image(
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              image:AssetImage(
                'assets/Signup.jpeg',
              ),
            )),
             Padding(
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Embark on a transformative journey of learning and personal development through our cutting-edge learning platform app, where boundless knowledge meets endless possibilities for growth and exploration.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.black),
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
