class CourseParticipated{
  final int parCID;
  final int parID;
  final int courseID;
  final double coursePrice;

  CourseParticipated({
    required this.parCID,
    required this.parID,
    required this.courseID,
    required this.coursePrice
  });

  factory CourseParticipated.fromJson(Map<String, dynamic> json) {
    return CourseParticipated(
      parCID: json['ParCID'] ?? 0,
      parID: json['ParID'] ?? 0,
      courseID: json['CourseID'] ?? 0,
      coursePrice: json['CoursePrice'] != null ? double.parse(json['CoursePrice']) : 0.0,
    );
  }
}