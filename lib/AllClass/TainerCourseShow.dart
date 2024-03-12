class TrainerCourseShow{
  String fname;
  String lname;
  String ProfilePicture;

  TrainerCourseShow({
    required this.fname,
    required this.lname,
    required this.ProfilePicture
  });


  @override
  String toString() {
    return '$fname $lname';
  }

  factory TrainerCourseShow.fromJson(Map<String,dynamic>json){
    return TrainerCourseShow(
        fname : json['UserFirstName'],
        lname : json ['UserLastName'] ,
        ProfilePicture : json ['UserProfilePic']
    );
  }
}