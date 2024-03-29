class Course {
  int id;
  String name;
  String description;
  double price;
  double trainerShareRate;
  DateTime createDate;
  int isActive;
  int portalID;
  int trainerID;
  int view;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.trainerShareRate,
    required this.createDate,
    required this.isActive,
    required this.portalID,
    required this.trainerID,
    required this.view
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['CourseID'],
      name: json['CourseName'],
      description: json['CourseDescription'],
      price: json['CoursePrice'],
      trainerShareRate: json['TrainerShareRate'],
      createDate: DateTime.parse(json['CreateDate']['date']), // parse the 'date' part of the CreateDate
      isActive: json['IsActive'],
      portalID: json['PortalID'],
      trainerID: json['UserID'],
      view: json['views']
    );
  }
}



