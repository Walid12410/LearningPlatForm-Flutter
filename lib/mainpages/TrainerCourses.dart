import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon:  Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 20.w,
                    )),
                Text(
                  S.of(context).GoBack,
                  style:  TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                )
              ],
            ),
            if (coursestrainer.isEmpty)
              Center(
                child: Text(
                  S.of(context).NoCourseAvailable,
                  style:  TextStyle(fontSize: 12.sp, color: Colors.black),
                ),
              )
            else
               Expanded(
                 child: Container(
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft:const Radius.circular(15).w,
                          topRight: const Radius.circular(15).w,
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0).w,
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
