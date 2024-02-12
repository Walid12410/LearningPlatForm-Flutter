import 'package:flutter/material.dart';
import 'package:learningplatformapp/Widget/ContainerDetailsPortal_Instructor.dart';
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
  List<Course> filteredCourse = [];

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
          filteredCourse = filteredCourses;
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

  void filterCourse(String searchText){
    setState(() {
      filteredCourse = courses.where((course) =>course.name.toLowerCase().contains(searchText.toLowerCase())
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFFEC9D52),
                Color(0xFF004296)
              ])
            ),
          ),
          DetailsForPortal_Instructor(name: 'Course', number: courses.length),
          Positioned(
            top: 180.0,
            left: 20.0,
            right: 20.0,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Assuming you are inside a BuildContext
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0), // Adjust padding as needed
                    decoration: BoxDecoration(
                      color: Colors.white, // Choose your desired background color
                      borderRadius: BorderRadius.circular(20.0), // Adjust border radius as needed
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: tdBlue, // You can change the color of the icon as needed
                    ),
                  ),
                ),
                const SizedBox(width: 5,),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: tdBGColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      cursorColor: tdbrown,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search, color: tdBlue),
                      ),
                      onChanged: (value) {
                        filterCourse(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          if(courses.isEmpty)
            const Center(
              child: CircularProgressIndicator(),
            )
          else
          Padding(
            padding: const EdgeInsets.only(top: 240),
            child:Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: filteredCourse.length,
                  itemBuilder: (context, i) {
                    Course course = filteredCourse[i];
                    return Courseofportal(course: course);
                  },
                ),
              ),
            ),

          ),
        ],
      ),
    );
  }
}

