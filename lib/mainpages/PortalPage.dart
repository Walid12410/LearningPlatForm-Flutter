import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/Widget/Courseportal.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import 'package:learningplatformapp/userprofiler/widget/profilemenu.dart';
import '../generated/l10n.dart';
import 'Trainer.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';

class PortalPage extends StatefulWidget {
  const PortalPage({Key? key}) : super(key: key);

  @override
  State<PortalPage> createState() => _PortalPageState();
}

class _PortalPageState extends State<PortalPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppDataProvider provider =
          Provider.of<AppDataProvider>(context, listen: false);
      provider.getportal();
    });
  }

  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider =
        Provider.of<AppDataProvider>(context, listen: true);
    var portals = appDataProvider.portals;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: Colors.black,
                        )),
                    Text(
                      S.of(context).AllCategories,
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                ProfileMenuWidget(
                  icon: Icons.assignment_ind,
                  text: S.of(context).AllInstructor,
                  onPressed: () {
                    Navigator.push(
                        context, CustomPageRoute(child: const TrainerPage()));
                  },
                  textColor: tdBlue,
                ),
              ],
            ),
            if (portals.isEmpty)
               Center(
                child: Text(
                 S.of(context).NoCategoriesAvailable,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 120),
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
                      child: ListView.builder(
                          itemCount: portals.length,
                          itemBuilder: (context, i) {
                            return CoursePortal(portals: portals[i]);
                          })),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
