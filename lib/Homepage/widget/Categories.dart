import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';


class Categories extends StatelessWidget {
  const Categories({
    Key? key,
    required this.name,
    required this.press
  }) : super(key: key);

  final GestureTapCallback press;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: tdbrown,
        borderRadius:
        BorderRadius.circular(8), // Add border radius for rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: press,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            name,
            style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
