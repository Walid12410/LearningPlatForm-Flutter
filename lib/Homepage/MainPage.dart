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
import 'widget/RandomCourse.dart';

class MainPage extends StatefulWidget {
  const MainPage({required this.userid, Key? key}) : super(key: key);

  final int userid;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<Trainer>> _futureTrainers;

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
    getRandomCourse();
  }

  void _fetchTrainers() async {
    try {
      await fetchTrainers(widget.userid);
    } catch (e) {
      print('Error fetching trainers: $e');
      // Handle the error here, you can show a snackbar or toast message to inform the user
      // For example:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching trainers: $e'),
          duration: Duration(seconds: 3),
        ),
      );
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
              courseviews.isEmpty
                  ? Container() // Display nothing if the array is empty
                  : Column(
                children: [
                  Specialforyou(
                      text: 'Most Viewed Courses', press: () {}),
                  SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: courseviews.isEmpty
                            ? []
                            : List.generate(
                          min(3, courseviews.length),
                              (i) {
                            if (courseviews.isNotEmpty) {
                              return CourseView(
                                cname: courseviews[i].name,
                                image: 'assets/courseview/image${i + 1}.png',
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
                            if(courseadd.isNotEmpty) {
                              return LatestCourseAdd(
                                image:
                                'assets/latestadd/image${i + 1}.png',
                                price: courseadd[i].price,
                                name: courseadd[i].name,
                              );
                            }else{
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
              Specialforyou(text: 'Recommended Course', press: () {}),
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
                        if(allCourses.isNotEmpty) {
                          return RecommendedCourse(
                            cname: allCourses[i].name,
                            image: 'assets/rc/i${i + 1}.png',
                            price: allCourses[i].price,
                            press: () {},
                          );
                        }else{
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ),
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
                        if(randomcourse.isNotEmpty) {
                          return RandomCourse(
                            cname: randomcourse[i].name,
                            image: 'assets/rac/i${i + 1}.png',
                            price: randomcourse[i].price,
                            press: () {},
                          );
                        }else{
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}