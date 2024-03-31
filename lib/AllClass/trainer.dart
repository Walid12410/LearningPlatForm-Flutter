class Trainer {
  final int id;
  final String firstname;
  final String fName;
  final String lastname;
  final DateTime? dob;
  final String telephone;
  final String email;
  final String picture;
  final int isActive;
  final String usertype;
  final String title;
  final String description;

  Trainer(
      {required this.id,
      required this.firstname,
      required this.fName,
      required this.lastname,
      required this.dob,
      required this.telephone,
      required this.email,
      required this.picture,
      required this.isActive,
      required this.usertype,
      required this.title,
      required this.description});

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      id: json['UserID'] ?? 0,
      firstname: json['FName'] ?? '',
      fName: json['FatName'] ?? '',
      lastname: json['LName'] ?? '',
      dob: json['DOB'] != null ? DateTime.parse(json['DOB']['date']) : null,
      telephone: json['Phone'] ?? '',
      email: json['Email'] ?? '',
      picture: json['Photo'] ?? '',
      isActive: json['IsActive'] ?? true,
      usertype: json['UserType'] ?? '',
      title: json['Title'] ?? '',
      description: json['Description'] ?? '',
    );
  }

  @override
  String toString() {
    return '$firstname $lastname';
  }
}
