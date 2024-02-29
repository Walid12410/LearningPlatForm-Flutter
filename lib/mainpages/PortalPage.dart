import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/portal.dart';
import 'package:learningplatformapp/Widget/ContainerDetailsPortal_Instructor.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/Widget/Courseportal.dart';
import 'package:learningplatformapp/futureapi/PortalApi.dart';
import 'package:learningplatformapp/userprofiler/widget/profilemenu.dart';
import 'Trainer.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';

class PortalPage extends StatefulWidget {
  const PortalPage({super.key});

  @override
  State<PortalPage> createState() => _PortalPageState();
}

class _PortalPageState extends State<PortalPage> {

  @override
  void initState() {
    super.initState();
  }


  void getData(context){
    getPortals(context).then((_) {
      if (_searchText.isNotEmpty) {
        filterPortals(context, _searchText);
      }
    });
  }


  void filterPortals(BuildContext context, String searchText) {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
    List<Portal> portal = appDataProvider.portals;
    List<Portal> filteredPortal = portal
    .where((portal) => portal.portalName.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    appDataProvider.setFilterPortalCourse(filteredPortal);
  }
  String _searchText = ''; // Store the entered search text


  double calculateMaxCrossAxisExtent(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 720 ? 310 : 200;
  }

  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context, listen: true);
    getData(context);
    var portals = appDataProvider.portals;
    var filteredPortals = appDataProvider.filteredPortals;

    return Scaffold(
      body: SafeArea(
        child: Stack(
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
            Positioned(
              top: 130,
              left: 20,
              right: 20,
              child: ProfileMenuWidget(icon: Icons.assignment_ind, text: 'All Instructor', onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const TrainerPage()));
              }, textColor: tdBlue),
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
                    filterPortals(context,value);
                  },
                ),
              ),
            ),
            // if (_isLoading)
            //   const Center(
            //     child: SizedBox(
            //       width: 150,
            //       height: 150,
            //       child: CircularProgressIndicator(
            //         color: tdbrown,
            //       ),
            //     ),
            //   )
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
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  height: double.infinity,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent:
                                calculateMaxCrossAxisExtent(context),
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
      ),
    );
  }
}
