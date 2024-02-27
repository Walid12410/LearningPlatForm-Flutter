import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';

Future<List<Trainer>> fetchTrainers(context, int userId) async {
  AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context);

  final response = await http.get(Uri.parse(
      'http://192.168.1.13/EduPlatform/CMS/api/TrainersCrudOperation.php?operation=SelectOne&UserID=$userId'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body) as List<dynamic>;
    List<Trainer> trainers =
    jsonData.map((json) => Trainer.fromJson(json)).toList();
    if (appDataProvider.users.isEmpty) {
      appDataProvider.setTrainer(trainers);
    }
    return trainers; // Return the list of trainers
  } else {
    throw Exception('Failed to load trainers');
  }
}


Future<void> getTrainer(context) async {
  try {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context);
    Uri url = Uri.parse('http://192.168.1.13/EduPlatform/CMS/api/TrainersCrudOperation.php?operation=SelectAll');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> trainerJsonList = jsonDecode(response.body);
      List<Trainer> fetchedtrainer = trainerJsonList.map((json) => Trainer.fromJson(json)).toList();
      if(fetchedtrainer.isNotEmpty){
        appDataProvider.setTrainers(fetchedtrainer);
        appDataProvider.setFilteredTrainers(fetchedtrainer);
      }
    } else {
      throw Exception('Failed to load trainer');
    }
  } catch (e) {
    print('Error fetching trainer: $e');
  }
}