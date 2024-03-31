import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/CouseDetails/details.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';


class CourseOfTrainer extends StatelessWidget {
  const CourseOfTrainer({
    super.key,
    required this.courses,
  });

  final Course courses;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: tdbrown),
          child: ListTile(
            title: Text(
              courses.title,
              style:
              const TextStyle(color: tdBlue, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              courses.description,
              style: const TextStyle(color: tdBlue),
            ),
            trailing: Text(
              '\$${courses.price}',
              style: const TextStyle(fontSize: 15, color: tdBlue),
            ),
            onTap: () {
              Navigator.push(context,
                  CustomPageRoute(child: CourseDetails(courseid: courses.id,)));
            },
          )
      ),
    );
  }
}
