import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/Widget/ContainerDetailsPortal_Instructor.dart';
import 'package:learningplatformapp/Widget/CourseOfTrainer.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class TrainerCourse extends StatefulWidget {
  int userid;
  TrainerCourse({super.key,required this.userid});

  @override
  State<TrainerCourse> createState() => _TrainerCourseState();
}

class _TrainerCourseState extends State<TrainerCourse> {
  List<Course> courses = [];
  List<Course> filterCourses = [];

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
        List<Course> filteredCourses = fetchedCourses.where((course) => course.trainerID == widget.userid).toList();
        if (filteredCourses.isNotEmpty) {
          setState(() {
            print(filteredCourses);
            courses = filteredCourses;
            filterCourses = filteredCourses;
          });
        } else {
          throw Exception('No courses found for trainer with ID: ${widget.userid}');
        }
      } else {
        throw Exception('Failed to load courses. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching courses: $e');
      setState(() {
        courses = []; // Set courses to empty list in case of error
      });
    }
  }


  void filterCourse(String searchText){
    setState(() {
      filterCourses = courses.where((course) =>course.name.toLowerCase().contains(searchText.toLowerCase())
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
          DetailsForPortal_Instructor(name: 'Instructor Course', number: courses.length),
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
                    itemCount: filterCourses.length,
                    itemBuilder: (context, i) {
                      Course course = filterCourses[i];
                      return  CourseOfTrainer(courses: course);
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

