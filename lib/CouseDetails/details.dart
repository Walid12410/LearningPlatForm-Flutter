import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/CouseDetails/Chapter.dart';
import 'package:learningplatformapp/CouseDetails/FeedbackDetails.dart';
import 'package:learningplatformapp/CouseDetails/information.dart';
import 'package:learningplatformapp/CouseDetails/quizDetails.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:learningplatformapp/futureapi/FavoriteApi.dart';
import '../futureapi/RatingCourses.dart';
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
  final PageController _pageController1 = PageController(initialPage: 0);
  int _currentPage1 = 0;
  late double averageRating =0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      provider.fetchCourseByID(widget.courseid);
      provider.getCourseTine(widget.courseid);
      provider.getPartNumber(widget.courseid);
      provider.getTrainerCourseShow(widget.courseid);
      provider.getChapterByID(widget.courseid);
      provider.getLessonById(widget.courseid);
      int userid = provider.userId;
      fetchFavoriteStatus(userid, widget.courseid);
      provider.fetchCourseByID(widget.courseid);
      provider.getParticipation().then((_) {
        checkStudents();
      });
    });
    loadData();
  }

  void loadData() async {
    try {
      final value = await fetchAverageRating(widget.courseid);
      if (mounted) {
        averageRating = value;
      }
    } catch (error) {
      print('Error: $error');
    }
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

  void _handlePageTap(int page) {
    _pageController1.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    setState(() {
      _currentPage1 = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
    );

    final provider = Provider.of<AppDataProvider>(context, listen: true);
    var courseDetail = provider.CourseByID;
    var userId = provider.userId;
    if (courseDetail.isNotEmpty && widget.courseid != courseDetail[0].id) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Image.asset(
            'assets/gif-unscreen.gif',
            width: 70.w,
            height: 70.h,
            fit: BoxFit.fill,
          ),
        ),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 20.w,
                            color: Colors.black,
                          ),
                        ),
                        if (courseDetail.isNotEmpty)
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  courseDetail[0].title,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w900,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FeedbackCourse(
                                              courseId: widget.courseid)));
                                },
                                child: Icon(
                                  Icons.feedback,
                                  color: tdBlue,
                                  size: 20.w,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
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
                                child: Icon(
                                  _isFavorite
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: tdBlue,
                                  size: 20.w,
                                ),
                              ),
                            ],
                          ),
                        SizedBox(height: 5.h),
                        Text(
                          S.of(context).CourseDetailDesc,
                          style: TextStyle(fontSize: 10.sp),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _handlePageTap(0);
                                },
                                child: Text(
                                  'Featured',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: _currentPage1 == 0
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color:
                                        _currentPage1 == 0 ? tdBlack : tdGrey,
                                  ),
                                ),
                              ),
                              Container(
                                width: 65.w,
                                height: 1.h,
                                decoration: BoxDecoration(
                                  color: _currentPage1 == 0
                                      ? tdBlack
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(4).w,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _handlePageTap(1);
                                },
                                child: Text(
                                  'On Sale',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: _currentPage1 == 1
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color:
                                        _currentPage1 == 1 ? tdBlack : tdGrey,
                                  ),
                                ),
                              ),
                              Container(
                                width: 60.w,
                                height: 1.h,
                                decoration: BoxDecoration(
                                  color: _currentPage1 == 1
                                      ? tdBlack
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(4).w,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _handlePageTap(2);
                                },
                                child: Text(
                                  'Top Rated',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: _currentPage1 == 2
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color:
                                        _currentPage1 == 2 ? tdBlack : tdGrey,
                                  ),
                                ),
                              ),
                              Container(
                                width: 70.w,
                                height: 1.h,
                                decoration: BoxDecoration(
                                  color: _currentPage1 == 2
                                      ? tdBlack
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(4).w,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      ExpandablePageView(
                        controller: _pageController1,
                        onPageChanged: (page) {
                          setState(() {
                            _currentPage1 = page.toInt();
                          });
                        },
                        children: [
                          CourseInformation(courseid: widget.courseid, averageRating: averageRating),
                          chapterPage(courseid: widget.courseid, isStudent: isStudent),
                          Quizzes(courseId: widget.courseid, isStudent: isStudent),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 40.h,
        color: Colors.white,
        child: isStudent
            ? Center(
                child: Text(
                  S.of(context).CourseEnroll,
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              )
            : GestureDetector(
                onTap: () {},
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.w),
                    border: Border.all(color: Colors.black),
                    color: tdbrown,
                  ),
                  child: Center(
                    child: Text(
                      'Enroll Now',
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
