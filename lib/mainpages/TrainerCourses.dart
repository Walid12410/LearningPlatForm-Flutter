import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/Widget/ContainerDetailsPortal_Instructor.dart';
import 'package:learningplatformapp/Widget/CourseOfTrainer.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:learningplatformapp/futureapi/CourseApi.dart';
import 'package:provider/provider.dart';

class TrainerCourse extends StatefulWidget {
  int userid;
  TrainerCourse({super.key, required this.userid});

  @override
  State<TrainerCourse> createState() => _TrainerCourseState();
}

class _TrainerCourseState extends State<TrainerCourse> {


  @override
  void initState() {
    super.initState();
    getData(context); // Fetch data when the widget is first initialized
  }

  void getData(context) {
    getCourseTrainer(widget.userid, context).then((_) {
      if (_searchText.isNotEmpty) {
        filterCourse(context, _searchText);
      }
    });
  }

  void filterCourse(BuildContext context, String searchText) {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    List<Course> coursestrainer = appDataProvider.coursestrainer;
    List<Course> filteredCourses = coursestrainer
        .where((course) =>
        course.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    appDataProvider.setFilterCourseTrainer(filteredCourses);
  }

  String _searchText = ''; // Store the entered search text


  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context, listen: true);
    getData(context);
    var coursestrainer = appDataProvider.coursestrainer;
    var filterCoursestrainer = appDataProvider.filterCoursestrainer;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFFEC9D52), Color(0xFF004296)])),
            ),
            DetailsForPortal_Instructor(
                name: 'Instructor Course', number: coursestrainer.length),
            Positioned(
              top: 130.0,
              left: 20.0,
              right: 20.0,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                          context); // Assuming you are inside a BuildContext
                    },
                    child: Container(
                      padding:
                          const EdgeInsets.all(8.0), // Adjust padding as needed
                      decoration: BoxDecoration(
                        color:
                            Colors.white, // Choose your desired background color
                        borderRadius: BorderRadius.circular(
                            20.0), // Adjust border radius as needed
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color:
                            tdBlue, // You can change the color of the icon as needed
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
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
            // if (filterCoursestrainer.isEmpty) // Show CircularProgressIndicator if isLoading is true
            //   const Center(
            //       child: SizedBox(
            //           width: 150,
            //           height: 150,
            //           child: CircularProgressIndicator(
            //             color: tdbrown,
            //           )))
            // else // Show the course list if not loading
              Padding(
                padding: const EdgeInsets.only(top: 195),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: filterCoursestrainer.length,
                      itemBuilder: (context, i) {
                        Course course = filterCoursestrainer[i];
                        return CourseOfTrainer(courses: course);
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
