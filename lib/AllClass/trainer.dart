class Trainer {
  final int id;
  final String fname;
  final String lname;
  final String tpicture;
  final String telephone;
  final String gender;
  final String email;
  final DateTime joindate;
  final bool isActive;

  Trainer({
    required this.id,
    required this.fname,
    required this.lname,
    required this.tpicture,
    required this.telephone,
    required this.gender,
    required this.email,
    required this.joindate,
    required this.isActive,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) {
    String tpicture = json['TrainerProfilePic'] ?? '';
    if (tpicture == null && json['TrainerProfilePic'] is String) {
      tpicture = '';
    }
    final Map<String, dynamic> joinDateJson = json['JoinDate'];
    final String dateString = joinDateJson['date'] ?? '';

    return Trainer(
      id: json['TrainerID'] ?? 0,
      fname: json['TrainerFName'] ?? '',
      lname: json['TrainerLName'] ?? '',
      tpicture: tpicture,
      telephone: json['TrainerTelephone'] ?? '',
      joindate: dateString.isNotEmpty ? DateTime.parse(dateString) : DateTime.now(),
      isActive: json['IsActive'] == 1,
      email: json['TrainerEmail'] ?? '',
      gender: json['TrainerGender'] ?? '',
    );
  }

  @override
  String toString() {
    return '$fname $lname';
  }
}
