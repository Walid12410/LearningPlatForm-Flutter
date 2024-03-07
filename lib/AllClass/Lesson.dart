class Lesson {
  int id;
  String name;
  int number;
  String description;
  String video;
  double videoMin;
  double videoSec;
  int chpaterID;

  Lesson({required this.id,
    required this.name,
    required this.number,
    required this.description,
    required this.video,
    required this.videoMin,
    required this.videoSec,
    required this.chpaterID});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
        id: json['PartID'],
        name: json['PartName'],
        number: json['PartNumber'],
        description: json['PartDescription'],
        video: json['PartVideo'],
        videoMin: json['videoMin'],
        videoSec: json['videoSec'],
        chpaterID: json['ChapterID']
    );
  }
}
