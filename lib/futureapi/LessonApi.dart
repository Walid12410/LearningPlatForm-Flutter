  import 'package:http/http.dart' as http;
  import 'dart:convert';
  import 'package:learningplatformapp/AllClass/Lesson.dart';

  Future<List<Lesson>> fetchLessonsByCourseID(int id) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.12/EduPlatForm/CMS/api/partdetails.php?status=data&courseID=$id'));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      List<dynamic> jsonData = responseData['data'];
      List<Lesson> lessons = [];
      for (var lessonJson in jsonData) {
        Lesson lesson = Lesson.fromJson(lessonJson);
        lessons.add(lesson);
      }
      return lessons;
    } else {
      throw Exception('Failed to load lessons');
    }
  }

