import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/Widget/CourseOfPortal.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';

import '../generated/l10n.dart';

class CourseListView extends StatefulWidget {
  final int portalid;
  CourseListView({Key? key, required this.portalid}) : super(key: key);

  @override
  State<CourseListView> createState() => _CourseListViewState();
}

class _CourseListViewState extends State<CourseListView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppDataProvider provider =
      Provider.of<AppDataProvider>(context, listen: false);
      provider.getCoursePortal(widget.portalid);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider =
    Provider.of<AppDataProvider>(context, listen: true);
    var courses = appDataProvider.courses;

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
                  S.of(context).GoBack,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: Colors.black),
                )
              ],
            ),
            if (courses.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    S.of(context).NoCourseAvailable,
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
                      topLeft: const Radius.circular(15).w,
                      topRight:const Radius.circular(15).w,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0).w,
                    child: ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, i) {
                        return Courseofportal(course: courses[i]);
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
