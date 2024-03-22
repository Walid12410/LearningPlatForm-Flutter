import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/AllClass/portal.dart';

Future<List<Portal>> getPortals() async {
  try {
    Uri url = Uri.parse('http://192.168.1.12/EduPlatForm/CMS/api/PortalCrudOperation.php?operation=SelectAll');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> portalJsonList = jsonDecode(response.body);
      List<Portal> fetchedPortals = portalJsonList.map((json) => Portal.fromJson(json)).toList();
      return fetchedPortals;
    } else {
      throw Exception('Failed to load portals');
    }
  } catch (e) {
    print('Error fetching portals: $e');
    // Return an empty list in case of error
    return [];
  }
}
