import 'package:http/http.dart' as http;
import 'dart:convert';


Future<List> fetchPartNumbers(int courseId) async {
  try {
    final response = await http.get(Uri.parse(
        'http://192.168.1.12/EduPlatForm/CMS/api/CountLesson.php?operation=CLesson&CourseID=$courseId'));
    if (response.statusCode == 200) {
      final dynamic parsedData = json.decode(response.body);
      if (parsedData is List) {
        List<String> partNumbers =
        parsedData.map((item) => item.toString()).toList();
        return partNumbers;
      } else {
        throw Exception('Invalid data format: Expected a list');
      }
    } else {
      throw Exception('Failed to load part numbers');
    }
  } catch (error) {
    print('Error fetching part numbers: $error');
    rethrow; // Rethrow the error to handle it elsewhere if needed
  }
}
