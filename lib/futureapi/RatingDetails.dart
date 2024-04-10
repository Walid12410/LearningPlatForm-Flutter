import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/AllClass/RatingDetails.dart';

Future<List<CourseReview>> fetchCourseReview(int id) async {
  Uri url = Uri.parse('http://192.168.1.2/api/walid/feedback.php?operation=data&course_id=$id');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List<CourseReview> courseReview = [];
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('data')) {
      List<dynamic> data = jsonResponse['data'];
      for (var item in data) {
        courseReview.add(CourseReview.fromJson(item));
      }
      return courseReview;
    } else {
      return [];
      throw Exception('Invalid response format: data key not found');
    }
  } else {
    throw Exception('Failed to load course review');
  }
}