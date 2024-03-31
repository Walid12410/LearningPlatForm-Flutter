import 'dart:convert';
import 'package:http/http.dart' as http;

class FavoriteService {
  static Future<bool> checkFavorite(int userId, int courseId) async {
    String url = 'http://192.168.1.12/api/walid/favoritecourse.php';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'operation': 'check',
        'UserID': userId.toString(),
        'CourseID': courseId.toString(),
      },
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final isFavoriteValue = responseData['is_favorite'];
      return isFavoriteValue;
    } else {
      throw Exception('Failed to check favorite: ${response.statusCode}');
    }
  }

  static Future<bool> toggleFavorite(int userId, int courseId, bool isFavorite) async {
    String url = 'http://192.168.1.12/api/walid/favoritecourse.php';
    final operation = isFavorite ? 'add' : 'delete';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'operation': operation,
        'UserID': userId.toString(),
        'CourseID': courseId.toString(),
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to toggle favorite: ${response.statusCode}');
    }
  }
}
