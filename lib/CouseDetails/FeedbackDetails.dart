import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../generated/l10n.dart';
import '../provider/provider_data.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackCourse extends StatefulWidget {
  const FeedbackCourse({Key? key, required this.courseId});

  final int courseId;

  @override
  State<FeedbackCourse> createState() => _FeedbackCourseState();
}

class _FeedbackCourseState extends State<FeedbackCourse> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppDataProvider provider =
          Provider.of<AppDataProvider>(context, listen: false);
      provider.getReviewCourseDetails(widget.courseId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: true);
    var reviewDetails = provider.courseReview;

    return Scaffold(
      body: SafeArea(
        child: reviewDetails.isEmpty
            ? Center(
                child: Text(
                  S.of(context).NoFeedBackOfThisCourse,
                  style:  TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3).w,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon:  Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 20.w,
                          ),
                        ),
                        Text(
                          S.of(context).RatingAndReview,
                          style:  TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10).w,
                    child: Text(
                      S.of(context).RatingDesc,
                      style:  TextStyle(fontSize: 10.sp, color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: reviewDetails.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0).w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40.w,
                                    height: 35.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2.w,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: reviewDetails != null
                                          ? CachedNetworkImage(
                                              imageUrl:
                                                  reviewDetails[index].photo,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                'assets/user.png',
                                                fit: BoxFit.cover,
                                              ),
                                              fit: BoxFit.cover,
                                            )
                                          : Container(), // Use Container if user is null
                                    ),
                                  ),
                                   SizedBox(width: 5.w),
                                  Text(
                                    reviewDetails[index]
                                        .toString(),
                                    style:  TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  const Spacer(),
                                  RatingBar.builder(
                                    direction: Axis.horizontal,
                                    itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.red),
                                    onRatingUpdate: (index) {},
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 2).w,
                                    minRating: 1,
                                    itemCount: 5,
                                    itemSize: 15.w,
                                    initialRating:
                                        reviewDetails[index].rating.toDouble(),
                                    ignoreGestures: true,
                                  ),
                                ],
                              ),
                               SizedBox(height: 5.h),
                              Padding(
                                padding: const EdgeInsets.all(2.0).w,
                                child: ReadMoreText(
                                  reviewDetails[index].comment,
                                  trimLines: 3,
                                  style: TextStyle(fontSize: 10.sp),
                                  trimMode: TrimMode.Line,
                                  trimExpandedText: S.of(context).ShowLess,
                                  trimCollapsedText: S.of(context).ShowMore,
                                  moreStyle:  TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                  lessStyle:  TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                              const Divider(color: Colors.black)
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
