import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/portal.dart';
import 'package:learningplatformapp/Widget/ContainerDetailsPortal_Instructor.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/Widget/Courseportal.dart';
import 'package:learningplatformapp/futureapi/PortalApi.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import 'package:learningplatformapp/userprofiler/widget/profilemenu.dart';
import 'Trainer.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class PortalPage extends StatefulWidget {
  const PortalPage({Key? key}) : super(key: key);

  @override
  State<PortalPage> createState() => _PortalPageState();
}

class _PortalPageState extends State<PortalPage> {
  @override
  void initState() {
    super.initState();
    getData(context);
  }

  void getData(context) {
    getPortals(context).then((_) {
      if (_searchText.isNotEmpty) {
        filterPortals(context, _searchText);
      }
    });
  }

  void filterPortals(BuildContext context, String searchText) {
    AppDataProvider appDataProvider =
    Provider.of<AppDataProvider>(context, listen: false);
    List<Portal> portal = appDataProvider.portals;
    List<Portal> filteredPortal = portal
        .where((portal) =>
        portal.portalName.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    appDataProvider.setFilterPortalCourse(filteredPortal);
  }

  String _searchText = ''; // Store the entered search text

  Future<void> reloadPage() async {
    try {
      final provider =
      Provider.of<AppDataProvider>(context, listen: false);
      provider.deletePortal();
      getData(context);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider =
    Provider.of<AppDataProvider>(context, listen: true);
    getData(context);
    var portals = appDataProvider.portals;
    var filteredPortals = appDataProvider.filteredPortals;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: reloadPage,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFEC9D52),
                      Color(0xFF000000),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 130,
                left: 20,
                right: 20,
                child: ProfileMenuWidget(
                  icon: Icons.assignment_ind,
                  text: 'All Instructor',
                  onPressed: () {
                    Navigator.push(
                        context,
                        CustomPageRoute(child: const TrainerPage()));
                  },
                  textColor: tdBlue,
                ),
              ),
              DetailsForPortal_Instructor(
                  name: 'categories', number: portals.length),
              Positioned(
                top: 190,
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
                    decoration: const InputDecoration(
                      hintText: 'Search',
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: tdBlue,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                      filterPortals(context, value);
                    },
                  ),
                ),
              ),
              if (portals.isEmpty)
                const Center(
                  child: Text(
                    'No Categories available',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(top: 250),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        )),
                    height: double.infinity,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: ResponsiveGridList(
                        minItemWidth: 160,
                        children: filteredPortals.map((portal) {
                          return CoursePortal(portals: portal);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
