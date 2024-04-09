import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:learningplatformapp/AllClass/portal.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'widgets/searchtextfield.dart';
import 'widgets/coursecard.dart';

class SearchCourse extends StatefulWidget {
  const SearchCourse({super.key});

  @override
  State<SearchCourse> createState() => _SearchCourseState();
}

class _SearchCourseState extends State<SearchCourse> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      reloadPage();
    });
  }

  Future<void> reloadPage() async{
    final provider = Provider.of<AppDataProvider>(context, listen: false);
    await provider.getAllCourse();
    await provider.getportal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: reloadPage,
          child: Column(
            children: [
              const SearchTextField(), // Add the SearchCourse widget here
              Expanded(
                child: Consumer<AppDataProvider>(
                  builder: (context, appDataProvider, _) {
                    List<Portal> portals = appDataProvider.portals;
                    List<Course> allCourses = appDataProvider.allCourses;
                    if (portals.isEmpty || allCourses.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(color: tdbrown),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: portals.length,
                        itemBuilder: (context, index) {
                          Portal portal = portals[index];
                          List<Course> portalCourses = allCourses
                              .where((course) => course.portalID == portal.portalID)
                              .toList();
                          if (portalCourses.isNotEmpty) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    portal.portalName,
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: tdBlue,
                                    ),
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: portalCourses.map((course) {
                                      return CourseCard(course: course);
                                    }).toList(),
                                  ),
                                ),
                                const Divider(),
                              ],
                            );
                          } else {
                            // Return an empty container if the portal has no courses
                            return Container();
                          }
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



