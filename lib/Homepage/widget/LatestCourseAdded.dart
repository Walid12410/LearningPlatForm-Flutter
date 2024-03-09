import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';

class LatestCourseAdd extends StatelessWidget {
  const LatestCourseAdd({
    super.key,
    required this.image,
    required this.price,
    required this.name
  });

  final String name;
  final String image;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 250 ,
      padding:const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      margin:const  EdgeInsets.symmetric(vertical: 5,horizontal: 13),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 1,
                blurRadius: 8
            )
          ]
      ),
      child: Column(
        children: [
          InkWell(
            onTap: (){},
            child: Container(
              margin:const  EdgeInsets.all(10),
              child: Image.asset(image,width: 120,height: 120,fit: BoxFit.contain,),
            ),
          ),
          Padding(
            padding:const  EdgeInsets.only(bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Course Name',style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: tdBlue
                  ),
                  ),
                  Text(
                    name,style:const  TextStyle(fontSize: 15,
                      color: tdBlue,
                    overflow: TextOverflow.ellipsis, // Specify ellipsis as overflow
                  ),
                  ),
                ],
              ),
            ),

          ),
          Padding(
            padding:const  EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text( '\$$price',style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: tdBlue
                ),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
