import 'package:flutter/cupertino.dart';
import 'package:learningplatformapp/AllClass/course.dart';

class AppDataProvider extends ChangeNotifier {
  List<Course> courses = [];
  List<Course> filteredCourse = [];
  List<Course> courseviews = [];
  List<Course> courseadd = [];
  List<Course> coursestrainer = [];
  List<Course> filterCoursestrainer = [];
  List<Course> allCourses = [];
  List<Course> randomcourse = [];

  void setAllCourses(courses) {
    allCourses = courses;
    notifyListeners();
  }

  void setCourses(List<Course> course) {
    courses = course;
    notifyListeners();
  }

  void setFilterCourse(List<Course> course) {
    filteredCourse = course; // Corrected assignment
    notifyListeners();
  }


  void setCourseView(course) {
    courseviews = course;
    notifyListeners();
  }

  void setCourseadd(course) {
    courseadd = course;
    notifyListeners();
  }

  void setRandonCourse(course) {
    randomcourse = course;
    notifyListeners();
  }

  void setFilterCourseTrainer(List<Course> course) {
    filterCoursestrainer = course;
    notifyListeners();
  }

  void setCourseTrainer(List<Course> course) {
    coursestrainer = course;
    notifyListeners();
  }
}
