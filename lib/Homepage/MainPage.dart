import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'widget/dialogpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/colors/color.dart';

class MainPage extends StatefulWidget {
  const MainPage({required this.userid, Key? key}) : super(key: key);

  final int userid;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<Trainer>> _futureTrainers;
  List<Trainer> users = []; // Define list to store trainers
  List<Course> courseviews = [];


  @override
  void initState() {
    super.initState();
    _futureTrainers = fetchTrainers(widget.userid);
    getCourseView();
  }

  Future<List<Trainer>> fetchTrainers(int userId) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.13/EduPlatform/CMS/api/TrainersCrudOperation.php?operation=SelectOne&UserID=$userId'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      List<Trainer> trainers =
          jsonData.map((json) => Trainer.fromJson(json)).toList();
      setState(() {
        users = trainers; // Store fetched trainers in users list
      });
      return trainers;
    } else {
      throw Exception('Failed to load trainers');
    }
  }

  Future<void> getCourseView() async {
    try {
      Uri url = Uri.parse('http://192.168.1.13/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=SelectAll');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> CourseJsonList = jsonDecode(response.body);
        List<Course> fetchedCourse = CourseJsonList.map((json) {
          final parsedJson = json as Map<String, dynamic>;
          parsedJson['CoursePrice'] = double.parse(parsedJson['CoursePrice'].toString());
          parsedJson['TrainerShareRate'] = double.parse(parsedJson['TrainerShareRate'].toString());
          parsedJson['CreateDate'] = {'date': parsedJson['CreateDate']['date']};
          return Course.fromJson(parsedJson);
        }).toList();
        fetchedCourse.sort((a, b) => b.view.compareTo(a.view));
        setState(() {
          courseviews = fetchedCourse;
        });
      } else {
        throw Exception('Failed to load Course view');
      }
    } catch (e) {
      print('Error fetching Course view: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
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
                    child: TextField(
                      cursorColor: tdBlue,
                      decoration: const InputDecoration(
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
                        text: 'Welcome Back ${users.isNotEmpty ? users[0].toString() : ""}\n',
                        style: const TextStyle(color: tdBlue, fontSize: 25,fontWeight: FontWeight.bold),
                        children:const [
                           TextSpan(
                              text: 'Start learning now!',
                              style: TextStyle(color: tdBlue, fontSize: 20))
                        ]),
                  ),
                ),
              ),
            ),
          ),
          Specialforyou(text: 'Most Viewed Courses', press: (){}),
          SpecialOffers(category: 'ddd', image: 'assets/user.png', numOfBrands: 3, press: (){})
        ],
      ),
    );
  }
}


class Specialforyou extends StatelessWidget {
  const Specialforyou({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style:const TextStyle(
              fontSize: 18,
              color: tdBlue,
            ),
          ),
          GestureDetector(
            onTap: press,
            child: const Text('see more',
            style: TextStyle(color: tdBlue),),
          )
        ],
      ),
    );
  }
}
class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    super.key, required this.category, required this.image, required this.numOfBrands, required this.press,
  });

  final String category,image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: SizedBox(
        width: 250,
        height: 100,
        child: GestureDetector(
          onTap: press,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(image,
                    fit: BoxFit.cover,
                    width: 700,
                    height: 100),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xff343434).withOpacity(0.4),
                            const Color(0xff343434).withOpacity(0.15),
                          ])
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text.rich(
                    TextSpan(
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(text:'$category\n',
                              style: TextStyle(fontSize: 18)
                          ),
                          TextSpan(
                              text:"Special for you"
                          )
                        ]
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}