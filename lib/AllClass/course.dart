
import 'package:http/http.dart' as http;
import 'dart:convert';

class Course {
  int id;
  String name;
  String description;
  double price;
  double trainerShareRate;
  DateTime createDate;
  int isActive;
  int portalID;
  int trainerID;
  int view;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.trainerShareRate,
    required this.createDate,
    required this.isActive,
    required this.portalID,
    required this.trainerID,
    required this.view
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['CourseID'],
      name: json['CourseName'],
      description: json['CourseDescription'],
      price: json['CoursePrice'],
      trainerShareRate: json['TrainerShareRate'],
      createDate: DateTime.parse(json['CreateDate']['date']), // parse the 'date' part of the CreateDate
      isActive: json['IsActice'],
      portalID: json['PortalID'],
      trainerID: json['TrainerID'],
      view: json['views']
    );
  }
}

List<Course> courses = [];
List<Course> filteredCourse = [];
List<Course> courseviews = [];
List<Course> courseadd =[];
List<Course> coursestrainer = [];
List<Course> filterCoursestrainer = [];
List<Course> allCourses =[];


Future<void> getAllCourses() async {
  try {
    Uri url = Uri.parse('http://192.168.1.13/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=SelectAll');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> AllcourseJsonList = jsonDecode(response.body);
      List<Course> fetchedcourse = AllcourseJsonList.map((json) {
        final parsedJson = json as Map<String, dynamic>;
        parsedJson['CoursePrice'] = double.parse(parsedJson['CoursePrice']);
        parsedJson['TrainerShareRate'] = double.parse(parsedJson['TrainerShareRate']);
        parsedJson['CreateDate'] = {'date': parsedJson['CreateDate']['date']};
        return Course.fromJson(parsedJson);
      }).toList();
      allCourses = fetchedcourse;
    } else {
      throw Exception('Failed to load courses');
    }
  } catch (e) {
    print('Error fetching courses: $e');
    allCourses = [];
  }
}

Future<void> getCourseTrainer(int userid) async {
  try {
    Uri url = Uri.parse('http://192.168.1.13/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=SelectAll');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> courseJsonList = jsonDecode(response.body);
      List<Course> fetchedCourses = courseJsonList.map((json) {
        final parsedJson = json as Map<String, dynamic>;
        parsedJson['CoursePrice'] = double.parse(parsedJson['CoursePrice']);
        parsedJson['TrainerShareRate'] = double.parse(parsedJson['TrainerShareRate']);
        parsedJson['CreateDate'] = {'date': parsedJson['CreateDate']['date']};
        return Course.fromJson(parsedJson);
      }).toList();
      List<Course> filteredCourses = fetchedCourses.where((course) => course.trainerID ==userid).toList();
      if (filteredCourses.isNotEmpty) {
          coursestrainer = filteredCourses;
          filterCoursestrainer = filteredCourses;
      } else {
        throw Exception('No courses found for trainer with ID: ${userid}');
      }
    } else {
      throw Exception('Failed to load courses. Status Code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching courses: $e');
      coursestrainer = []; // Set courses to empty list in case of error
  }
}

Future<void> getCourse(int portalid) async {
  try {
    Uri url = Uri.parse('http://192.168.1.13/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=SelectAll');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> courseJsonList = jsonDecode(response.body);
      List<Course> fetchedCourses = courseJsonList.map((json) {
        final parsedJson = json as Map<String, dynamic>;
        parsedJson['CoursePrice'] = double.parse(parsedJson['CoursePrice']);
        parsedJson['TrainerShareRate'] = double.parse(parsedJson['TrainerShareRate']);
        parsedJson['CreateDate'] = {'date': parsedJson['CreateDate']['date']};
        return Course.fromJson(parsedJson);
      }).toList();
      List<Course> filteredCourses = fetchedCourses.where((course) => course.portalID ==portalid).toList();
        print(fetchedCourses);
        filteredCourse = filteredCourses;
        courses = filteredCourses;
    } else {
      throw Exception('Failed to load courses');
    }
  } catch (e) {
      courses = [];
  }
}

Future<void> getCourseView() async {
  try {
    Uri url = Uri.parse(
        'http://192.168.1.13/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=SelectAll');
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
      fetchedCourse.sort((a, b) => b.view.compareTo(a.view));
        courseviews = fetchedCourse;
    } else {
      throw Exception('Failed to load Course view');
    }
  } catch (e) {
    print('Error fetching Course view: $e');
  }
}

Future<void> getCourseNew() async {
  try {
    Uri url = Uri.parse(
        'http://192.168.1.13/EduPlatForm/CMS/api/CourseCrudOperation.php?operation=SelectAll');
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
      fetchedCourse.sort((a, b) => b.createDate.compareTo(a.createDate));
        courseadd = fetchedCourse;
    } else {
      throw Exception('Failed to load Course view');
    }
  } catch (e) {
    print('Error fetching Course view: $e');
  }
}
