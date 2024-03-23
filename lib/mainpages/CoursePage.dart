import 'package:flutter/material.dart';
import 'package:learningplatformapp/Widget/ContainerDetailsPortal_Instructor.dart';
import 'package:learningplatformapp/Widget/CourseOfPortal.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';

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
      provider.getcourse(widget.portalid);
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
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFFEC9D52), Color(0xFF000000)])),
            ),
            DetailsForPortal_Instructor(name: 'Course', number: courses.length),
            Positioned(
              top: 130.0,
              left: 20.0,
              right: 20.0,
              child: Row(
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
                  const Text(
                    'Go Back',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            if (courses.isEmpty)
              const Center(
                child: Text(
                  'No Course available',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 180),
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
