class ImageCourse{
  int id;
  String image;
  int courseID;

  ImageCourse({
    required this.id,
    required this.image,
    required this.courseID
  });

  factory ImageCourse.fromJson(Map<String,dynamic> json){
    return ImageCourse(
        id: json['id'],
        image: json['image_path'],
        courseID: json['course_id']
    );
  }
}