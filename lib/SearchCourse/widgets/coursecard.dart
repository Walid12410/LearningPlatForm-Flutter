import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/CouseDetails/details.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:learningplatformapp/futureapi/FavoriteApi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CourseCard extends StatefulWidget {
  final Course course;

  const CourseCard({required this.course});

  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool _isFavorite = false;
  double averageRating = 0.0; // Add this line

  @override
  void initState() {
    super.initState();
    final userId = Provider
        .of<AppDataProvider>(context, listen: false)
        .userId;
    if (userId != null) {
      fetchFavoriteStatus(userId);
    }
    fetchAverageRating();
  }

  Future<void> fetchFavoriteStatus(int userId) async {
    try {
      bool isFavorite = await FavoriteService.checkFavorite(
          userId, widget.course.id);
      setState(() {
        _isFavorite = isFavorite;
      });
    } catch (e) {
      print('Error fetching favorite status: $e');
    }
  }

  Future<void> fetchAverageRating() async {
    try {
      final apiUrl = 'http://192.168.1.5/api/walid/feedback.php?operation=getAverageRating&course_id=${widget
          .course.id}';
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          final averageRatingValue = data['average_rating'];
          if (averageRatingValue != null) {
            setState(() {
              averageRating = double.parse(averageRatingValue.toString());
               //print('Average Rating: $averageRating');
            });
          } else {
            //print('Average rating is null');
          }
        } else {
          //print('Error: ${data['message']}');
        }
      } else {
       // print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
     // print('Error fetching average rating: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider
        .of<AppDataProvider>(context)
        .userId;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0).w,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, CustomPageRoute(child: CourseDetails(
            courseid: widget.course.id,
          )));
        },
        child: SizedBox(
          width: 200.w,
          child: Card(
            color: Colors.white,
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(5.0).w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/image1.png',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                   SizedBox(height: 5.h),
                  Text(
                    widget.course.title,
                    style:  TextStyle(
                        fontSize: 15.sp,
                        color: tdBlue,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis
                    ),
                  ),
                   SizedBox(height: 2.h),
                  Text(
                    widget.course.description,
                    style:  TextStyle(
                        fontSize: 10.h,
                        color: tdBlue,
                        overflow: TextOverflow.ellipsis
                    ),
                  ),
                  SizedBox(height: 10.h),
                  RatingBar.builder(
                    direction: Axis.horizontal,
                    itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.red),
                    onRatingUpdate: (index) {},
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2).w,
                    minRating: 1,
                    itemCount: 5,
                    itemSize: 15.w,
                    initialRating: averageRating,
                    // Use fetched average rating
                    ignoreGestures: true,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.course.price}',
                        style:  TextStyle(
                          fontSize: 10.sp,
                          color: tdBlue,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _isFavorite
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          size: 20.w,
                          color: tdBlue,
                        ),
                        onPressed: () {
                          try {
                            bool newFavoriteStatus = !_isFavorite;
                            FavoriteService.toggleFavorite(
                                userId, widget.course.id, newFavoriteStatus);
                            setState(() {
                              _isFavorite = newFavoriteStatus;
                            });
                          } catch (e) {
                            print('Error toggling favorite status: $e');
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

