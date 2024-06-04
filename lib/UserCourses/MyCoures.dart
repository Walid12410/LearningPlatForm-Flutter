import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/CouseDetails/details.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/mainpages/HomePage.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';
import '../provider/provider_data.dart';

class UserCourse extends StatefulWidget {
  const UserCourse({Key? key}) : super(key: key);

  @override
  State<UserCourse> createState() => _UserCourseState();
}

class _UserCourseState extends State<UserCourse> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      provider.getParticipation().then((_) {
        checkStudents();
      });
      _startTimer();
    });
  }

  void _startTimer() {
    setState(() {
      _isLoading = true;
    });
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void checkStudents() {
    final provider = Provider.of<AppDataProvider>(context, listen: false);
    var participationData = provider.participation;
    int userId = provider.userId;
    if (participationData.isNotEmpty) {
      setState(() {
        for (var participation in participationData) {
          if (participation.userID == userId &&
              participation.fullPlatform == 1) {
            provider.getAllCourse();
            return;
          } else if (participation.userID == userId &&
              participation.fullPlatform == 0) {
            provider.getUserCourse(participation.parID);
            return;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: true);
    var userCourses = provider.userCourse;
    var allCourses = provider.allCourses;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          S.of(context).MyCourse,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 12.sp),
        ),
        backgroundColor: tdbrown,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (_isLoading)
              Center(
                child: SizedBox(
                    width: 100.w,
                    height: 100.h,
                    child: Image.asset(
                      'assets/gif-unscreen.gif',
                      fit: BoxFit.contain,
                    )),
              )
            else if (userCourses.isNotEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0).w,
                  child: ListView.builder(
                    itemCount: userCourses.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5).w,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: tdBlue),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    spreadRadius: 5)
                              ]),
                          child: ListTile(
                            title: Text(
                              userCourses[index].title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 12.sp,
                              ),
                            ),
                            subtitle: Text(
                              userCourses[index].courseDescr,
                              style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 10.sp),
                            ),
                            onTap: () {
                              Navigator.push(context, CustomPageRoute(
                                  child: CourseDetails(courseid: userCourses[index].courseID))
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            else if (allCourses.isNotEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0).w,
                  child: ListView.builder(
                    itemCount: allCourses.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5).w,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: tdBlue),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade200,
                                    spreadRadius: 5)
                              ]),
                          child: ListTile(
                            title: Text(
                              allCourses[index].title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 12.sp,
                              ),
                            ),
                            subtitle: Text(
                              allCourses[index].description,
                              style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 10.sp),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CustomPageRoute(
                                      child: CourseDetails(
                                          courseid: allCourses[index].id)));
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            else
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).YouDoNotHaveCourse,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15).w,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20).w,
                                color: tdbrown),
                            width: double.infinity,
                            height: 50.h,
                            child: Center(
                              child: Text(
                                S.of(context).HomePage,
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
