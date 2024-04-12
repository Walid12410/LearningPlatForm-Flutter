import 'package:http/http.dart' as http;
import 'dart:convert';

Future<double> fetchAverageRating(int courseId) async {
  try {
    final apiUrl = 'http://192.168.1.4/api/walid/feedback.php?operation=getAverageRating&course_id=$courseId';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        final averageRatingValue = data['average_rating'];
        if (averageRatingValue != null) {
          return double.parse(averageRatingValue.toString());
        }
      }
    }
  } catch (e) {
    print('Error fetching average rating: $e');
  }
  return 0.0; // Return a default value if fetching fails
}
