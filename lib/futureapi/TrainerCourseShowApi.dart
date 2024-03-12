import 'package:http/http.dart' as http;
import 'package:learningplatformapp/AllClass/TainerCourseShow.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';

List<TrainerCourseShow> data= [];

Future<void> getDataTrainerCourse(BuildContext context, int courseid) async {
  try {
    Uri url = Uri.parse('http://192.168.1.13/EduPlatForm/CMS/api/TrainerCourse.php?operation=TrainerCourse&CourseID=$courseid');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> trainerJsonList = jsonDecode(response.body);
      List<TrainerCourseShow> fetchedtrainer = trainerJsonList.map((json) => TrainerCourseShow.fromJson(json)).toList();
      data = fetchedtrainer;
    } else {
      throw Exception('Failed to load trainer');
    }
  } catch (e) {
    print('Error fetching trainer: $e');
  }
}
