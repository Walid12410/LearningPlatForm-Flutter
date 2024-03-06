class Lesson{
  int id;
  int chpaterID;
  String title;
  String description;
  String pdf;
  String video;
  String image;

  Lesson({
    required this.id,
    required this.chpaterID,
    required this.title,
    required this.description,
    required this.pdf,
    required this.video,
    required this.image
  });

  factory Lesson.fromJson(Map<String,dynamic>json){
    return Lesson(
        id: json['LessonID'],
        chpaterID: json['ChapterID'],
        title: json['Title'],
        description: json['Description'],
        pdf: json['PDFPath'],
        video: json['VideoPath'],
        image: json['ImagePath']
    );
  }
}