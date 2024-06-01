import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      padding: const EdgeInsets.all(3.0).w,
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5).w, color: tdbrown),
          child: ListTile(
            title: Text(
              courses.title,
              style:
               TextStyle(color: tdBlue, fontWeight: FontWeight.bold,fontSize: 12.sp),
            ),
            subtitle: Text(
              courses.description,
              style:  TextStyle(color: tdBlue,fontSize: 10.sp),overflow: TextOverflow.ellipsis,maxLines: 2,
            ),
            trailing: Text(
              '\$${courses.price}',
              style:  TextStyle(fontSize: 10.sp, color: tdBlue),
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
