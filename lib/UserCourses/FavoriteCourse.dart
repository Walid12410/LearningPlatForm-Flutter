import 'package:flutter/material.dart';
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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      int userID = provider.userId;
      provider.getUserFavoriteCourse(userID);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: true);
    var userCourses = provider.userFavoriteCourse;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).YourFavoriteCourse,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: tdbrown,
      ),
      body: userCourses.isEmpty
          ? Center(
              child: Text(
                S.of(context).NoFavCourse,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            )
          : SafeArea(
              child: Column(
              children: [
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
                                userCourses[index].courseDescription,
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
              ],
            )),
    );
  }
}
