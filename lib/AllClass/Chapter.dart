class Chapter {
  int id;
  String title;
  int number;
  String description;
  int courseID;

  Chapter({
    required this.id,
    required this.title,
    required this.number,
    required this.description,
    required this.courseID,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['ChapterID'],
      title: json['Title'],
      number: json['ChapNum'],
      description: json['ChapDescr'],
      courseID: json['CourseID'],
    );
  }
}
