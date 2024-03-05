import 'package:flutter/material.dart';
import 'package:learningplatformapp/Homepage/widget/RecommendedCourse.dart';
import 'package:learningplatformapp/futureapi/CourseApi.dart';
import 'package:learningplatformapp/futureapi/TrainerApi.dart';
import 'widget/dialogpage.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'widget/specialforyou.dart';
import 'widget/courseviwe.dart';
import 'widget/LatestCourseAdded.dart';
import 'dart:math';
import 'widget/RandomCourse.dart';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    getData(context);
  }

  Future<void> getData(BuildContext context) async {
    try {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      final userId = provider.userId;
      await Future.wait([
        getAllCourses(context),
        getCourseNew(context),
        getCourseView(context),
        getRandomCourse(context),
        getTrainer(context),
        fetchTrainers(context, userId),
      ]);
      provider.notifyListeners(); // Notify listeners about data change
      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void showNoConnectionSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text('No internet connection'),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> reloadPage() async {
    try {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      provider.deleteAllItems(); // Delete all items before fetching new data
      await getData(context);
    } catch (e) {
      showNoConnectionSnackBar(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    //getData(context);
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context, listen: true);
    var courseviews = appDataProvider.courseviews;
    var courseadd = appDataProvider.courseadd;
    var allCourses = appDataProvider.allCourses;
    var randomcourse = appDataProvider.randomcourse;
    var users = appDataProvider.users;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: reloadPage,
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
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: const Text(
                            'Learning PlatForm App',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: tdbrown,
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
                      child: Container(
                        width: 50,
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: user != null &&
                                  user.isNotEmpty &&
                                  user[0].tpicture != null
                              ? Image.network(
                                  user[0].tpicture!,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return CircularProgressIndicator();
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/user.png',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Image.asset(
                                  'assets/user.png',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
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
                                'Welcome Back ${users.isNotEmpty ? users[0].toString() : ""}\n',
                            style: const TextStyle(
                              color: tdBlue,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            children: const [
                              TextSpan(
                                text: 'Start learning now!',
                                style: TextStyle(color: tdBlue, fontSize: 20),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                courseviews.isEmpty
                    ? Container() // Display nothing if the array is empty
                    : Column(
                        children: [
                          Specialforyou(
                              text: 'Most Viewed Courses', press: () {
                                Navigator.pushNamed(context, '/mostview');
                          }),
                          const SizedBox(height: 5),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: courseviews.isEmpty
                                    ? []
                                    : List.generate(
                                        min(3, courseviews.length),
                                        (i) {
                                          if (courseviews.isNotEmpty) {
                                            return CourseView(
                                              cname: courseviews[i].name,
                                              image:
                                                  'assets/courseview/image${i + 1}.png',
                                              price: courseviews[i].price,
                                              view: courseviews[i].view,
                                              press: () {},
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                courseadd.isEmpty
                    ? Container() // Display nothing if the array is empty
                    : Column(
                        children: [
                          const SizedBox(height: 5),
                          Specialforyou(
                              text: 'Latest Course Added', press: () {}),
                          const SizedBox(height: 5),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: Row(
                                children: List.generate(
                                  min(4, courseadd.length),
                                  (i) {
                                    if (courseadd.isNotEmpty) {
                                      return LatestCourseAdd(
                                        image:
                                            'assets/latestadd/image${i + 1}.png',
                                        price: courseadd[i].price,
                                        name: courseadd[i].name,
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                allCourses.isEmpty
                    ? Container()
                    : Column(
                        children: [
                          const SizedBox(height: 10),
                          Specialforyou(
                              text: 'Recommended Course', press: () {}),
                          const SizedBox(height: 5),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Row(
                                children: allCourses.isEmpty
                                    ? [] // Display nothing if the array is empty
                                    : List.generate(
                                        min(5, allCourses.length),
                                        (i) {
                                          if (allCourses.isNotEmpty) {
                                            return RecommendedCourse(
                                              cname: allCourses[i].name,
                                              image: 'assets/rc/i${i + 1}.png',
                                              price: allCourses[i].price,
                                              press: () {},
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                randomcourse.isEmpty
                    ? Container()
                    : Column(
                        children: [
                          const SizedBox(height: 10),
                          Specialforyou(text: 'For you', press: () {}),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Row(
                                children: randomcourse.isEmpty
                                    ? [] // Display nothing if the array is empty
                                    : List.generate(
                                        min(5, randomcourse.length),
                                        (i) {
                                          if (randomcourse.isNotEmpty) {
                                            return RandomCourse(
                                              cname: randomcourse[i].name,
                                              image: 'assets/rac/i${i + 1}.png',
                                              price: randomcourse[i].price,
                                              press: () {},
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
