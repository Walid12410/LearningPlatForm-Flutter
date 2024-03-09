import 'package:flutter/material.dart';
import 'package:learningplatformapp/Widget/ContainerDetailsPortal_Instructor.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/Widget/CourseOfPortal.dart';
import 'package:learningplatformapp/futureapi/CourseApi.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';

class CourseListView extends StatefulWidget {
  int portalid;
  CourseListView({super.key, required this.portalid});

  @override
  State<CourseListView> createState() => _CourseListViewState();
}

class _CourseListViewState extends State<CourseListView> {



  void getData(context){
    getCourse(widget.portalid,context).then((_) {
      if (_searchText.isNotEmpty) {
        filterCourse(context, _searchText);
      }
    });
  }

  void filterCourse(BuildContext context, String searchText) {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    List<Course> courses = appDataProvider.courses;
    List<Course> filteredCourses = courses
        .where((course) => course.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    appDataProvider.setFilterCourse(filteredCourses);
  }

  String _searchText = ''; // Store the entered search text


  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context, listen: true);
    getData(context);
    var courses = appDataProvider.courses;
    var filteredCourse = appDataProvider.filteredCourse;


    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFFEC9D52),
                  Color(0xFF000000)
                ])
              ),
            ),
            DetailsForPortal_Instructor(name: 'Course', number: courses.length),
            Positioned(
              top: 130.0,
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
                          setState(() {
                            _searchText = value; // Update the search text
                          });
                          filterCourse(context, value); // Perform search
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (filteredCourse.isEmpty)
              const Center(
                child: Text(
                  'No Course available',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              )
            else
            Padding(
              padding: const EdgeInsets.only(top: 195),
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
      ),
    );
  }
}

