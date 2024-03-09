import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';

class DetailsForPortal_Instructor extends StatelessWidget {
  const DetailsForPortal_Instructor({
    super.key,
    required this.name,
    required this.number,
  });

  final String name;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10.0,
      left: 20.0,
      right: 20.0,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF000000),
                Color(0xFFEC9D52)], // Define your gradient colors here
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.work,
                      size: 110,
                      color: tdbrown,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Learning PlatForm App',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold, color: tdBlue),
                        ),
                        Text(
                          'Available ${name}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold, color: tdBlue),
                        ),
                        Text(
                          '${number} ${name}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold, color: tdBlue),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}
