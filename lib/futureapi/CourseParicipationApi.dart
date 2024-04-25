import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/AllClass/CourseParticipated.dart';

Future<List<CourseParticipated>> fetchAllCourseParticipation() async {
  final response = await http.get(Uri.parse(
      'http://192.168.1.5/api/webCourseParticipated.php?status=data'));
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> jsonData = data['data'];
    List<CourseParticipated> cParticipation = [];
    for (var cParticipationJson in jsonData) {
      CourseParticipated cPar = CourseParticipated.fromJson(cParticipationJson);
      cParticipation.add(cPar);
    }
    return cParticipation;
  } else {
    throw Exception('Failed to load Course participation');
  }
}
