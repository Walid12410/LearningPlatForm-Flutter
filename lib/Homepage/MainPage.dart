import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/Homepage/widget/RecommendedCourse.dart';
import 'widget/dialogpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/colors/color.dart';
import 'widget/specialforyou.dart';
import 'widget/courseviwe.dart';
import 'widget/LatestCourseAdded.dart';

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

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  void _fetchData() {
    _fetchTrainers();
    getCourseView();
    getCourseNew();
    getAllCourses();
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
                  ? CircularProgressIndicator()
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
                          children: [
                            if (courseviews.isNotEmpty)
                              CourseView(
                                cname: courseviews[0].name,
                                image: 'assets/courseview/image1.png',
                                price: courseviews[0].price,
                                view: courseviews[0].view,
                                press: () {},
                              ),
                            if (courseviews.length > 1)
                              CourseView(
                                cname: courseviews[1].name,
                                image: 'assets/courseview/image2.png',
                                price: courseviews[1].price,
                                view: courseviews[1].view,
                                press: () {},
                              ),
                            if (courseviews.length > 2)
                              CourseView(
                                cname: courseviews[2].name,
                                image: 'assets/courseview/image3.png',
                                price: courseviews[2].price,
                                view: courseviews[2].view,
                                press: () {},
                              ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                    ),
              const SizedBox(height: 5),
              _isLoadingLatestCourses
                  ? CircularProgressIndicator()
                  : Specialforyou(text: 'Latest Course Added', press: () {}),
              const SizedBox(height: 5),
              _isLoadingLatestCourses
                  ? Container() // Display nothing if loading
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: Row(
                          children: [
                            if (courseadd.isNotEmpty)
                              LatestCourseAdd(
                                image: 'assets/latestadd/image32.png',
                                price: courseadd[0].price,
                                name: courseadd[0].name,
                              ),
                            if (courseadd.length > 1)
                              LatestCourseAdd(
                                image: 'assets/latestadd/image12.png',
                                price: courseadd[1].price,
                                name: courseadd[1].name,
                              ),
                            if (courseadd.length > 2)
                              LatestCourseAdd(
                                image: 'assets/latestadd/image22.png',
                                price: courseadd[2].price,
                                name: courseadd[2].name,
                              ),
                            if (courseadd.length > 3)
                              LatestCourseAdd(
                                image: 'assets/latestadd/image42.png',
                                price: courseadd[3].price,
                                name: courseadd[3].name,
                              ),
                          ],
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
                      children: [
                        RecommendedCourse(
                            cname: allCourses[0].name,
                            image: 'assets/rc/i1.png',
                            price: allCourses[0].price,
                            press: () {}),
                        RecommendedCourse(
                            cname: allCourses[1].name,
                            image: 'assets/rc/i2.png',
                            price: allCourses[1].price,
                            press: () {}),
                        RecommendedCourse(
                            cname: allCourses[2].name,
                            image: 'assets/rc/i3.png',
                            price: allCourses[2].price,
                            press: () {}),
                        RecommendedCourse(
                            cname: allCourses[3].name,
                            image: 'assets/rc/i4.png',
                            price: allCourses[3].price,
                            press: () {}),
                        RecommendedCourse(
                            cname: allCourses[4].name,
                            image: 'assets/rc/i5.png',
                            price: allCourses[4].price,
                            press: () {}),
                      ],
                    ),
                  )),
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
