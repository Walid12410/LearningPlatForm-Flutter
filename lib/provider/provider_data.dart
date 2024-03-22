import 'package:flutter/cupertino.dart';
import 'package:learningplatformapp/AllClass/CourseTime.dart';
import 'package:learningplatformapp/AllClass/ShowFirstVideo.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/AllClass/portal.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:learningplatformapp/AllClass/TainerCourseShow.dart';
import 'package:learningplatformapp/futureapi/CourseApi.dart';
import 'package:learningplatformapp/futureapi/LeasonCalculate.dart';
import 'package:learningplatformapp/futureapi/PortalApi.dart';
import 'package:learningplatformapp/futureapi/TotalCourseTime.dart';
import 'package:learningplatformapp/futureapi/TrainerApi.dart';
import 'package:learningplatformapp/futureapi/TrainerCourseShowApi.dart';
import 'package:learningplatformapp/futureapi/VideoPart.dart';

class AppDataProvider extends ChangeNotifier {
  int _userId = 0;
  int get userId => _userId;

  void setUserId(int userId) {
    _userId = userId;
    notifyListeners();
  }

  List<CourseTime> _courseTime = [];
  List<CourseTime> get courseTime => _courseTime;
  getCourseTine(int courseid) async {
    final res = await TotalCourseTime(courseid);
    _courseTime = res;
    notifyListeners();
  }

  List<TrainerCourseShow> _data = [];
  List<TrainerCourseShow> get data => _data;
  getTrainerCourseShow(int courseid) async {
    final res = await getDataTrainerCourse(courseid);
    _data = res;
    notifyListeners();
  }

  List<String> _partNumbers = [];
  List<String> get partNumber => _partNumbers;
  Future<void> getPartNumber(int courseid) async {
    final res = await fetchPartNumbers(courseid);
    _partNumbers = res.map((item) => item.toString()).toList();
    notifyListeners();
  }

  List<Course> _CourseByID = [];
  List<Course> get CourseByID => _CourseByID;
  Future<void> fetchCourseByID(int courseId) async {
    final courses = await getCourseByID(courseId);
    if (courses != null) {
      _CourseByID = courses;
      notifyListeners();
    } else {
      print('Error: Courses is null');
    }
  }

  List<ShowFirstVideo> _fvideo = [];
  List<ShowFirstVideo> get fvideo => _fvideo;
  getFirstVideo(int courseID) async{
    final res = await fetchVideo(courseID);
    _fvideo = res;
    notifyListeners();
  }

  List<Course> _allCourses = [];
  List<Course> get allCourses => _allCourses;
  getAllCourse() async{
    final res = await getAllCourses();
    if (res != null) {
      _allCourses = res;
      notifyListeners();
    } else {
      print('Error: Courses is null');
    }
  }


  List<Course> _courseadd = [];
  List<Course> get courseadd => _courseadd;
  getCourseadd() async{
    final res = await getCourseNew();
    if (res != null) {
      _courseadd = res;
      notifyListeners();
    } else {
      print('Error: Courses is null');
    }
  }

  List<Course> _courseviews = [];
  List<Course> get courseviews => _courseviews;
  getcourseview() async{
    final res = await getCourseView();
    if(res != null){
      _courseviews = res;
      notifyListeners();
    }else{
      print('Error course is null');
    }
  }

  List<Course> _randomcourse = [];
  List<Course> get randomcourse => _randomcourse;
  getrandomcourse() async{
    final res = await getRandomCourse();
    if(res != null){
      _randomcourse = res;
      notifyListeners();
    }else{
      print('Error: course is empty');
    }
  }

  List<Trainer> _users = []; // Define list to store trainers
  List<Trainer> get users => _users;
  getTrainer(int userid) async{
    final res = await fetchTrainers(userid);
    _users = res;
    notifyListeners();
  }

  List<Portal> _portals = [];
  List<Portal> get portals => _portals;
  getportal() async{
    final res = await getPortals();
    _portals = res;
    notifyListeners();
  }

  List<Portal> _filteredPortals = [];
  List<Portal> get filteredPortals => _filteredPortals;
  getFilteredPortals() async{
    final res = await getPortals();
    _filteredPortals = res;
    notifyListeners();
  }

  void deletePortal() {
    portals.clear();
    filteredPortals.clear();
    notifyListeners();
  }

  void searchdelete() {
    allCourses.clear();
    portals.clear();
    notifyListeners();
  }

  List<Course> courses = [];
  List<Course> filteredCourse = [];
  List<Course> coursestrainer = [];
  List<Course> filterCoursestrainer = [];


  void deleteCourseByID() {
    CourseByID.clear();
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


  void setFilterCourseTrainer(List<Course> course) {
    filterCoursestrainer = course;
    notifyListeners();
  }

  void setCourseTrainer(List<Course> course) {
    coursestrainer = course;
    notifyListeners();
  }



  List<Trainer> trainers = [];
  List<Trainer> filteredTrainers = [];




  void setTrainers(List<Trainer> trainer) {
    trainers = trainer;
    notifyListeners();
  }

  void setFilteredTrainers(List<Trainer> trainer) {
    filteredTrainers = trainer;
    notifyListeners();
  }
}
