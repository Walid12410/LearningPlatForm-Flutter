class Lesson {
  int id;
  String name;
  int number;
  String description;
  String video;
  int videoMin;
  int videoSec;
  int chpaterID;

  Lesson({required this.id,
    required this.name,
    required this.number,
    required this.description,
    required this.video,
    required this.videoMin,
    required this.videoSec,
    required this.chpaterID
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
        id: json['PartID'],
        name: json['PartName'],
        number: json['PartNumber'],
        description: json['PartDescription'],
        video: json['PartVideo'],
        videoMin: json['VideoMin'],
        videoSec: json['VideoSec'],
        chpaterID: json['ChapterID']
    );
  }
}
