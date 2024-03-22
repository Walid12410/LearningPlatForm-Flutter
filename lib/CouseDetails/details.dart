import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/CouseDetails/Chapter.dart';
import 'package:learningplatformapp/CouseDetails/information.dart';
import 'package:learningplatformapp/CouseDetails/quiz.dart';
import 'package:learningplatformapp/CouseDetails/tabcontroller.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/futureapi/CourseApi.dart';
import 'package:learningplatformapp/futureapi/TotalCourseTime.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:learningplatformapp/futureapi/VideoPart.dart';
import 'package:learningplatformapp/futureapi/FavoriteApi.dart';

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      int userid = provider.userId;
      fetchFavoriteStatus(userid, widget.courseid);
      provider.getFirstVideo(widget.courseid);
      provider.fetchCourseByID(widget.courseid);
    });
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
    var fvideo = provider.fvideo;

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
                                  icon: Icon(
                                    _isFavorite
                                        ? Icons.bookmark
                                        : Icons.bookmark_border,
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
                        CourseInformation(
                          courseid: widget.courseid,
                          fvideo: fvideo.isNotEmpty ? fvideo[0].video : '',
                        ),
                        Chapter(),
                        Quizzes(), // Third tab with the stateful page
                      ],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
