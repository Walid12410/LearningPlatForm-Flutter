import 'package:http/http.dart' as http;
import 'dart:convert';

List<String> partNumbers = [];

Future<void> fetchPartNumbers(int courseId) async {
  final response = await http.get(Uri.parse('http://192.168.1.3/EduPlatForm/CMS/api/CountLesson.php?operation=CLesson&CourseID=$courseId'));

  if (response.statusCode == 200) {
    final dynamic parsedData = json.decode(response.body);

    if (parsedData is List) {
      // Check if parsedData is a list
      partNumbers = parsedData.map((item) => item.toString()).toList();
    } else {
      throw Exception('Invalid data format: Expected a list');
    }
  } else {
    throw Exception('Failed to load part numbers');
  }
}
