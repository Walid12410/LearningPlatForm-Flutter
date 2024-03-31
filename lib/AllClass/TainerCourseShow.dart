class TrainerCourseShow {
  String fname;
  String lname;
  String profilePicture; // Changed variable name to follow Dart naming convention

  TrainerCourseShow({
    required this.fname,
    required this.lname,
    required this.profilePicture,
  });

  @override
  String toString() {
    return '$fname $lname';
  }

  factory TrainerCourseShow.fromJson(Map<String, dynamic> json) {
    return TrainerCourseShow(
      fname: json['FName'],
      lname: json['LName'],
      profilePicture: json['Photo'],
    );
  }
}
