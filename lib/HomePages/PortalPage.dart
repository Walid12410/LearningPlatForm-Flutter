import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/portal.dart';
import 'package:learningplatformapp/Widget/ContainerDetailsPortal_Instructor.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/Widget/Courseportal.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PortalPage extends StatefulWidget {
  const PortalPage({super.key});

  @override
  State<PortalPage> createState() => _PortalPageState();
}

class _PortalPageState extends State<PortalPage> {
  List<Portal> portals = [];
  List<Portal> filteredPortals = [];
  @override
  void initState() {
    super.initState();
    getPortals();
  }

  Future<void> getPortals() async {
    try {
      Uri url = Uri.parse('http://192.168.1.13/EduPlatForm/CMS/api/PortalCrudOperation.php?operation=SelectAll');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> portalJsonList = jsonDecode(response.body);
        List<Portal> fetchedPortals = portalJsonList.map((json) => Portal.fromJson(json)).toList();
        setState(() {
          filteredPortals = fetchedPortals;
          portals = fetchedPortals;
        });
      } else {
        throw Exception('Failed to load portals');
      }
    } catch (e) {
      print('Error fetching portals: $e');
      setState(() {
        portals = [];
      });
    }
  }

  void filterPortals(String searchText){
    setState(() {
      filteredPortals = portals.where((portal) => portal.portalName.toLowerCase().contains(searchText.toLowerCase())
      ).toList();
    });
  }

  double calculateMaxCrossAxisExtent(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 720 ? 310 : 200;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFEC9D52),
                    Color(0xFF004296),
                  ],
                ),
              ),
            ),
            DetailsForPortal_Instructor(name: 'categories', number: portals.length),
            Positioned(
              top: 190.0,
              left: 20.0,
              right: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: tdBGColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  cursorColor: tdbrown,
                  decoration:const InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search,color: tdBlue,),
                  ),
                  onChanged: (value){
                    filterPortals(value);
                  },
                ),
              ),
            ),
            if(portals.isEmpty)
              const Center(
                child: CircularProgressIndicator(),
              )
            else
            Padding(
                padding: const EdgeInsets.only(top: 250),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: calculateMaxCrossAxisExtent(context),
                          childAspectRatio: 3 / 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 15),
                      itemCount: filteredPortals.length,
                      itemBuilder: (context, i) {
                        final portal = filteredPortals[i];
                        return CoursePortal(portals: portal);
                      }),
                ),
              ),
            ),
          ],
        ),
    );
  }
}