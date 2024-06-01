import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/CouseDetails/details.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../generated/l10n.dart';

class ForYouCourse extends StatefulWidget {
  const ForYouCourse({Key? key}) : super(key: key);

  @override
  _ForYouCourseState createState() => _ForYouCourseState();
}

class _ForYouCourseState extends State<ForYouCourse> {
  Map<int, double> averageRatings = {};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getData();
    });
    super.initState();
  }

  Future<void> getData() async {
    final provider = Provider.of<AppDataProvider>(context, listen: false);
    await provider.getAllCourse();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider =
        Provider.of<AppDataProvider>(context, listen: false);
    var allCourses = appDataProvider.allCourses;
    var coursesToShow = allCourses.take(4).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).RecommendCFY,
          style:  TextStyle(fontWeight: FontWeight.bold, color: tdBlue,fontSize: 12.sp),
        ),
        centerTitle: true,
        backgroundColor: tdbrown,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:  Icon(Icons.arrow_back, color: tdBlue,size: 20.w,),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(5).w,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ResponsiveGridList(
                minItemWidth: 150.w,
                children: coursesToShow.map((course) {
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
                          ),
                        ),
                      );
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
                                  borderRadius:  BorderRadius.only(
                                    topRight: const Radius.circular(16.0).w,
                                    topLeft:const Radius.circular(16.0).w,
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
                                      style:  TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.sp,
                                        color: tdBlue,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const SizedBox(height: 1),
                                    Row(
                                      children: [
                                        Text(
                                          '\$${course.price}',
                                          style:  TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: tdBlue,
                                            fontSize: 10.sp
                                          ),
                                        ),
                                        const Spacer(),
                                         Icon(Icons.visibility,
                                            color: tdBlue,size: 20.w,),
                                         SizedBox(width: 2.w),
                                        Text(
                                          '${course.view}',
                                          style:  TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: tdBlue,
                                            fontSize: 10.sp
                                          ),
                                        ),
                                      ],
                                    ),
                                     SizedBox(height: 5.h),
                                    Row(
                                      children: [
                                         Icon(Icons.star, color: tdBlue,size: 20.w,),
                                        Text(
                                          '$averageRating',
                                          style:  TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: tdBlue,
                                            fontSize: 10.sp
                                          ),
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
