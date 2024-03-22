import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/futureapi/CourseApi.dart';
import 'package:learningplatformapp/futureapi/PortalApi.dart';
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
    getData(context);
  }

  void getData(context){
    getAllCourses();
    getPortals();
  }

  Future<void> reloadPage() async{
    try{
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      provider.searchdelete();
      getData(context);
    }catch(e){

    }
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
                              .where((course) =>
                          course.portalID == portal.portalID)
                              .toList();
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
                              if (portalCourses.isNotEmpty)
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: portalCourses.map((course) {
                                      return CourseCard(course: course);
                                    }).toList(),
                                  ),
                                )
                              else
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'No courses for this category yet',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: tdBlue
                                    ),
                                  ),
                                ),
                              const Divider(),
                            ],
                          );
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



