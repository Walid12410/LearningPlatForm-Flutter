import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/Widget/ContainerDetailsPortal_Instructor.dart';
import 'package:learningplatformapp/Widget/CourseOfTrainer.dart';
import 'package:learningplatformapp/colors/color.dart';


class TrainerCourse extends StatefulWidget {
  int userid;
  TrainerCourse({super.key,required this.userid});

  @override
  State<TrainerCourse> createState() => _TrainerCourseState();
}

class _TrainerCourseState extends State<TrainerCourse> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCourses(widget.userid);
  }

  Future<void> _fetchCourses(int userid) async {
    setState(() {
      _isLoading = true; // Set isLoading to true when fetching starts
    });
    try {
      await getCourseTrainer(userid); // Wait for getCourse to complete
    } catch (e) {
      print('Error fetching trainseid: $e');
    } finally {
      setState(() {
        _isLoading = false; // Set isLoading to false when fetching completes
      });
    }
  }

  void filterCourse(String searchText) {
    setState(() {
      filterCoursestrainer = coursestrainer
          .where((course) => course.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
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
          DetailsForPortal_Instructor(name: 'Instructor Course', number: coursestrainer.length),
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
          if (_isLoading) // Show CircularProgressIndicator if isLoading is true
            const Center(
                child: SizedBox(width: 150, height: 150,
                    child: CircularProgressIndicator(
                      color: tdbrown,
                    ))
            )
          else// Show the course list if not loading
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
                    itemCount: filterCoursestrainer.length,
                    itemBuilder: (context, i) {
                      Course course = filterCoursestrainer[i];
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

