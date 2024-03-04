import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CourseCard extends StatefulWidget {
  final Course course;

  const CourseCard({required this.course});

  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  late bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    final userId = Provider.of<AppDataProvider>(context, listen: false).userId;
    if (userId != null) {
      // Fetch favorite status asynchronously
      fetchFavoriteStatus(userId);
    }
  }

  // Asynchronously fetches favorite status
  Future<void> fetchFavoriteStatus(int userId) async {
    try {
      final isFavoriteValue = await checkFavorite(userId, widget.course.id);
      setState(() {
        isFavorite = isFavoriteValue;
      });
    } catch (e) {
      // Handle error
      print('Error fetching favorite status: $e');
    }
  }

  // Asynchronously checks if the course is a favorite
  Future<bool> checkFavorite(int userId, int courseId) async {
    final url = 'http://192.168.1.13/EduPlatForm/CMS/api/favorite.php';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'operation': 'check',
        'user_id': userId.toString(),
        'course_id': courseId.toString(),
      },
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final isFavoriteValue = responseData['is_favorite'];
      return isFavoriteValue;
    } else {
      throw Exception('Failed to check favorite: ${response.statusCode}');
    }
  }

  // Asynchronously toggles favorite status
  Future<void> toggleFavorite(int userId, int courseId, bool isFavorite) async {
    final url = 'http://192.168.1.13/EduPlatForm/CMS/api/favorite.php';
    final operation = isFavorite ? 'delete' : 'add';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'operation': operation,
        'user_id': userId.toString(),
        'course_id': courseId.toString(),
      },
    );
    if (response.statusCode == 200) {
      setState(() {
        this.isFavorite = !isFavorite;
      });
    } else {
      throw Exception('Failed to toggle favorite: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<AppDataProvider>(context).userId;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {
          // Handle onTap event
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
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.course.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: tdBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RatingBar.builder(
                    direction: Axis.horizontal,
                    itemBuilder: (context, _) =>
                        const Icon(Icons.star, color: Colors.red),
                    onRatingUpdate: (index) {},
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                    minRating: 1,
                    itemCount: 5,
                    itemSize: 18,
                    initialRating: 1,
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
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 30,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          if (userId != null) {
                            toggleFavorite(
                                userId, widget.course.id, isFavorite);
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
}
