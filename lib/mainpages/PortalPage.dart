import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20.w,
                      color: Colors.black,
                    )),
                Text(
                  S.of(context).AllCategories,
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
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
            if (portals.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    S.of(context).NoCategoriesAvailable,
                    style: TextStyle(fontSize: 12.sp, color: Colors.black),
                  ),
                ),
              )
            else
              Expanded(
                child: Container(
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(10).w,
                          topRight: const Radius.circular(10).w,
                        )),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(5).w,
                      itemCount: portals.length,
                      itemBuilder: (context, i) {
                        return CoursePortal(portals: portals[i]);
                      },
                    ),
                  ),

              ),
          ],
        ),
      ),
    );
  }
}
