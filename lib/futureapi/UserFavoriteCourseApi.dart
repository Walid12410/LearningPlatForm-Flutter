import 'package:http/http.dart' as http;
import 'dart:convert';
import '../AllClass/UserFavorite.dart';

Future<List<UserFavorite>> fetchUserFavoriteCourse(int id) async {
  final response = await http.get(Uri.parse(
      'http://192.168.1.4/api/walid/UserFavoriteCourse.php?status=Data&UserID=$id'));
  if (response.statusCode == 200) {
    List<dynamic> responseData = json.decode(response.body);
    List<UserFavorite> uF = [];
    for (var uFavCourseJson in responseData) {
      UserFavorite usersCourse = UserFavorite.fromJson(uFavCourseJson);
      uF.add(usersCourse);
    }
    return uF;
  } else {
    throw Exception('Failed to load user Favorite course');
  }
}
