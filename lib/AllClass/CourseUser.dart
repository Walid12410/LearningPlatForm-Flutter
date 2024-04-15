class UserCourse {
  final int parCID;
  final int parID;
  final String title;
  final String courseDescr;
  final int courseID;

  UserCourse({
    required this.parCID,
    required this.parID,
    required this.title,
    required this.courseDescr,
    required this.courseID
  });

  factory UserCourse.fromJson(Map<String, dynamic> json) {
    return UserCourse(
      parCID: json['ParCID'] ?? 0,
      parID: json['ParID'] ?? 0,
      title: json['Title'] ?? '',
      courseDescr: json['CourseDescr'] ?? '',
      courseID: json['CourseID'] ?? 0
    );
  }
}
