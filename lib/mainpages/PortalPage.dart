import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/portal.dart';
import 'package:learningplatformapp/Widget/ContainerDetailsPortal_Instructor.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/Widget/Courseportal.dart';
import 'package:learningplatformapp/userprofiler/widget/profilemenu.dart';
import 'Trainer.dart';

class PortalPage extends StatefulWidget {
  const PortalPage({super.key});

  @override
  State<PortalPage> createState() => _PortalPageState();
}

class _PortalPageState extends State<PortalPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchPortals();
  }

  @override
  void dispose() {
    // Dispose of resources like streams, controllers, or listeners here if needed
    super.dispose();
  }

  Future<void> _fetchPortals() async {
    if (!mounted) return; // Check if the widget is still mounted before updating state
    setState(() {
      _isLoading = true; // Set isLoading to true when fetching starts
    });
    try {
      await getPortals(); // Wait for getPortals to complete
    } catch (e) {
      print('Error fetching portals: $e');
    } finally {
      if (mounted) { // Check again if the widget is still mounted before updating state
        setState(() {
          _isLoading = false; // Set isLoading to false when fetching completes
        });
      }
    }
  }

  void filterPortals(String searchText) {
    setState(() {
      filteredPortals = portals
          .where((portal) => portal.portalName
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
    });
  }

  double calculateMaxCrossAxisExtent(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 720 ? 310 : 200;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
            top: 170,
            left: 20,
            right: 20,
            child: ProfileMenuWidget(icon: Icons.assignment_ind, text: 'All Instructor', onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const TrainerPage()));
            }, textColor: tdBlue),
          ),
          DetailsForPortal_Instructor(
              name: 'categories', number: portals.length),
          Positioned(
            top: 230,
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
                  filterPortals(value);
                },
              ),
            ),
          ),
          if (_isLoading)
            const Center(
              child: SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                  color: tdbrown,
                ),
              ),
            )
          else if (filteredPortals.isEmpty)
            const Center(
              child: Text(
                'No Categories available',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(top: 300),
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
    );
  }
}
