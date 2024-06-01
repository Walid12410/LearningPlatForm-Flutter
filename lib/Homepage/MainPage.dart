import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/CouseDetails/details.dart';
import 'package:learningplatformapp/SeeMoreCourse/ForyouView.dart';
import 'package:learningplatformapp/SeeMoreCourse/LatestCourseView.dart';
import 'package:learningplatformapp/SeeMoreCourse/MostViewCourse.dart';
import 'package:learningplatformapp/mainpages/CoursePage.dart';
import 'package:learningplatformapp/mainpages/PortalPage.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import '../generated/l10n.dart';
import 'widget/dialogpage.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'widget/specialforyou.dart';
import 'widget/courseviwe.dart';
import 'widget/LatestCourseAdded.dart';
import 'widget/RandomCourse.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'widget/Categories.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      final userId = provider.userId;
      provider.getCourseadd();
      provider.getcourseview();
      provider.getrandomcourse();
      provider.getportal();
      provider.getTrainer(userId);
    });
    super.initState();
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void showNoConnectionSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('No internet connection'),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppDataProvider>(builder: (context, provider, child) {
      var courseviews = provider.courseviews;
      var courseadd = provider.courseadd;
      var randomcourse = provider.randomcourse;
      var users = provider.users;
      var portal = provider.portals;
      if (courseviews.isEmpty &&
          courseadd.isEmpty &&
          randomcourse.isEmpty &&
          users.isEmpty &&
          portal.isEmpty) {
        return  Center(
          child: Image.asset('assets/gif-unscreen.gif',
            fit: BoxFit.fill,width: 70.w,height: 70.h),
        );
      } else {
        return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5,right: 5).w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0).w,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0).w,
                                child: Text(
                                  S.of(context).LearningPlatformApp,
                                  style:  TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: tdBlue,
                                      fontSize: 18.sp),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DialogPage(); // Custom dialog page
                                  },
                                );
                              },
                              child: users.isNotEmpty
                                  ? Container(
                                      width: 40.w,
                                      height: 35.h,
                                      child: users[0].picture == ''
                                          ? ClipOval(
                                              child: Image.asset(
                                                'assets/user.png',
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl: users[0].picture,
                                                placeholder: (context, url) =>
                                                    Image.asset('assets/gif-unscreen.gif',
                                                      fit: BoxFit.cover,),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Image.asset(
                                                  'assets/user.png',
                                                  fit: BoxFit.cover,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ))
                                  : const CircularProgressIndicator(
                                      color: tdbrown,
                                    )),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0).w,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: tdbrown,
                            borderRadius: BorderRadius.circular(15).w,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0).w,
                            child: Text.rich(
                              TextSpan(
                                text:
                                    '${S.of(context).WelcomeBack} ${users.isNotEmpty ? users[0].toString() : ""}\n',
                                style:  TextStyle(
                                  color: tdBlue,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: S.of(context).StartLeaning,
                                    style:  TextStyle(
                                        color: tdBlue, fontSize: 18.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    portal.isEmpty
                        ? Container()
                        : Column(
                            children: [
                              Specialforyou(
                                  text: S.of(context).Categories,
                                  press: () {
                                    Navigator.push(
                                        context,
                                        CustomPageRoute(
                                            child: const PortalPage()));
                                  }),
                               SizedBox(height: 5.h),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.all(2).w,
                                  child: Row(
                                    children: [
                                       SizedBox(width: 5.w),
                                      for (int i = 0;
                                          i < 6 && i < portal.length;
                                          i++)
                                        Row(
                                          children: [
                                            Categories(
                                              name: portal[i].portalName,
                                              press: () {
                                                Navigator.push(
                                                    context,
                                                    CustomPageRoute(
                                                        child: CourseListView(
                                                            portalid: portal[i]
                                                                .portalID)));
                                              },
                                            ),
                                            if (i < 5 && i < portal.length - 1)
                                               SizedBox(width: 5.w),
                                          ],
                                        ),
                                      for (int i = 6; i < portal.length; i++)
                                         SizedBox(width: 5.w),
                                    ],
                                  ),
                                ),
                              ),
                               SizedBox(height: 5.h),
                            ],
                          ),
                    SizedBox(height: 5.h,),
                    courseviews.isEmpty
                        ? Container()
                        : Column(
                            children: [
                              Specialforyou(
                                  text: S.of(context).MViewCourse,
                                  press: () {
                                    Navigator.push(
                                        context,
                                        CustomPageRoute(
                                            child: const MostView()));
                                  }),
                              SizedBox(height: 5.h,),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                    padding: isArabic()
                                        ? const EdgeInsets.all(10).w
                                        : const EdgeInsets.all(1).w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        for (final courseView in courseviews)
                                          Consumer<AppDataProvider>(
                                            builder: (context,
                                                averageRatingProvider, _) {
                                              final double? averageRating =
                                                  averageRatingProvider
                                                          .averageRatings[
                                                      courseView.id];
                                              if (averageRating == null) {
                                                averageRatingProvider
                                                    .fetchAndSetAverageRating(
                                                        courseView.id);
                                                return Container();// Placeholder while loading
                                              } else {
                                                return CourseView(
                                                  cname: courseView.title,
                                                  image: 'assets/image1.png',
                                                  price: courseView.price,
                                                  view: courseView.view,
                                                  press: () {
                                                    Navigator.push(
                                                        context,
                                                        CustomPageRoute(
                                                            child: CourseDetails(
                                                                courseid:
                                                                    courseView
                                                                        .id)));
                                                  },
                                                  desc: courseView.description,
                                                  averageRating: averageRating,
                                                );
                                              }
                                            },
                                          ),
                                         SizedBox(width: 2.w),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                    SizedBox(height: 5.h,),
                    courseadd.isEmpty
                        ? Container()
                        : Column(
                            children: [
                               SizedBox(height: 2.h),
                              Specialforyou(
                                  text: S.of(context).LatestCAdded,
                                  press: () {
                                    Navigator.push(
                                        context,
                                        CustomPageRoute(
                                            child: const Latestcourse()));
                                  }),
                               SizedBox(height: 2.h),
                              Padding(
                                padding: const EdgeInsets.all(5).w,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15).w,
                                      border: Border.all(color: tdbrown)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(2).w,
                                      child:
                                          LatestCourseAdd(courses: courseadd)),
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: 5.h,),
                    randomcourse.isEmpty
                        ? Container()
                        : Column(
                            children: [
                               SizedBox(height: 5.h),
                              Specialforyou(
                                  text: S.of(context).ForYou,
                                  press: () {
                                    Navigator.push(
                                        context,
                                        CustomPageRoute(
                                            child: const ForYouCourse()));
                                  }),
                              SizedBox(height: 5.h),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                    padding: isArabic()
                                        ? const EdgeInsets.all(10).w
                                        : const EdgeInsets.all(1).w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        for (final random in randomcourse)
                                          Consumer<AppDataProvider>(
                                            builder: (context,
                                                averageRatingProvider, _) {
                                              final double? averageRating =
                                                  averageRatingProvider
                                                          .averageRatings[
                                                      random.id];
                                              if (averageRating == null) {
                                                averageRatingProvider
                                                    .fetchAndSetAverageRating(
                                                        random.id);
                                                return Container();
                                              } else {
                                                return RandomCourse(
                                                  cname: random.title,
                                                  image: 'assets/image1.png',
                                                  price: random.price,
                                                  press: () {
                                                    Navigator.push(
                                                        context,
                                                        CustomPageRoute(
                                                            child: CourseDetails(
                                                                courseid: random
                                                                    .id)));
                                                  },
                                                  averagerate: averageRating,
                                                  desc: random.description,
                                                );
                                              }
                                            },
                                          ),
                                         SizedBox(width: 1.w),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                     SizedBox(height: 20.h),
                  ],
                ),
              ),
          ),
        );
      }
    });
  }
}
