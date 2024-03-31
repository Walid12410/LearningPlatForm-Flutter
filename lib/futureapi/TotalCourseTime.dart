import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/AllClass/CourseTime.dart';


Future<List<CourseTime>> TotalCourseTime(int CourseID) async {
  try {
    final response = await http.get(Uri.parse(
        'http://192.168.1.12/api/walid/CourseTime.php?operation=Time&CourseID=$CourseID'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      List<CourseTime> time = jsonData.map((json) => CourseTime.fromJson(json)).toList();
      return time; // Return the list of trainers
    } else {
      throw Exception('Failed to load time');
    }
  } catch (e) {
    print('Error Course Time: $e');
    rethrow; // Rethrow the error for handling in the calling function
  }
}
