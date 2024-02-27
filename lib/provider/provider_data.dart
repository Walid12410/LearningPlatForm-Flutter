import 'package:flutter/cupertino.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/AllClass/portal.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';

class AppDataProvider extends ChangeNotifier {
  int _userId = 0;
  int get userId => _userId;

  void setUserId(int userId) {
    _userId = userId;
    notifyListeners();
  }


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

  List<Portal> portals = [];
  List<Portal> filteredPortals = [];

  void setPortalCourse(List<Portal> portal){
    portals = portal;
    notifyListeners();
  }

  void setFilterPortalCourse(List<Portal> portal){
    filteredPortals = portal;
    notifyListeners();
  }

  List<Trainer> users = []; // Define list to store trainers
  List<Trainer> trainers = [];
  List<Trainer> filteredTrainers = [];

  void setTrainer(List<Trainer> trainer){
    users = trainer;
    notifyListeners();
  }

  void setTrainers(List<Trainer> trainer){
    trainers =trainer;
    notifyListeners();
  }

  void setFilteredTrainers(List<Trainer> trainer){
    filteredTrainers =trainer;
    notifyListeners();
  }
}