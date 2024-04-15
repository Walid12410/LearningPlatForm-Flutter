import 'package:http/http.dart' as http;
import 'dart:convert';

import '../AllClass/CourseUser.dart';


Future<List<UserCourse>> fetchUserCourse(int id) async {
  final response = await http.get(Uri.parse(
      'http://192.168.1.4/api/walid/UserCourse.php?status=CourseUser&ParID=$id'));
  if (response.statusCode == 200) {
    List<dynamic> responseData = json.decode(response.body);
    List<UserCourse> uC = [];
    for (var uCourseJson in responseData) {
      UserCourse usersCourse = UserCourse.fromJson(uCourseJson);
      uC.add(usersCourse);
    }
    return uC;
  } else {
    throw Exception('Failed to load user course');
  }
}
