import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/AllClass/CourseTime.dart';
import 'package:flutter/cupertino.dart';

List<CourseTime> TotalCoureTime =[];

Future<List<CourseTime>> TotalCourseTime(BuildContext context, int CourseID) async {
  try {
    final response = await http.get(Uri.parse(
        'http://192.168.1.3/EduPlatForm/CMS/api/CourseTime.php?operation=Time&CourseID=$CourseID'));
    if (response.statusCode == 200) {
      print(response.body);
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      List<CourseTime> time = jsonData.map((json) => CourseTime.fromJson(json)).toList();
      TotalCoureTime = time;
      return time; // Return the list of trainers
    } else {
      throw Exception('Failed to load trainers');
    }
  } catch (e) {
    print('Error Course Time: $e');
    rethrow; // Rethrow the error for handling in the calling function
  }
}
