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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: tdbrown,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              portals.portalName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: tdBlue,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  portals.portalDescription,
                  style: const TextStyle(color: tdBlue),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Show Courses',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: tdBlue,
                  ),
                ),
                IconButton(
                  color: tdBlue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      CustomPageRoute(child: CourseListView(portalid: portals.portalID))
                    );
                  },
                  icon: const Icon(Icons.arrow_circle_right_rounded),
                  iconSize: 40,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
