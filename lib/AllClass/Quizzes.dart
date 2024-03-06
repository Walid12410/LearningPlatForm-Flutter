class Quizzes{
  int id;
  int lessonID;

  Quizzes({
    required this.id,
    required this.lessonID
  });

  factory Quizzes.fromJson(Map<String,dynamic> json){
    return Quizzes(
        id: json['QuizID'],
        lessonID: json['LessonID']
    );
  }
}