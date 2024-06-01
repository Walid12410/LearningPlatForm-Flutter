import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/CouseDetails/details.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../generated/l10n.dart';

class Latestcourse extends StatefulWidget {
  const Latestcourse({Key? key}) : super(key: key);

  @override
  _LatestcourseState createState() => _LatestcourseState();
}

class _LatestcourseState extends State<Latestcourse> {
  Map<int, double> averageRatings = {};
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      provider.getAllCourse();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider =
        Provider.of<AppDataProvider>(context, listen: false);
    var coursesview = appDataProvider.allCourses;
    if (coursesview != null && coursesview.isNotEmpty) {
      coursesview.sort((a, b) => b.createDate!.compareTo(a.createDate!));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).LatestCAdded,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: tdBlue, fontSize: 12.sp),
        ),
        centerTitle: true,
        backgroundColor: tdbrown,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: tdBlue,
            size: 20.w,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5).w,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ResponsiveGridList(
                minItemWidth: 150.w,
                children: coursesview.map((course) {
                  final courseId = course.id;
                  final provider =
                      Provider.of<AppDataProvider>(context, listen: false);
                  final averageRating =
                      provider.averageRatings[courseId] ?? 0.0;
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
                            borderRadius: BorderRadius.circular(10.0).w,
                            color: tdbrown,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topRight: const Radius.circular(16.0).w,
                                    topLeft: const Radius.circular(16.0).w,
                                  ),
                                  child: Image.asset(
                                    'assets/image1.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0).w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      course.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: tdBlue,
                                        fontSize: 12.sp,
                                        overflow: TextOverflow
                                            .ellipsis, // Specify ellipsis as overflow
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      children: [
                                        Text(
                                          '\$${course.price}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: tdBlue,
                                              fontSize: 10.sp),
                                        ),
                                        const Spacer(),
                                        Icon(
                                          Icons.visibility,
                                          color: tdBlue,
                                          size: 20.w,
                                        ),
                                        SizedBox(width: 2.w),
                                        Text(
                                          '${course.view}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: tdBlue,
                                              fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: tdBlue,
                                          size: 15.w,
                                        ),
                                        Text(
                                          '$averageRating',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: tdBlue,
                                              fontSize: 10.sp),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
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
    );
  }
}
