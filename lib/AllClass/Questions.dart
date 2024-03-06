class Questions{
  int id;
  int quizID;
  String questionText;
  String correctOption;
  String option1;
  String option2;
  String option3;
  String option4;

  Questions({
    required this.id,
    required this.quizID,
    required this.questionText,
    required this.correctOption,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4
  });

  factory Questions.fromJson(Map<String,dynamic>json){
    return Questions(
        id: json['QuestionID'],
        quizID: json['QuizID'],
        questionText: json['QuestionText'],
        correctOption: json['CorrectOption'],
        option1: json['Option1'],
        option2: json['Option2'],
        option3: json['Option3'],
        option4 : json['Option4'],
    );
  }
}