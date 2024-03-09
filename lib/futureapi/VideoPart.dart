import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<String>?> fetchVideos(int courseId) async {
  final url = 'http://192.168.1.13/EduPlatForm/CMS/api/part.php';
  try {
    final response = await http.post(
      Uri.parse(url),
      body: {
        'operation': 'VideoShow',
        'courseid': courseId.toString(), // Convert courseId to String
      },
    );

    print('Response body: ${response.body}'); // Print the response body

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is List<String>) {
        return data;
      } else {
        return ['Invalid data format'];
      }
    } else {
      return ['Failed to load videos'];
    }
  } catch (e) {
    return ['Error: $e'];
  }
}
