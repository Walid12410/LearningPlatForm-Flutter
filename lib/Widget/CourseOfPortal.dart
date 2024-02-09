import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/AllClass/course.dart';

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
              '${course.name}',
              style:
                  const TextStyle(color: tdBlue, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${course.description}',
              style: const TextStyle(color: tdBlue),
            ),
            trailing: Text(
              '\$${course.price}',
              style: const TextStyle(fontSize: 15, color: tdBlue),
            ),
            onTap: () {
            },
          )),
    );
  }
}
