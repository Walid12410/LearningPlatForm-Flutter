class Course {
  int id;
  String title;
  String description;
  DateTime? start;
  DateTime? stop;
  DateTime? createDate;
  int portalID;
  int trainerID;
  int isActive;
  double price;
  int view;
  int isnew;
  int periodhours;
  int periodminutes;

  Course(
      {required this.id,
      required this.title,
      required this.description,
      required this.start,
      required this.stop,
      required this.createDate,
      required this.portalID,
      required this.trainerID,
      required this.isActive,
      required this.price,
      required this.view,
      required this.isnew,
      required this.periodhours,
      required this.periodminutes});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['CourseID'] ?? 0,
      title: json['Title'] ?? '',
      description: json['CourseDescr'] ?? '',
      start: json['StartDate'] != null ? DateTime.parse(json['StartDate']['date']) : null,
      stop: json['StopDate'] != null ? DateTime.parse(json['StopDate']['date']) : null,
      createDate: json['CreateDate'] != null ? DateTime.parse(json['CreateDate']['date']) : null,
      portalID: json['CoursePortalID'] ?? 0,
      trainerID: json['TrainerID'] ?? 0,
      isActive: json['IsActive'] ?? 1,
      price: json['CoursePrice'] != null ? double.parse(json['CoursePrice']) : 0.0,
      view: json['nbrOfViews'] ?? 0,
      isnew: json['IsNew'] ?? 0,
      periodhours: json['PeriodHours'] ?? 0,
      periodminutes: json['PeriodMinutes'] ?? 0,
    );
  }

}
