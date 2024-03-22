import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/colors/color.dart';

class LatestCourseAdd extends StatelessWidget {
  const LatestCourseAdd({
    super.key,
    required this.courses
  });

  final List<Course> courses; // Assuming you have a Course model


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: Container(
        child: Column(
          children: [
            for (final course in courses)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  course.name,
                  style: const TextStyle(color: tdBlue, fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis),
                ),
                subtitle: Text(
                  course.description,
                  style: const TextStyle(color: tdBlue,
                      overflow: TextOverflow.ellipsis),
                ),
                trailing: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2), // Adjust border radius as needed
                    child: Image.asset(
                      'assets/image1.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
