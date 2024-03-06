class Chapter {
  int id;
  String title;
  String description;
  int courseID;

  Chapter({
    required this.id,
    required this.title,
    required this.description,
    required this.courseID
  });

  factory Chapter.fromJson(Map<String,dynamic> json){
    return Chapter(
        id: json['ChapterID'],
        title: json['ChapterTitle'],
        description: json['Description'],
        courseID: json['CourseID']
    );
  }
}
