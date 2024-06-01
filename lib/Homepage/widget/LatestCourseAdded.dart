import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/CouseDetails/details.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';

class LatestCourseAdd extends StatelessWidget {
  const LatestCourseAdd({super.key, required this.courses});

  final List<Course> courses; // Assuming you have a Course model

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1).w,
      child: Container(
        child: Column(
          children: [
            for (final course in courses)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  course.title,
                  style:  TextStyle(
                      color: tdBlue,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis),
                ),
                subtitle: Text(
                  course.description,
                  style:  TextStyle(
                    fontSize: 10.sp,
                      color: tdBlue, overflow: TextOverflow.ellipsis),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      CustomPageRoute(
                          child: CourseDetails(courseid: course.id)));
                },
                trailing: Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.w,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        2).w, // Adjust border radius as needed
                    child: Image.asset(
                      'assets/image1.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
