import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/AllClass/trainer.dart';


Future<List<Trainer>> fetchTrainers(int userId) async {
  try {
    final response = await http.get(Uri.parse(
        'http://192.168.1.12/EduPlatform/CMS/api/TrainersCrudOperation.php?operation=SelectOne&UserID=$userId'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      List<Trainer> trainers = jsonData.map((json) => Trainer.fromJson(json)).toList();
      return trainers; // Return the list of trainers
    } else {
      throw Exception('Failed to load trainers');
    }
  } catch (e) {
    print('Error fetching trainers: $e');
    rethrow; // Rethrow the error for handling in the calling function
  }
}



Future<List<Trainer>> fetchAllTrainer() async {
  try {
    Uri url = Uri.parse('http://192.168.1.12/EduPlatform/CMS/api/TrainersCrudOperation.php?operation=SelectAll');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> trainerJsonList = jsonDecode(response.body);
      List<Trainer> fetchedtrainer = trainerJsonList.map((json) => Trainer.fromJson(json)).toList();
      return fetchedtrainer;
    } else {
      throw Exception('Failed to load trainer');
    }
  } catch (e) {
    print('Error fetching trainer: $e');
    return [];
  }
}
