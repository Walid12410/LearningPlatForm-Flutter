import 'dart:convert';
import 'package:http/http.dart' as http;

class FavoriteService {
  static Future<bool> checkFavorite(int userId, int courseId) async {
    final url = 'http://192.168.1.5/EduPlatForm/CMS/api/favorite.php';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'operation': 'check',
        'user_id': userId.toString(),
        'course_id': courseId.toString(),
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

  static Future<bool> toggleFavorite(
      int userId, int courseId, bool isFavorite) async {
    final url = 'http://192.168.1.5/EduPlatForm/CMS/api/favorite.php';
    final operation = isFavorite ? 'delete' : 'add';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'operation': operation,
        'user_id': userId.toString(),
        'course_id': courseId.toString(),
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to toggle favorite: ${response.statusCode}');
    }
  }
}
