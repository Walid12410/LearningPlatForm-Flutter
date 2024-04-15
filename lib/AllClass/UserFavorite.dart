class UserFavorite {
  final int id;
  final int userID;
  final int courseID;
  final String title;
  final String courseDescription;

  UserFavorite({
    required this.id,
    required this.userID,
    required this.courseID,
    required this.title,
    required this.courseDescription,
  });

  factory UserFavorite.fromJson(Map<String, dynamic> json) {
    return UserFavorite(
      id: json['id'] ?? 0,
      userID: json['UserID'] ?? 0,
      courseID: json['CourseID'] ?? 0,
      title: json['Title'] ?? '',
      courseDescription: json['CourseDescr'] ?? '',
    );
  }
}
