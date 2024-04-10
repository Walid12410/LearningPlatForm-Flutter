import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/AllClass/trainer.dart';


Future<List<Trainer>> fetchTrainers(int userId) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.2/api/walid/userapi.php?status=SelectOne&UserID=$userId'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Trainer.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load trainers');
    }
}



Future<List<Trainer>> fetchAllTrainers() async {
  final response = await http.get(Uri.parse('http://192.168.1.2/api/walid/userapi.php?status=UserData'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((json) => Trainer.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load trainers');
  }
}