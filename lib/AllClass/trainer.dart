class Trainer {
  int? id;
  String? fname;
  String? lname;
  String? tpicture;
  String? telephone;
  String? gender;
  String? email;
  DateTime? joindate;
  bool? isActive;

  Trainer({
    this.id,
    this.fname,
    this.lname,
    this.tpicture,
    this.telephone,
    this.isActive,
    this.gender,
    this.joindate,
    this.email,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) {
    String? tpicture = json['TrainerProfilePic'];
    if (tpicture == null && json['TrainerProfilePic'] is String) {
      tpicture = "";
    }
    final Map<String, dynamic> joinDateJson = json['JoinDate'];
    final String dateString = joinDateJson['date'];

    return Trainer(
      id: json['TrainerID'],
      fname: json['TrainerFName'],
      lname: json['TrainerLName'],
      tpicture: tpicture,
      telephone: json['TrainerTelephone'],
      joindate: dateString != null ? DateTime.parse(dateString) : null,
      isActive: json['IsActive'] == 1,
      email: json['TrainerEmail'],
      gender: json['TrainerGender'],
    );
  }

  @override
  String toString() {
    return '$fname $lname';
  }
}