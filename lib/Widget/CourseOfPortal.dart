import 'package:flutter/material.dart';
import 'package:learningplatformapp/CouseDetails/details.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';

class Courseofportal extends StatelessWidget {
  const Courseofportal({
    super.key,
    required this.course,
  });

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: tdbrown),
          child: ListTile(
            title: Text(
              course.title,
              style:
                  const TextStyle(color: tdBlue, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              course.description,
              style: const TextStyle(color: tdBlue),
            ),
            trailing: Text(
              '\$${course.price}',
              style: const TextStyle(fontSize: 15, color: tdBlue),
            ),
            onTap: () {
              Navigator.push(context,
                  CustomPageRoute(child: CourseDetails(courseid: course.id)));
            },
          )),
    );
  }
}
