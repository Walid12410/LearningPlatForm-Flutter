import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learningplatformapp/AllClass/ShowFirstVideo.dart';

Future<List<ShowFirstVideo>> fetchVideo(int courseId) async {
  final url = 'http://192.168.1.12/EduPlatForm/CMS/api/part.php';
  try {
    final response = await http.post(
      Uri.parse(url),
      body: {
        'operation': 'VideoShow',
        'CourseID': courseId.toString(), // Convert courseId to String
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body) as List;
      final List<ShowFirstVideo> videoList = data.map((videoJson) => ShowFirstVideo.fromJson(videoJson)).toList();
      return videoList;
    } else {
      throw Exception('Failed to load videos');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
