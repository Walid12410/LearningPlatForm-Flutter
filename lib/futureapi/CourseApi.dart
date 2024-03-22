import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';

Future<List<Course>?> getAllCourses() async {
  try {
    Uri url = Uri.parse(
        'http://192.168.1.12/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=SelectAll');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> courseJsonList = jsonDecode(response.body);
      List<Course> fetchedCourses = courseJsonList.map((json) {
        final parsedJson = json as Map<String, dynamic>;
        parsedJson['CoursePrice'] =
            double.parse(parsedJson['CoursePrice'].toString());
        parsedJson['TrainerShareRate'] =
            double.parse(parsedJson['TrainerShareRate'].toString());
        parsedJson['CreateDate'] = {'date': parsedJson['CreateDate']['date']};
        return Course.fromJson(parsedJson);
      }).toList();
      return fetchedCourses;
    } else {
      throw Exception('Failed to load Course view');
    }
  } catch (e) {
    print('Error fetching Course view: $e');
  }
}

Future<List<Course>?> getCourseByID(int CourseID) async {
  try {
    Uri url = Uri.parse(
        'http://192.168.1.12/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=SelectOne&CourseID=$CourseID');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> courseJsonList = jsonDecode(response.body);
      List<Course> fetchedCourses = courseJsonList.map((json) {
        final parsedJson = json as Map<String, dynamic>;
        parsedJson['CoursePrice'] = double.parse(parsedJson['CoursePrice']);
        parsedJson['TrainerShareRate'] =
            double.parse(parsedJson['TrainerShareRate']);
        parsedJson['CreateDate'] = {'date': parsedJson['CreateDate']['date']};
        return Course.fromJson(parsedJson);
      }).toList();
      return fetchedCourses;
    } else {
      throw Exception('No courses found for Course with ID: $CourseID');
    }
  } catch (e) {
    print('Error fetching courses: $e');
    return null; // Return null in case of error
  }
}

Future<void> getCourseTrainer(int userId, context) async {
  try {
    AppDataProvider appDataProvider =
        Provider.of<AppDataProvider>(context, listen: true);
    Uri url = Uri.parse(
        'http://192.168.1.12/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=SelectAll');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> courseJsonList = jsonDecode(response.body);
      List<Course> fetchedCourses = courseJsonList.map((json) {
        final parsedJson = json as Map<String, dynamic>;
        parsedJson['CoursePrice'] = double.parse(parsedJson['CoursePrice']);
        parsedJson['TrainerShareRate'] =
            double.parse(parsedJson['TrainerShareRate']);
        parsedJson['CreateDate'] = {'date': parsedJson['CreateDate']['date']};
        return Course.fromJson(parsedJson);
      }).toList();
      List<Course> filteredCourses =
          fetchedCourses.where((course) => course.trainerID == userId).toList();
      if (filteredCourses.isNotEmpty) {
        appDataProvider.setFilterCourseTrainer(filteredCourses);
        appDataProvider.setCourseTrainer(filteredCourses);
      } else {
        throw Exception('No courses found for trainer with ID: ${userId}');
      }
    } else {
      throw Exception(
          'Failed to load courses. Status Code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching courses: $e');
    AppDataProvider appDataProvider =
        Provider.of<AppDataProvider>(context, listen: false);
    appDataProvider.coursestrainer =
        []; // Set courses to empty list in case of error
    appDataProvider.filterCoursestrainer =
        []; // Set filtered courses to empty list in case of error
  }
}

Future<void> getCourse(int portalId, context) async {
  try {
    AppDataProvider appDataProvider =
        Provider.of<AppDataProvider>(context, listen: true);
    Uri url = Uri.parse(
        'http://192.168.1.12/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=SelectAll');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> courseJsonList = jsonDecode(response.body);
      List<Course> fetchedCourses = [];
      for (var json in courseJsonList) {
        try {
          final parsedJson = json as Map<String, dynamic>;
          parsedJson['CoursePrice'] = double.parse(parsedJson['CoursePrice']);
          parsedJson['TrainerShareRate'] =
              double.parse(parsedJson['TrainerShareRate']);
          parsedJson['CreateDate'] = {'date': parsedJson['CreateDate']['date']};
          fetchedCourses.add(Course.fromJson(parsedJson));
        } catch (e) {
          print('Error parsing course: $e');
        }
      }
      List<Course> filteredCourses = fetchedCourses
          .where((course) => course.portalID == portalId)
          .toList();
      if (filteredCourses.isNotEmpty) {
        appDataProvider.setCourses(filteredCourses);
        appDataProvider.setFilterCourse(filteredCourses);
      } else {
        appDataProvider.setCourses([]);
        appDataProvider.setFilterCourse([]);
      }
    } else {
      throw Exception('Failed to load courses');
    }
  } catch (e) {
    print('Error fetching courses: $e');
    AppDataProvider appDataProvider =
        Provider.of<AppDataProvider>(context, listen: false);
    appDataProvider.setCourses([]);
    appDataProvider.setFilterCourse([]);
  }
}

Future<List<Course>?> getCourseView() async {
  try {
    final Uri url = Uri.parse('http://192.168.1.12/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=mostview');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> courseJsonList = jsonDecode(response.body);
      List<Course> fetchedCourses = courseJsonList.map((json) {
        final parsedJson = json as Map<String, dynamic>;
        parsedJson['CoursePrice'] =
            double.parse(parsedJson['CoursePrice'].toString());
        parsedJson['TrainerShareRate'] =
            double.parse(parsedJson['TrainerShareRate'].toString());
        parsedJson['CreateDate'] = {'date': parsedJson['CreateDate']['date']};
        return Course.fromJson(parsedJson);
      }).toList();
      return fetchedCourses;
    } else {
      throw Exception('Failed to load Course view');
    }
  } catch (e) {
    print('Error fetching Course view: $e');
  }
}



Future<List<Course>?> getCourseNew() async {
  try {
    Uri url = Uri.parse(
        'http://192.168.1.12/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=latest');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> CourseJsonList = jsonDecode(response.body);
      List<Course> fetchedCourse = CourseJsonList.map((json) {
        final parsedJson = json as Map<String, dynamic>;
        parsedJson['CoursePrice'] =
            double.parse(parsedJson['CoursePrice'].toString());
        parsedJson['TrainerShareRate'] =
            double.parse(parsedJson['TrainerShareRate'].toString());
        parsedJson['CreateDate'] = {'date': parsedJson['CreateDate']['date']};
        return Course.fromJson(parsedJson);
      }).toList();
      return fetchedCourse;
    } else {
      throw Exception('Failed to load Course view');
    }
  } catch (e) {
    print('Error fetching Course view: $e');
  }
}


Future<List<Course>?> getRandomCourse() async {
  try {
    Uri url = Uri.parse(
        'http://192.168.1.12/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=random');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> CourseJsonList = jsonDecode(response.body);
      List<Course> fetchedCourse = CourseJsonList.map((json) {
        final parsedJson = json as Map<String, dynamic>;
        parsedJson['CoursePrice'] =
            double.parse(parsedJson['CoursePrice'].toString());
        parsedJson['TrainerShareRate'] =
            double.parse(parsedJson['TrainerShareRate'].toString());
        parsedJson['CreateDate'] = {'date': parsedJson['CreateDate']['date']};
        return Course.fromJson(parsedJson);
      }).toList();
      return fetchedCourse;
    } else {
      throw Exception('Failed to load Course random');
    }
  } catch (e) {
    print('Error fetching Course random: $e');
  }
}
