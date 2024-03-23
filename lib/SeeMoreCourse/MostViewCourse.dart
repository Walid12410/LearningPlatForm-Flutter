import 'package:flutter/material.dart';
import 'package:learningplatformapp/CouseDetails/details.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class MostView extends StatefulWidget {
  const MostView({Key? key}) : super(key: key);

  @override
  _MostViewState createState() => _MostViewState();
}

class _MostViewState extends State<MostView> {
  Map<int, double> averageRatings = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      provider.getAllCourse();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider =
        Provider.of<AppDataProvider>(context, listen: true);
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
              padding: const EdgeInsets.only(top: 2),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2),
                    topRight: Radius.circular(2),
                  ),
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return ResponsiveGridList(
                        minItemWidth: 150,
                        children: coursesview.map((course) {
                          final courseId = course.id;
                          final provider = Provider.of<AppDataProvider>(context, listen: false);
                          final averageRating = provider.averageRatings[courseId] ?? 0.0;
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CustomPageRoute(
                                      child: CourseDetails(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              course.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: tdBlue,
                                                overflow: TextOverflow
                                                    .ellipsis, // Specify ellipsis as overflow
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
                                                const Icon(Icons.visibility,
                                                    color: tdBlue),
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
                                                const Icon(Icons.star,
                                                    color: tdBlue),
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
