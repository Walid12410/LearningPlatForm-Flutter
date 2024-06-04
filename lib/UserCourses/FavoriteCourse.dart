import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:provider/provider.dart';
import '../CouseDetails/details.dart';
import '../generated/l10n.dart';
import '../pageroute/LeftToRight.dart';
import '../provider/provider_data.dart';

class UserFavorite extends StatefulWidget {
  const UserFavorite({super.key});

  @override
  State<UserFavorite> createState() => _UserFavoriteState();
}

class _UserFavoriteState extends State<UserFavorite> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      int userID = provider.userId;
      provider.getUserFavoriteCourse(userID);
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

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: true);
    var userCourses = provider.userFavoriteCourse;

    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).YourFavoriteCourse,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12.sp),
          ),
          centerTitle: true,
          backgroundColor: tdbrown,
        ),
        body: Center(
            child: SizedBox(
                width: 100.w,
                height: 100.h,
                child: Image.asset(
                  'assets/gif-unscreen.gif',
                  fit: BoxFit.contain,
                )),
          ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).YourFavoriteCourse,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 12.sp),
        ),
        centerTitle: true,
        backgroundColor: tdbrown,
      ),
      body: userCourses.isEmpty
          ? Center(
              child: Text(
                S.of(context).NoFavCourse,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            )
          : SafeArea(
              child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0).w,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20).w,
                        border: Border.all(color: tdbrown),
                      ),
                      child: ListView.builder(
                        itemCount: userCourses.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5).w,
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
                                userCourses[index].courseDescription,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.sp,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CustomPageRoute(
                                        child: CourseDetails(
                                            courseid:
                                                userCourses[index].courseID)));
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              ],
            )),
    );
  }
}
