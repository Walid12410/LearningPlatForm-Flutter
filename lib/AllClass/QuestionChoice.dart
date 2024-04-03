class questionChoice{
  final int id;
  final int qCNum;
  final String answer;
  final int isCorrect;
  final int questionID;
  final int isActive;

  questionChoice({
    required this.id,
    required this.qCNum,
    required this.answer,
    required this.isCorrect,
    required this.questionID,
    required this.isActive
  });

  factory questionChoice.fromJson(Map<String,dynamic>json){
    return questionChoice(
        id: json['QCID'],
        qCNum: json['QCNum'],
        answer: json['Answer'],
        isCorrect: json['isCorrect'],
        questionID: json['QuestionID'],
        isActive: json['IsInActive']
    );
  }
}