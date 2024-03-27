class Lesson {
  int id;
  int number;
  String title;
  String mediatype;
  String filepath;
  int chpaterID;
  int isactive;
  int min;
  int second;
  String mobilelink;

  Lesson({required this.id,
    required this.number,
    required this.title,
    required this.mediatype,
    required this.filepath,
    required this.chpaterID,
    required this.isactive,
    required this.min,
    required this.second,
    required this.mobilelink
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['PartID'] ?? 0,
      number: json['PartNum'] ?? 0,
      title: json['Title'] ?? '',
      mediatype: json['MediaType'] ?? '',
      filepath: json['FilePath'] ?? '',
      chpaterID: json['ChapterID'] ?? 0,
      isactive: json['IsActive'] ?? 0,
      min: json['PeriodMinutes'] ?? 0,
      second: json['PeriodSeconds'] ?? 0,
      mobilelink: json['FilepathMobile'] ?? '',
    );
  }

}
