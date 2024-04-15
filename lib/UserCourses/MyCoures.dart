import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      provider.getParticipation().then((_) {
        checkStudents();
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
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        ),
        backgroundColor: tdbrown,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (userCourses.isNotEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: tdbrown),
                    ),
                    child: ListView.builder(
                      itemCount: userCourses.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(
                              userCourses[index].title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text(
                              userCourses[index].courseDescr,
                              style: const TextStyle(
                                color: Colors.grey,
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
            else if (allCourses.isNotEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: tdbrown),
                    ),
                    child: ListView.builder(
                      itemCount: allCourses.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: ListTile(
                            title: Text(
                              allCourses[index].title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            subtitle: Text(
                              allCourses[index].description,
                              style: const TextStyle(
                                color: Colors.grey,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CustomPageRoute(
                                      child: CourseDetails(
                                          courseid: allCourses[index].id)));
                            },
                          ),
                        );
                      },
                    ),
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
                      style: const TextStyle(
                        fontSize: 20,
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
                        padding: const EdgeInsets.all(20),
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: tdbrown),
                            width: double.infinity,
                            height: 070,
                            child: Center(
                              child: Text(
                                S.of(context).HomePage,
                                style: const TextStyle(
                                    fontSize: 20,
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
