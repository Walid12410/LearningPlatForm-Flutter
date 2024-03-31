import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List> fetchPartNumbers(int courseId) async {
    final response = await http.get(Uri.parse(
        'http://192.168.1.12/api/walid/countlesson.php?operation=CLesson&CourseID=$courseId'));
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
}
