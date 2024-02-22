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
                          return DialogPage();
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: users[0].tpicture != null
                          ? Image.network(
                              users[0].tpicture!,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const CircularProgressIndicator();
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/user.png',
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.asset(
                              'assets/user.png',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
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
              _buildCourseSection(
                title: 'Most Viewed Courses',
                courses: courseviews,
                builder: (i) => CourseView(
                  cname: courseviews[i].name,
                  image: 'assets/courseview/image${i + 1}.png',
                  price: courseviews[i].price,
                  view: courseviews[i].view,
                  press: () {},
                ),
              ),
              _buildCourseSection(
                title: 'Latest Course Added',
                courses: courseadd,
                builder: (i) => LatestCourseAdd(
                  image: 'assets/latestadd/image${i + 1}.png',
                  price: courseadd[i].price,
                  name: courseadd[i].name,
                ),
              ),
              _buildCourseSection(
                title: 'Recommended Course',
                courses: allCourses,
                builder: (i) => RecommendedCourse(
                  cname: allCourses[i].name,
                  image: 'assets/rc/i${i + 1}.png',
                  price: allCourses[i].price,
                  press: () {},
                ),
              ),
              _buildCourseSection(
                title: 'For You',
                courses: randomcourse,
                builder: (i) => RandomCourse(
                  cname: randomcourse[i].name,
                  image: 'assets/rac/i${i + 1}.png',
                  price: randomcourse[i].price,
                  press: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseSection({
    required String title,
    required List<Course> courses,
    required Widget Function(int) builder,
  }) {
    return Column(
      children: [
        Specialforyou(text: title, press: () {}),
        SizedBox(height: 5),
        courses.isEmpty
            ? Container() // Display nothing if the array is empty
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Row(
                    children: List.generate(
                      min(3, courses.length),
                      (i) => builder(i),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
