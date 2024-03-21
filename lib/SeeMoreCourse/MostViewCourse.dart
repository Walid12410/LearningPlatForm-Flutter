import 'package:flutter/material.dart';
import 'package:learningplatformapp/CouseDetails/details.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/futureapi/CourseApi.dart';
import 'package:learningplatformapp/futureapi/FavoriteApi.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/futureapi/RatingCourses.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:learningplatformapp/AllClass/course.dart';

class MostView extends StatefulWidget {
  const MostView({Key? key}) : super(key: key);

  @override
  _MostViewState createState() => _MostViewState();
}

class _MostViewState extends State<MostView> {
  Map<int, double> averageRatings = {};
  Map<int, bool> isFavorite = {};
  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getData(context);
  }

  void getData(BuildContext context) async {
    try {
      final userId = Provider.of<AppDataProvider>(context, listen: false).userId;
      final courses = await getAllCourses(context);
      if (courses != null) {
        for (final course in courses) {
          final averageRating = await fetchAverageRating(course.id);
          final isFavoriteValue = await FavoriteService.checkFavorite(userId, course.id);
          if (averageRating != null) {
            setState(() {
              averageRatings[course.id] = averageRating;
              isFavorite[course.id] = isFavoriteValue;
            });
          } else {
            print('Average rating is null for course ID: ${course.id}');
          }
        }
      } else {
        print('Courses are null');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  List<Course> _filterCourses(List<Course> courses, String query) {
    if (query.isEmpty) {
      return courses;
    }
    return courses.where((course) => course.name.toLowerCase().contains(query.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context, listen: true);
    var coursesview = appDataProvider.allCourses;
    if (coursesview != null && coursesview.isNotEmpty) {
      coursesview.sort((a, b) => b.view.compareTo(a.view));
    }
    final userId = Provider.of<AppDataProvider>(context).userId;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Most View Courses',
          style: TextStyle(fontWeight: FontWeight.bold, color: tdBlue),
        ),
        centerTitle: true,
        backgroundColor: tdbrown,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: tdBlue),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFEC9D52),
                    Color(0xFF000000),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Container(
                decoration: BoxDecoration(
                  color: tdBGColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: _searchController,
                  cursorColor: tdbrown,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: tdBlue,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 65),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      var filteredCourses = _filterCourses(coursesview ?? [], _searchController.text);
                      return ResponsiveGridList(
                        minItemWidth: 150,
                        children:  filteredCourses.map((course)  {
                          final courseId = course.id;
                          final averageRating = averageRatings[courseId] ?? 0.0;
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context, CustomPageRoute(child: CourseDetails(
                                courseid: course.id,
                              )));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    color: tdbrown,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(16.0),
                                            topLeft: Radius.circular(16.0),
                                          ),
                                          child: Image.asset(
                                            'assets/image1.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              course.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: tdBlue,
                                                overflow: TextOverflow.ellipsis, // Specify ellipsis as overflow
                                              ),
                                            ),
                                            const SizedBox(height: 1),
                                            Row(
                                              children: [
                                                Text(
                                                  '\$${course.price}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: tdBlue,
                                                  ),
                                                ),
                                                const Spacer(),
                                                const Icon(Icons.visibility, color: tdBlue),
                                                const SizedBox(width: 1),
                                                Text(
                                                  '${course.view}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: tdBlue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 1),
                                            Row(
                                              children: [
                                                const Icon(Icons.star, color: tdBlue),
                                                Text(
                                                  '$averageRating',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: tdBlue,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: IconButton(
                                    icon: Icon(
                                      isFavorite[courseId] ?? false ? Icons.bookmark : Icons.bookmark_border, // Check if course is favorite
                                      size: 30,
                                      color: tdBlue,
                                    ),
                                    onPressed: () {
                                      if (userId != null) {
                                        final currentFavoriteStatus = isFavorite[courseId] ?? false;
                                        FavoriteService.toggleFavorite(userId, courseId, currentFavoriteStatus);
                                        setState(() {
                                          isFavorite[courseId] = !currentFavoriteStatus; // Update favorite status
                                        });
                                      } else {
                                        // Handle when user ID is not available
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
