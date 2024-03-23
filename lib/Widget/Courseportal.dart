import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/AllClass/portal.dart';
import 'package:learningplatformapp/mainpages/CoursePage.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';

class CoursePortal extends StatelessWidget {
  const CoursePortal({
    Key? key,
    required this.portals,
  }) : super(key: key);

  final Portal portals;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0), // Add vertical margin
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: tdbrown,
      ),
      child: ListTile(
        title: Text(
          '${portals.portalName}',
          style: const TextStyle(color: tdBlue, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${portals.portalDescription}',
          style: const TextStyle(color: tdBlue),
        ),
        onTap: () {
          Navigator.push(
            context,
            CustomPageRoute(
              child: CourseListView(portalid: portals.portalID),
            ),
          );
        },
      ),
    );
  }
}
