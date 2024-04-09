import 'package:flutter/material.dart';
import 'package:learningplatformapp/Widget/CourseOfPortal.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';

import '../generated/l10n.dart';

class CourseListView extends StatefulWidget {
  int portalid;
  CourseListView({super.key, required this.portalid});

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
        child: Stack(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: Colors.black,
                    )),
                 Text(
                 S.of(context).GoBack,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black),
                )
              ],
            ),
            if (courses.isEmpty)
               Center(
                child: Text(
                  S.of(context).NoCourseAvailable,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
