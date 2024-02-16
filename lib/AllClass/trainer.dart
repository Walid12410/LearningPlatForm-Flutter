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
  final String usertype;

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
    required this.usertype
  });

  factory Trainer.fromJson(Map<String, dynamic> json) {
    String tpicture = json['UserProfilePic'] ?? '';
    if (tpicture == null && json['UserProfilePic'] is String) {
      tpicture = '';
    }
    final Map<String, dynamic> joinDateJson = json['JoinDate'];
    final String dateString = joinDateJson['date'] ?? '';

    return Trainer(
      id: json['TrainerID'] ?? 0,
      fname: json['UserFirstName'] ?? '',
      lname: json['UserLastName'] ?? '',
      tpicture: tpicture,
      telephone: json['UserTelephone'] ?? '',
      joindate: dateString.isNotEmpty ? DateTime.parse(dateString) : DateTime.now(),
      isActive: json['IsActive'] == 1,
      email: json['UserEmail'] ?? '',
      gender: json['UserGender'] ?? '',
      usertype: json['UserType']
    );
  }

  @override
  String toString() {
    return '$fname $lname';
  }
}
