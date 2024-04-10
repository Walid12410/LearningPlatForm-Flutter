import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/AllClass/Question.dart';
import 'package:learningplatformapp/AllClass/QuestionChoice.dart';

Future<List<Question>> fetchQuizQuestion(int chapterID) async {
  final response = await http.get(Uri.parse(
      'http://192.168.1.2/api/walid/quiz.php?status=dataQuestion&ChapterID=$chapterID'));
  if (response.statusCode == 200) {
    List<dynamic> responseData = json.decode(response.body);
    List<Question> qZ = [];
    for (var questionJson in responseData) {
      Question question = Question.fromJson(questionJson);
      qZ.add(question);
    }
    return qZ;
  } else {
    throw Exception('Failed to load question');
  }
}


Future<List<questionChoice>> fetchQuestionChoice() async {
  final response = await http.get(Uri.parse(
      'http://192.168.1.2/api/webQuestionChoice.php?status=data'));
  if (response.statusCode == 200) {
    final responseData = json.decode(response.body)['data']; // Accessing the 'data' key
    List<questionChoice> qC = [];
    for (var choiceJson in responseData) {
      questionChoice qChoice = questionChoice.fromJson(choiceJson);
      qC.add(qChoice);
    }
    return qC;
  } else {
    throw Exception('Failed to load questionChoice');
  }
}


