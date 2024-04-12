import 'package:flutter/material.dart';
import 'package:learningplatformapp/CouseDetails/Chapter.dart';
import 'package:learningplatformapp/CouseDetails/FeedbackDetails.dart';
import 'package:learningplatformapp/CouseDetails/information.dart';
import 'package:learningplatformapp/CouseDetails/quizDetails.dart';
import 'package:learningplatformapp/CouseDetails/tabcontroller.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:learningplatformapp/futureapi/FavoriteApi.dart';

import '../generated/l10n.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({required this.courseid, super.key});
  final int courseid;

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails>
    with SingleTickerProviderStateMixin {
  late AppDataProvider appDataProvider;
  late TabController _tabController;
  bool _isFavorite = false;
  bool isStudent = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      int userid = provider.userId;
      fetchFavoriteStatus(userid, widget.courseid);
      provider.fetchCourseByID(widget.courseid);
      provider.getParticipation().then((_) {
        checkStudents();
      });
    });
  }

  void checkStudents() {
    final provider = Provider.of<AppDataProvider>(context, listen: false);
    var participationData = provider.participation;
    int userId = provider.userId;
    if (participationData.isNotEmpty) {
      setState(() {
        isStudent = false;
        for (var participation in participationData) {
          if (participation.userID == userId &&
              participation.fullPlatform == 1) {
            isStudent = true;
            break;
          } else if (participation.userID == userId &&
              participation.fullPlatform == 0) {
            provider.getCourseParticipated().then((_) {
              checkStudentCourse(participation.parID);
            });
            return;
          }
        }
      });
    }
  }

  void checkStudentCourse(int parId) {
    final provider = Provider.of<AppDataProvider>(context, listen: false);
    var data = provider.cParticipated;
    for (var participation in data) {
      if (participation.parID == parId &&
          participation.courseID == widget.courseid) {
        setState(() {
          isStudent = true;
        });
        break;
      }
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchFavoriteStatus(int userId, int courseId) async {
    try {
      bool isFavorite = await FavoriteService.checkFavorite(userId, courseId);
      setState(() {
        _isFavorite = isFavorite;
      });
    } catch (e) {
      print('Error fetching favorite status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: true);
    var courseDetail = provider.CourseByID;
    var userId = provider.userId;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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
                                  courseDetail[0].title,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FeedbackCourse(
                                              courseId: widget.courseid)));
                                },
                                icon: const Icon(
                                  Icons.feedback,
                                  color: tdBlue,
                                  size: 25,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  try {
                                    bool newFavoriteStatus = !_isFavorite;
                                    FavoriteService.toggleFavorite(userId,
                                        widget.courseid, newFavoriteStatus);
                                    setState(() {
                                      _isFavorite = newFavoriteStatus;
                                    });
                                  } catch (e) {
                                    print('Error toggling favorite status: $e');
                                  }
                                },
                                icon: Icon(
                                  _isFavorite
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: tdBlue,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                         Text(
                          S.of(context).CourseDetailDesc,
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
                      CourseInformation(courseid: widget.courseid),
                      Chapterpage(
                          courseid: widget.courseid, isStudent: isStudent),
                      Quizzes(
                        courseId: widget.courseid,isStudent: isStudent,
                      ), // Third tab with the stateful page
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: tdbrown, // Set the background color for the bottom app bar
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: isStudent
                ?  Text(
                    S.of(context).CourseEnroll,
                    style:const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                : ElevatedButton(
                    onPressed: () {
                      // Add action for enrolling
                    },
                    child:  Center(
                      child:  Text(
                        S.of(context).EnrollNow,
                        style:const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  )),
      ),
    );
  }
}
