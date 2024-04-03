class CourseReview {
  final int id;
  final int userId;
  final int courseId;
  final int rating;
  final String comment;
  final DateTime? timestamp;
  final int ?timezoneType;
  final String ?timezone;
  final String fName;
  final String lName;
  final String photo;

  CourseReview({
    required this.id,
    required this.userId,
    required this.courseId,
    required this.rating,
    required this.comment,
    required this.timestamp,
    required this.timezoneType,
    required this.timezone,
    required this.fName,
    required this.lName,
    required this.photo
  });

  factory CourseReview.fromJson(Map<String, dynamic> json) {
    return CourseReview(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 1,
      courseId: json['course_id'] ?? 0,
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      timestamp: DateTime.parse(json['timestamp']['date']),
      timezoneType: json['timestamp']['timezone_type'],
      timezone: json['timestamp']['timezone'],
      fName: json['FName'] ?? '',
      lName: json['LName'] ?? '',
      photo: json['Photo'] ?? ''
    );
  }

  @override
  String toString() {
    return '$fName $lName';
  }
}
