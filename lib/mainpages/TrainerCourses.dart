import 'package:flutter/material.dart';
import 'package:learningplatformapp/Widget/CourseOfTrainer.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';

class TrainerCourse extends StatefulWidget {
  int userid;
  TrainerCourse({super.key, required this.userid});

  @override
  State<TrainerCourse> createState() => _TrainerCourseState();
}

class _TrainerCourseState extends State<TrainerCourse> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppDataProvider provider =
          Provider.of<AppDataProvider>(context, listen: false);
      provider.getcoursetrainer(widget.userid);
    });
  }

  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider =
        Provider.of<AppDataProvider>(context, listen: true);
    var coursestrainer = appDataProvider.coursestrainer;

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
                      color: Colors.black,
                      size: 25,
                    )),
                Text(
                  S.of(context).GoBack,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
            ),
            if (coursestrainer.isEmpty)
              Center(
                child: Text(
                  S.of(context).NoCourseAvailable,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(top: 50),
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
                      itemCount: coursestrainer.length,
                      itemBuilder: (context, i) {
                        return CourseOfTrainer(courses: coursestrainer[i]);
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
