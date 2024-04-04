class Question{
  int id;
  int qNum;
  String question;
  String qType;
  int hasOnlyOne;
  int chapterID;

  Question({
    required this.id,
    required this.qNum,
    required this.question,
    required this.qType,
    required this.hasOnlyOne,
    required this.chapterID,
  });

  factory Question.fromJson(Map<String,dynamic>json){
    return Question(
        id: json['QuestionID'] ?? 0,
        qNum: json['QuestionNum'] ?? 0,
        question: json['Question'] ?? '',
        qType: json['QuestionType'] ?? '',
        hasOnlyOne: json['HasOnlyOne'] ?? 0,
        chapterID: json['ChapterID'] ?? 0
    );
  }
}