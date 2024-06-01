import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Padding(
      padding: const EdgeInsets.all(5.0).w,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7).w,
          color: tdbrown,
        ),
        child: ListTile(
          title: Text(
           portals.portalName,
            style:  TextStyle(color: tdBlue, fontWeight: FontWeight.bold,fontSize: 12.sp),
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
      ),
    );
  }
}
