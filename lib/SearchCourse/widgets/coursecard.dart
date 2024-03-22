import 'package:flutter/material.dart';
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
  late bool isFavorite = false;
  double averageRating = 0.0; // Add this line

  @override
  void initState() {
    super.initState();
    final userId = Provider.of<AppDataProvider>(context, listen: false).userId;
    if (userId != null) {
      fetchFavoriteStatus(userId);
    }
    fetchAverageRating(); // Call method to fetch average rating
  }

  // Asynchronously fetches favorite status
  Future<void> fetchFavoriteStatus(int userId) async {
    try {
      final isFavoriteValue = await FavoriteService.checkFavorite(userId, widget.course.id);
      setState(() {
        isFavorite = isFavoriteValue;
      });
    } catch (e) {
      // Handle errorhttp://192.168.1.13/EduPlatForm/CMS/api/feedback.php
      print('Error fetching favorite status: $e');
    }
  }

  Future<void> fetchAverageRating() async {
    try {
      final apiUrl = 'http://192.168.1.12/EduPlatForm/CMS/api/feedback.php?operation=getAverageRating&course_id=${widget.course.id}';
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          final averageRatingValue = data['average_rating'];
          if (averageRatingValue != null) {
            setState(() {
              averageRating = double.parse(averageRatingValue.toString());
             // print('Average Rating: $averageRating');
            });
          } else {
           // print('Average rating is null');
          }
        } else {
          // Handle error
          //print('Error: ${data['message']}');
        }
      } else {
        // Handle errors
       // print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Error fetching average rating: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<AppDataProvider>(context).userId;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, CustomPageRoute(child: CourseDetails(
            courseid: widget.course.id,
          )));
        },
        child: SizedBox(
          width: 250,
          child: Card(
            color: Colors.white,
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/image1.png',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.course.name,
                    style: const TextStyle(
                      fontSize: 22,
                      color: tdBlue,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.course.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: tdBlue,
                        overflow: TextOverflow.ellipsis
                    ),
                  ),
                  const SizedBox(height: 4),
                  RatingBar.builder(
                    direction: Axis.horizontal,
                    itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.red),
                    onRatingUpdate: (index) {},
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                    minRating: 1,
                    itemCount: 5,
                    itemSize: 18,
                    initialRating: averageRating, // Use fetched average rating
                    ignoreGestures: true,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.course.price}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: tdBlue,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.bookmark : Icons.bookmark_border,
                          size: 30,
                          color: tdBlue,
                        ),
                        onPressed: () {
                          if (userId != null) {
                            toggleFavorite(userId, widget.course.id, isFavorite);
                          } else {
                            // Handle when user ID is not available
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

  Future<void> toggleFavorite(int userId, int courseId, bool isFavorite) async {
    try {
      final success = await FavoriteService.toggleFavorite(userId, courseId, isFavorite);
      setState(() {
        this.isFavorite = success ? !isFavorite : isFavorite;
      });
    } catch (e) {
      // Handle error
      print('Error toggling favorite: $e');
    }
  }
}
