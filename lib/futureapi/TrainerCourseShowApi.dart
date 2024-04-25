import 'package:http/http.dart' as http;
import 'package:learningplatformapp/AllClass/TainerCourseShow.dart';
import 'dart:convert';

Future<List<TrainerCourseShow>> getDataTrainerCourse(int courseId) async {
  try {
    Uri url = Uri.parse('http://192.168.1.5/api/walid/userapi.php?status=TrainerCourseShow&UserID=$courseId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> trainerJsonList = jsonDecode(response.body);
      List<TrainerCourseShow> fetchedTrainers = trainerJsonList.map((json) => TrainerCourseShow.fromJson(json)).toList();
      return fetchedTrainers;
    } else {
      throw Exception('Failed to load trainers');
    }
  } catch (e) {
    print('Error fetching data: $e');
    return [];
  }
}