import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/AllClass/Participation.dart';

Future<List<Participation>> fetchAllParticipation() async {
  final response = await http.get(Uri.parse(
      'http://192.168.1.2/api/webParticipation.php?status=data'));
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> jsonData = data['data'];
    List<Participation> participation = [];
    for (var participationJson in jsonData) {
      Participation par = Participation.fromJson(participationJson);
      participation.add(par);
    }
    return participation;
  } else {
    throw Exception('Failed to load participation');
  }
}
