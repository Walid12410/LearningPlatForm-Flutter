import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/AllClass/course.dart';

Future<List<Course>> getAllCourses() async {
  Uri url = Uri.parse('http://192.168.1.4/api/webCourse.php?status=data');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List<Course> courses = [];
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    if (jsonResponse.containsKey('data')) {
      List<dynamic> data = jsonResponse['data'];
      for (var item in data) {
        courses.add(Course.fromJson(item));
      }
      return courses;
    } else {
      throw Exception('Invalid response format: data key not found');
    }
  } else {
    throw Exception('Failed to load courses');
  }
}

Future<List<Course>> getCourseByID(int courseID) async {
  Uri url = Uri.parse('http://192.168.1.4/api/webCourse.php?status=one&id=$courseID');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List<Course> courses = [];
    dynamic jsonResponse = json.decode(response.body);
    if (jsonResponse is List) {
      for (var item in jsonResponse) {
        courses.add(Course.fromJson(item));
      }
      return courses;
    } else if (jsonResponse is Map<String, dynamic>) {
      courses.add(Course.fromJson(jsonResponse));
      return courses;
    } else {
      throw Exception('Invalid response format');
    }
  } else {
    throw Exception('Failed to load courses');
  }
}

Future<List<Course>> getCourseTrainer(int userId) async {
  Uri url = Uri.parse('http://192.168.1.4/api/webCourse.php?status=data');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    dynamic jsonResponse = json.decode(response.body);
    if (jsonResponse['data'] is List) {
      List<Course> courses = [];
      for (var item in jsonResponse['data']) {
        courses.add(Course.fromJson(item));
      }
        courses = courses.where((course) => course.trainerID == userId).toList();
      return courses;
    } else {
      throw Exception('Invalid response format: expected a list');
    }
  } else {
    throw Exception('Failed to load courses: ${response.statusCode}');
  }
}

Future<List<Course>> getCourse(int portalId) async {
  Uri url = Uri.parse('http://192.168.1.4/api/webCourse.php?status=data');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    dynamic jsonResponse = json.decode(response.body);
    if (jsonResponse['data'] is List) {
      List<Course> courses = [];
      for (var item in jsonResponse['data']) {
        courses.add(Course.fromJson(item));
      }
      courses = courses.where((course) => course.portalID == portalId).toList();
      return courses;
    } else {
      throw Exception('Invalid response format: expected a list');
    }
  } else {
    throw Exception('Failed to load courses: ${response.statusCode}');
  }
}




Future<List<Course>> getCourseView() async {
  final response = await http.get(Uri.parse(
      'http://192.168.1.4/api/walid/courseapi.php?operation=mostview'));
  if (response.statusCode == 200) {
    List<Course> courses = [];
    dynamic jsonResponse = json.decode(response.body);
    if (jsonResponse is List) {
      for (var item in jsonResponse) {
        courses.add(Course.fromJson(item));
      }
      return courses;
    } else {
      throw Exception('Invalid response format: expected a list');
    }
  } else {
    throw Exception('Failed to load courses');
  }
}


Future<List<Course>> getCourseNew() async {
  Uri url = Uri.parse('http://192.168.1.4/api/walid/courseapi.php?operation=latest');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List<Course> courses = [];
    dynamic jsonResponse = json.decode(response.body);
    if (jsonResponse is List) {
      for (var item in jsonResponse) {
        courses.add(Course.fromJson(item));
      }
      return courses;
    } else {
      throw Exception('Invalid response format: expected a list');
    }
  } else {
    throw Exception('Failed to load courses');
  }
}

Future<List<Course>> getRandomCourse() async {
  final Uri url = Uri.parse('http://192.168.1.4/api/walid/courseapi.php?operation=random');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final List<Course> courses = [];
    final dynamic jsonResponse = json.decode(response.body);
    if (jsonResponse is List) {
      for (var item in jsonResponse) {
        courses.add(Course.fromJson(item));
      }
      return courses;
    } else {
      throw Exception('Invalid response format: expected a list');
    }
  } else {
    throw Exception('Failed to load courses');
  }
}


