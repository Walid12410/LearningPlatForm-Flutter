import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/CouseDetails/Chapter.dart';
import 'package:learningplatformapp/CouseDetails/information.dart';
import 'package:learningplatformapp/CouseDetails/quiz.dart';
import 'package:learningplatformapp/CouseDetails/tabcontroller.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/futureapi/CourseApi.dart';
import 'package:learningplatformapp/mainpages/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({required this.courseid, super.key});
  final int courseid;

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails>
    with SingleTickerProviderStateMixin {
  late AppDataProvider appDataProvider;
  List<Course> courseDetail = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    getData();
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<void> getData() async {
    final List<Course>? fetchedCourses =
        await getCourseByID(widget.courseid, context);
    setState(() {
      courseDetail = fetchedCourses ?? [];
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    if (courseDetail.isNotEmpty)
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${courseDetail[0].name}',
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Handle onPressed for feedback button
                            },
                            icon: const Icon(
                              Icons.feedback,
                              color: tdBlue,
                              size: 25,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Handle onPressed for bookmark button
                            },
                            icon: const Icon(
                              Icons.bookmark_border,
                              color: tdBlue,
                              size: 25,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Handle onPressed for more options button
                            },
                            icon: const Icon(
                              Icons.more_vert,
                              color: tdBlue,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    const Text(
                      'Unlock your potential today and take the next step towards success by purchasing our comprehensive course',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              CustomTabBarView(
                tabController: _tabController,
                tabViews: [
                  courseinformation(courseid: widget.courseid),
                  Chapter(),
                  Quizzes(), // Third tab with the stateful page
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
