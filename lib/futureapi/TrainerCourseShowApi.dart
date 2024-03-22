import 'package:http/http.dart' as http;
import 'package:learningplatformapp/AllClass/TainerCourseShow.dart';
import 'dart:convert';


Future<List<TrainerCourseShow>> getDataTrainerCourse(int courseid) async {
  try {
    Uri url = Uri.parse('http://192.168.1.12/EduPlatForm/CMS/api/TrainerCourse.php?operation=TrainerCourse&CourseID=$courseid');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> trainerJsonList = jsonDecode(response.body);
      List<TrainerCourseShow> fetchedtrainer = trainerJsonList.map((json) => TrainerCourseShow.fromJson(json)).toList();
      return fetchedtrainer; // Return the fetched list of TrainerCourseShow objects
    } else {
      throw Exception('Failed to load trainer');
    }
  } catch (e) {
    print('Error fetching trainer: $e');
    throw e; // Rethrow the exception to propagate it
  }
}
