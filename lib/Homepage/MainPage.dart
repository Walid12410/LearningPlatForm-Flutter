import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/Homepage/widget/RecommendedCourse.dart';
import 'widget/dialogpage.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'widget/specialforyou.dart';
import 'widget/courseviwe.dart';
import 'widget/LatestCourseAdded.dart';
import 'dart:math';

class MainPage extends StatefulWidget {
  const MainPage({required this.userid, Key? key}) : super(key: key);

  final int userid;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<Trainer>> _futureTrainers;
  bool _isLoadingTrainers = false;
  bool _isLoadingCourseViews = false;
  bool _isLoadingLatestCourses = false;
  bool _isLoadingRecommendedCourses = false;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  void _fetchData() {
    _fetchTrainers();
    _fetchRecommendedCourses();
    getCourseView();
    getCourseNew();
    getAllCourses();
  }

  void _fetchRecommendedCourses() async {
    setState(() {
      _isLoadingRecommendedCourses = true; // Set loading state to true
    });
    await Future.delayed(Duration(seconds: 2)); // Simulating delay
    setState(() {
      _isLoadingRecommendedCourses = false;
    });
  }

  void _fetchTrainers() async {
    setState(() {
      _isLoadingTrainers = true;
    });
    try {
      await fetchTrainers(widget.userid);
    } catch (e) {
      print('Error fetching trainers: $e');
    } finally {
      setState(() {
        _isLoadingTrainers = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: tdbrown,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const TextField(
                          cursorColor: tdBlue,
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search, color: tdBlue),
                          ),
                          style: TextStyle(color: tdBlue),
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
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(
                          'assets/user.png'), // Replace this with your image asset path
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
              _isLoadingCourseViews
                  ? const CircularProgressIndicator()
                  : Specialforyou(text: 'Most Viewed Courses', press: () {}),
              const SizedBox(height: 5),
              _isLoadingCourseViews
                  ? Container() // Display nothing if loading
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _isLoadingCourseViews
                              ? [const CircularProgressIndicator()]
                              : List.generate(
                                  min(
                                      3,
                                      courseviews
                                          .length), // Utilize max function to ensure at least 3 items are displayed
                                  (index) {
                                    if (index < courseviews.length) {
                                      return CourseView(
                                        cname: courseviews[index].name,
                                        image:
                                            'assets/courseview/image${index + 1}.png',
                                        price: courseviews[index].price,
                                        view: courseviews[index].view,
                                        press: () {},
                                      );
                                    } else {
                                      return const SizedBox(); // Return empty SizedBox if index is out of bounds
                                    }
                                  },
                                ),
                        ),
                      ),
                    ),
              const SizedBox(height: 5),
              _isLoadingLatestCourses
                  ? const CircularProgressIndicator()
                  : Specialforyou(text: 'Latest Course Added', press: () {}),
              const SizedBox(height: 5),
              _isLoadingLatestCourses
                  ? Container() // Display nothing if loading
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Row(
                          children: _isLoadingLatestCourses
                              ? [const CircularProgressIndicator()]
                              : List.generate(
                                  min(
                                      4,
                                      courseadd
                                          .length), // Ensure at least 4 items are displayed
                                  (index) {
                                    if (index < courseadd.length) {
                                      return LatestCourseAdd(
                                        image:
                                            'assets/latestadd/image${index + 1}.png',
                                        price: courseadd[index].price,
                                        name: courseadd[index].name,
                                      );
                                    } else {
                                      return const SizedBox(); // Return empty SizedBox if index is out of bounds
                                    }
                                  },
                                ),
                        ),
                      ),
                    ),
              const SizedBox(height: 10),
              Specialforyou(text: 'Recommended Course', press: () {}),
              const SizedBox(height: 5),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Row(
                    children: _isLoadingRecommendedCourses // Check if loading
                        ? [
                            const CircularProgressIndicator()
                          ] // Display loading indicator
                        : List.generate(
                            // Use List.generate to create a list of recommended courses or loading indicator
                            min(
                                5,
                                allCourses
                                    .length), // Limit to a maximum of 5 times
                            (index) {
                              return RecommendedCourse(
                                cname: allCourses[index].name,
                                image: 'assets/rc/i${index + 1}.png',
                                price: allCourses[index].price,
                                press: () {},
                              );
                            },
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
