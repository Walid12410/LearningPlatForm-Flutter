import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';


Future<List<Course>> getAllCourses(context) async {
  try {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    Uri url = Uri.parse('http://192.168.1.5/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=SelectAll');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> allCourseJsonList = jsonDecode(response.body);
      List<Course> fetchedCourses = allCourseJsonList.map((json) {
        final parsedJson = json as Map<String, dynamic>;
        parsedJson['CoursePrice'] = double.parse(parsedJson['CoursePrice']);
        parsedJson['TrainerShareRate'] = double.parse(parsedJson['TrainerShareRate']);
        parsedJson['CreateDate'] = {'date': parsedJson['CreateDate']['date']};
        return Course.fromJson(parsedJson);
      }).toList();
      if (appDataProvider.allCourses.isEmpty) {
        appDataProvider.setAllCourses(fetchedCourses);
      }
      return fetchedCourses; // Return the fetched courses
    } else {
      throw Exception('Failed to load courses');
    }
  } catch (e) {
    print('Error fetching courses: $e');
    throw e; // Re-throw the error to propagate it
  }
}

 List<Course> courses= [];

Future<List<Course>?> getCourseByID(int CourseID, context) async {
  try {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    Uri url = Uri.parse('http://192.168.1.5/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=SelectOne&CourseID=$CourseID');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> courseJsonList = jsonDecode(response.body);
      List<Course> fetchedCourses = courseJsonList.map((json) {
        final parsedJson = json as Map<String, dynamic>;
        // Assuming Course is your model class
        parsedJson['CoursePrice'] = double.parse(parsedJson['CoursePrice']);
        parsedJson['TrainerShareRate'] = double.parse(parsedJson['TrainerShareRate']);
        parsedJson['CreateDate'] = {'date': parsedJson['CreateDate']['date']};
        return Course.fromJson(parsedJson);
      }).toList();
      if (appDataProvider.CourseByID.isEmpty) {
        appDataProvider.setCourseByID(fetchedCourses);
      }
      courses = fetchedCourses;
      return fetchedCourses; // Return the fetched courses
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
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context,listen: false);
    Uri url = Uri.parse(
        'http://192.168.1.5/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=SelectAll');
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
    appDataProvider.coursestrainer = []; // Set courses to empty list in case of error
    appDataProvider.filterCoursestrainer = []; // Set filtered courses to empty list in case of error
  }
}

Future<void> getCourse(int portalId, context) async {
  try {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    Uri url = Uri.parse(
        'http://192.168.1.5/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=SelectAll');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> courseJsonList = jsonDecode(response.body);
      List<Course> fetchedCourses = [];
      for (var json in courseJsonList) {
        try {
          final parsedJson = json as Map<String, dynamic>;
          parsedJson['CoursePrice'] = double.parse(parsedJson['CoursePrice']);
          parsedJson['TrainerShareRate'] = double.parse(parsedJson['TrainerShareRate']);
          parsedJson['CreateDate'] = {'date': parsedJson['CreateDate']['date']};
          fetchedCourses.add(Course.fromJson(parsedJson));
        } catch (e) {
          print('Error parsing course: $e');
        }
      }
      List<Course> filteredCourses = fetchedCourses.where((course) => course.portalID == portalId).toList();
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


Future<void> getCourseView(context) async {
  try {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context,listen: false);
    Uri url = Uri.parse(
        'http://192.168.1.5/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=mostview');
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
      if (appDataProvider.courseviews.isEmpty) {
        appDataProvider.setCourseView(fetchedCourses);
      }
    } else {
      throw Exception('Failed to load Course view');
    }
  } catch (e) {
    print('Error fetching Course view: $e');
    AppDataProvider appDataProvider =
        Provider.of<AppDataProvider>(context, listen: false);
    if (appDataProvider.courseviews.isEmpty) {
      appDataProvider.setCourseView([]);
    }
  }
}

Future<void> getCourseNew(context) async {
  try {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context,listen: false);
    Uri url = Uri.parse(
        'http://192.168.1.5/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=latest');
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
      if (appDataProvider.courseadd.isEmpty) {
        appDataProvider.setCourseadd(fetchedCourse);
      }
    } else {
      throw Exception('Failed to load Course view');
    }
  } catch (e) {
    print('Error fetching Course view: $e');
  }
}

Future<void> getRandomCourse(context) async {
  try {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context,listen: false);
    Uri url = Uri.parse(
        'http://192.168.1.5/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=random');
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
      if (appDataProvider.randomcourse.isEmpty) {
        appDataProvider.setRandonCourse(fetchedCourse);
      }
    } else {
      throw Exception('Failed to load Course random');
    }
  } catch (e) {
    print('Error fetching Course random: $e');
  }
}
