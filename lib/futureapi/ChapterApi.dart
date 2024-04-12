import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/AllClass/Chapter.dart';

Future<List<Chapter>> fetchChaptersByCourseID(int courseID) async {
  final response =
  await http.get(Uri.parse('http://192.168.1.4/api/webChapter.php?status=data'));
  if (response.statusCode == 200) {
    List<Chapter> chapters = [];
    Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> jsonData = data['data'];
    for (var chapterJson in jsonData) {
      Chapter chapter = Chapter.fromJson(chapterJson);
      if (chapter.courseID == courseID) {
        chapters.add(chapter);
      }
    }
    return chapters;
  } else {
    throw Exception('Failed to load chapters');
  }
}

