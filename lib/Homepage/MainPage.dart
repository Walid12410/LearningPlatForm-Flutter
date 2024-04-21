import 'package:flutter/material.dart';
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
            fit: BoxFit.fill,width: 100,height: 100),
        );
      } else {
        return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                S.of(context).LearningPlatformApp,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: tdBlue,
                                    fontSize: 25),
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
                                    width: 50,
                                    height: 50,
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
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.infinity,
                          height: 90,
                          decoration: BoxDecoration(
                            color: tdbrown,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text.rich(
                              TextSpan(
                                text:
                                    '${S.of(context).WelcomeBack} ${users.isNotEmpty ? users[0].toString() : ""}\n',
                                style: const TextStyle(
                                  color: tdBlue,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: S.of(context).StartLeaning,
                                    style: const TextStyle(
                                        color: tdBlue, fontSize: 20),
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
                              const SizedBox(height: 5),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 5),
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
                                              const SizedBox(width: 10),
                                          ],
                                        ),
                                      for (int i = 6; i < portal.length; i++)
                                        const SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
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
                              const SizedBox(height: 5),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                    padding: isArabic()
                                        ? const EdgeInsets.all(10)
                                        : const EdgeInsets.all(1),
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
                                        const SizedBox(width: 2),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                    const SizedBox(height: 5),
                    courseadd.isEmpty
                        ? Container()
                        : Column(
                            children: [
                              const SizedBox(height: 5),
                              Specialforyou(
                                  text: S.of(context).LatestCAdded,
                                  press: () {
                                    Navigator.push(
                                        context,
                                        CustomPageRoute(
                                            child: const Latestcourse()));
                                  }),
                              const SizedBox(height: 2),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: tdbrown)),
                                  child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child:
                                          LatestCourseAdd(courses: courseadd)),
                                ),
                              ),
                            ],
                          ),
                    randomcourse.isEmpty
                        ? Container()
                        : Column(
                            children: [
                              const SizedBox(height: 10),
                              Specialforyou(
                                  text: S.of(context).ForYou,
                                  press: () {
                                    Navigator.push(
                                        context,
                                        CustomPageRoute(
                                            child: const ForYouCourse()));
                                  }),
                              const SizedBox(height: 5),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Padding(
                                    padding: isArabic()
                                        ? const EdgeInsets.all(10)
                                        : const EdgeInsets.all(1),
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
                                        const SizedBox(width: 1),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 100,
                      child: Image.asset('assets/Elearning.jpeg',fit: BoxFit.cover,),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
          ),
        );
      }
    });
  }
}
