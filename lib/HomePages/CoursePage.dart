import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/Widget/CourseOfPortal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class CourseListView extends StatefulWidget {
  int? portalid;
  CourseListView({super.key, required this.portalid});

  @override
  State<CourseListView> createState() => _CourseListViewState();
}

class _CourseListViewState extends State<CourseListView> {
  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    getCourse();
  }

  Future<void> getCourse() async {
    try {
      Uri url = Uri.parse('http://192.168.1.13/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=SelectAll');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> courseJsonList = jsonDecode(response.body);
        List<Course> fetchedCourses = courseJsonList.map((json) {
          final parsedJson = json as Map<String, dynamic>;
          parsedJson['CoursePrice'] = double.parse(parsedJson['CoursePrice']);
          parsedJson['TrainerShareRate'] = double.parse(parsedJson['TrainerShareRate']);
          parsedJson['CreateDate'] = {'date': parsedJson['CreateDate']['date']};
          return Course.fromJson(parsedJson);
        }).toList();
        List<Course> filteredCourses = fetchedCourses.where((course) => course.portalID == widget.portalid).toList();
        setState(() {
          courses = filteredCourses;
        });
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      setState(() {
        courses = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Course',
          style: TextStyle(color: tdBlue),
        ),
        centerTitle: true,
        backgroundColor: tdbrown,
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, i) {
          Course course = courses[i];
          return Courseofportal(course: course);
        },
      ),
    );
  }
}

