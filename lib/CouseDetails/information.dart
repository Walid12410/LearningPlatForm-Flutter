import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:learningplatformapp/futureapi/RatingCourses.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:intl/intl.dart';
import '../generated/l10n.dart';

class CourseInformation extends StatefulWidget {
  const CourseInformation({required this.courseid});

  final int courseid;

  @override
  State<CourseInformation> createState() => _CourseInformationState();
}

class _CourseInformationState extends State<CourseInformation> {
  double? _averageRating;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      provider.fetchCourseByID(widget.courseid);
      provider.getCourseTine(widget.courseid);
      provider.getPartNumber(widget.courseid);
      provider.getTrainerCourseShow(widget.courseid);
    });
    loadData(context);
  }

  void loadData(context)  {
    try {
      fetchAverageRating(widget.courseid).then((value) {
        if (mounted) {
          setState(() {
            _averageRating = value;
          });
        }
      });

    } catch (error) {
      print('Error: $error');
    }
  }

  bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AppDataProvider>(
          builder: (context, provider, child) {
            var TotalCoureTime = provider.courseTime;
            var data = provider.data;
            var partNumbers = provider.partNumber;
            var courses = provider.CourseByID;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10).w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 120.h,
                      width: double.infinity,
                      child: Image.asset('assets/image1.png',fit: BoxFit.contain,),
                    ),
                     SizedBox(height: 10.h),
                    Padding(
                      padding: const EdgeInsets.all(2).w,
                      child: Row(
                        children: [
                          if (data.isNotEmpty)
                            Container(
                              width: 40.w,
                              height: 35.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                Border.all(color: Colors.black, width: 2.w),
                              ),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: data[0].profilePicture,
                                  placeholder: (context, url) =>
                                  Image.asset('assets/gif-unscreen.gif',fit: BoxFit.cover,),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                           SizedBox(
                            width: 5.w,
                          ),
                          if (data.isNotEmpty)
                            Text(
                              data[0].toString(),
                              style:  TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                          const Spacer(),
                          RatingBar.builder(
                            direction: Axis.horizontal,
                            itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.red),
                            onRatingUpdate: (index) {},
                            itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2).w,
                            minRating: 1,
                            itemCount: 5,
                            itemSize: 15.w,
                            initialRating: _averageRating ?? 1,
                            ignoreGestures: true,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: isArabic() ?
                      const EdgeInsets.only(right: 45, top: 5,bottom: 5).w :
                      const EdgeInsets.only(left: 45, top: 5,bottom: 5).w,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                               Icon(Icons.access_time_outlined,size: 20.w,),
                               SizedBox(width: 2.w),
                              if (TotalCoureTime.isNotEmpty && mounted)
                                Text(
                                  '${TotalCoureTime[0].getTotalHours()} ${S.of(context).HourCourse} (${partNumbers.length} ${S.of(context).Lessons})',
                                style: TextStyle(fontSize: 10.sp),)
                            ],
                          ),
                           Row(
                            children: [
                               Icon(Icons.school,size: 20.w,),
                              SizedBox(width: 2.w),
                              Text(S.of(context).Certification,style: TextStyle(fontSize: 10.sp),),
                            ],
                          ),
                           Row(
                            children: [
                               Icon(Icons.language,size: 20.w,),
                              SizedBox(width: 2.w),
                              Text(S.of(context).CourseLanguage,style: TextStyle(fontSize: 10.sp),),
                            ],
                          ),
                        ],
                      ),
                    ),
                     Padding(
                      padding:const EdgeInsets.all(5).w,
                      child: Text(
                        S.of(context).AboutCourse,
                        style:  TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (courses.isNotEmpty)
                      Padding(
                        padding:isArabic() ?
                        const EdgeInsets.only(right: 5).w :
                        const EdgeInsets.only(left: 5).w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                '${courses[0].title}.${courses[0].description}',style: TextStyle(fontSize: 10.sp),),
                          ],
                        ),
                      )
                    else
                       Center(
                        child: Text(
                          S.of(context).NoDetailYet,
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}