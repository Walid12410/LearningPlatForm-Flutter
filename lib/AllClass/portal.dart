import 'package:http/http.dart' as http;
import 'dart:convert';

class Portal {
  int portalID;
  String portalName;
  String portalDescription;
  int isActive;

  Portal({
    required this.portalID,
    required this.portalName,
    required this.portalDescription,
    required this.isActive,
  });

  factory Portal.fromJson(Map<String, dynamic> json) {
    return Portal(
      portalID: json['PortalID'],
      portalName: json['PortalName'],
      portalDescription: json['PortalDescription'],
      isActive: json['IsActive'],
    );
  }
}
List<Portal> portals = [];
List<Portal> filteredPortals = [];

Future<void> getPortals() async {
  try {
    Uri url = Uri.parse('http://192.168.1.13/EduPlatForm/CMS/api/PortalCrudOperation.php?operation=SelectAll');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> portalJsonList = jsonDecode(response.body);
      List<Portal> fetchedPortals = portalJsonList.map((json) => Portal.fromJson(json)).toList();
        filteredPortals = fetchedPortals;
        portals = fetchedPortals;
    } else {
      throw Exception('Failed to load portals');
    }
  } catch (e) {
    print('Error fetching portals: $e');
      portals = [];
  }
}