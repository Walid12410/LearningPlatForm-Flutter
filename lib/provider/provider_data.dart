import 'package:flutter/cupertino.dart';
import 'package:learningplatformapp/AllClass/CourseTime.dart';
import 'package:learningplatformapp/AllClass/course.dart';
import 'package:learningplatformapp/AllClass/portal.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:learningplatformapp/AllClass/TainerCourseShow.dart';
import 'package:learningplatformapp/futureapi/ChapterApi.dart';
import 'package:learningplatformapp/futureapi/CourseApi.dart';
import 'package:learningplatformapp/futureapi/CourseParicipationApi.dart';
import 'package:learningplatformapp/futureapi/LeasonCalculate.dart';
import 'package:learningplatformapp/futureapi/LessonApi.dart';
import 'package:learningplatformapp/futureapi/ParticipationApi.dart';
import 'package:learningplatformapp/futureapi/PortalApi.dart';
import 'package:learningplatformapp/futureapi/QuizApi.dart';
import 'package:learningplatformapp/futureapi/RatingCourses.dart';
import 'package:learningplatformapp/futureapi/RatingDetails.dart';
import 'package:learningplatformapp/futureapi/TotalCourseTime.dart';
import 'package:learningplatformapp/futureapi/TrainerApi.dart';
import 'package:learningplatformapp/futureapi/TrainerCourseShowApi.dart';
import 'package:flutter/material.dart';
import '../AllClass/Chapter.dart';
import '../AllClass/CourseParticipated.dart';
import '../AllClass/Lesson.dart';
import '../AllClass/Participation.dart';
import '../AllClass/Question.dart';
import '../AllClass/QuestionChoice.dart';
import '../AllClass/RatingDetails.dart';

class AppDataProvider extends ChangeNotifier {
  int _userId = 0;
  int get userId => _userId;

  void setUserId(int userId) {
    _userId = userId;
    notifyListeners();
  }

  List<CourseTime> _courseTime = [];
  List<CourseTime> get courseTime => _courseTime;
  getCourseTine(int id) async {
    final res = await TotalCourseTime(id);
    _courseTime = res;
    notifyListeners();
  }

  List<TrainerCourseShow> _data = [];
  List<TrainerCourseShow> get data => _data;
  getTrainerCourseShow(int id) async {
    final res = await getDataTrainerCourse(id);
    _data = res;
    notifyListeners();
  }

  List<String> _partNumbers = [];
  List<String> get partNumber => _partNumbers;
  Future<void> getPartNumber(int id) async {
    final res = await fetchPartNumbers(id);
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

  List<Trainer> _users = [];
  List<Trainer> get users => _users;
  getTrainer(int userid) async {
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

  Map<int, double> _averageRatings = {}; // Map to store average ratings by course ID
  Map<int, double> get averageRatings => _averageRatings;
  Future<void> fetchAndSetAverageRating(int courseId) async {
    try {
      final double averageRating = await fetchAverageRating(courseId);
      _averageRatings[courseId] = averageRating;
      notifyListeners();
    } catch (error) {
      print('Error fetching average rating for course $courseId: $error');
    }
  }


  List<Trainer> _trainers = [];
  List<Trainer> get trainers => _trainers;
  getAllTrainer() async{
    final res = await fetchAllTrainers();
    _trainers = res;
    notifyListeners();
  }

  List<Course> _coursestrainer = [];
  List<Course> get coursestrainer => _coursestrainer;
  getcoursetrainer(int id) async{
    final res = await getCourseTrainer(id);
    _coursestrainer = res;
    notifyListeners();
  }

  List<Course> _courses = [];
  List<Course> get courses => _courses;
  getCoursePortal(int id) async{
    final res = await getCourse(id);
    _courses = res ;
    notifyListeners();
  }

  List<Chapter> _allchapter = [];
  List<Chapter> get allchapter => _allchapter;
  getChapterByID(int id) async {
    final res = await fetchChaptersByCourseID(id);
    _allchapter = res;
    notifyListeners();
  }

  List<Lesson> _lesson =[];
  List<Lesson> get lesson => _lesson;
  Future<void> getLessonById(int id) async {
    final res = await fetchLessonsByCourseID(id);
    _lesson = res;
    notifyListeners();
  }

  List<CourseReview> _review = [];
  List<CourseReview> get courseReview => _review;
  getReviewCourseDetails(int id) async{
    final res = await fetchCourseReview(id);
    _review = res;
    notifyListeners();
  }

  List<Question> _question = [];
  List<Question> get question => _question;
  getQuizQuestions(int id) async{
    final res = await fetchQuizQuestion(id);
    _question = res;
    notifyListeners();
  }

  List<questionChoice> _qChoice = [];
  List<questionChoice> get qChoice => _qChoice;
  getQuestionChoice() async{
    final res = await fetchQuestionChoice();
    _qChoice = res;
    notifyListeners();
  }

  List<CourseParticipated> _cParticipated = [];
  List<CourseParticipated> get cParticipated => _cParticipated;
  getCourseParticipated() async{
    final res = await fetchAllCourseParticipation();
    _cParticipated = res;
    notifyListeners();
  }

  List<Participation> _participation = [];
  List<Participation> get participation => _participation;
  getParticipation() async{
    final res = await fetchAllParticipation();
    _participation = res;
    notifyListeners();
  }

}



