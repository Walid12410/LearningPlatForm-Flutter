import 'package:http/http.dart' as http;
import 'dart:convert';

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
      id: json['UserID'] ?? 0,
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
List<Trainer> users = []; // Define list to store trainers
List<Trainer> trainers = [];
List<Trainer> filteredTrainers = [];


Future<List<Trainer>> fetchTrainers(int userId) async {
  final response = await http.get(Uri.parse(
      'http://192.168.1.46/EduPlatform/CMS/api/TrainersCrudOperation.php?operation=SelectOne&UserID=$userId'));
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body) as List<dynamic>;
    List<Trainer> trainers =
    jsonData.map((json) => Trainer.fromJson(json)).toList();
      users = trainers; // Store fetched trainers in users list
    return trainers;
  } else {
    throw Exception('Failed to load trainers');
  }
}

Future<void> getTrainer() async {
  try {
    Uri url = Uri.parse('http://192.168.1.46/EduPlatform/CMS/api/TrainersCrudOperation.php?operation=SelectAll');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> portalJsonList = jsonDecode(response.body);
      List<Trainer> fetchedPortals = portalJsonList.map((json) => Trainer.fromJson(json)).toList();
        trainers = fetchedPortals;
        filteredTrainers = fetchedPortals;
    } else {
      throw Exception('Failed to load trainer');
    }
  } catch (e) {
    print('Error fetching trainer: $e');
  }
}
