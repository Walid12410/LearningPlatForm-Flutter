import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:learningplatformapp/AllClass/portal.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';

Future<void> getPortals(BuildContext context) async {
  try {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context,listen: false);
    Uri url = Uri.parse('http://192.168.1.52/EduPlatForm/CMS/api/PortalCrudOperation.php?operation=SelectAll');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> portalJsonList = jsonDecode(response.body);
      List<Portal> fetchedPortals = portalJsonList.map((json) => Portal.fromJson(json)).toList();
      if(fetchedPortals.isNotEmpty){
        appDataProvider.setPortalCourse(fetchedPortals);
        appDataProvider.setFilterPortalCourse(fetchedPortals);
      }else{
        appDataProvider.setPortalCourse([]);
        appDataProvider.setFilterPortalCourse([]);

      }
    } else {
      throw Exception('Failed to load portals');
    }
  } catch (e) {
    print('Error fetching portals: $e');
    AppDataProvider appDataProvider =
    Provider.of<AppDataProvider>(context, listen: false);
    appDataProvider.setPortalCourse([]);
    appDataProvider.setFilterPortalCourse([]);
  }
}