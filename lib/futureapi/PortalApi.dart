import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/AllClass/portal.dart';

Future<List<Portal>> getPortals() async {
  try {
    Uri url = Uri.parse('http://192.168.1.2/api/webCoursePortal.php?status=data');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final dynamic jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey('data')) {
        final List<dynamic> portalJsonList = jsonResponse['data'];
        List<Portal> fetchedPortals = portalJsonList.map((json) => Portal.fromJson(json)).toList();
        return fetchedPortals;
      } else {
        throw Exception('Invalid response format: missing "data" key');
      }
    } else {
      throw Exception('Failed to load portals');
    }
  } catch (e) {
    print('Error fetching portals: $e');
    return [];
  }
}

