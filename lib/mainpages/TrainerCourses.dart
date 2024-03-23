import 'package:flutter/material.dart';
import 'package:learningplatformapp/Widget/CourseOfTrainer.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';

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
      AppDataProvider provider = Provider.of<AppDataProvider>(context, listen: false);
      provider.getcoursetrainer(widget.userid);
    });
  }




  @override
  Widget build(BuildContext context) {
    AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context, listen: true);
    var coursestrainer = appDataProvider.coursestrainer;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFFEC9D52),
                        Color(0xFF000000)])),
            ),
              Row(
                children: [
                  IconButton(onPressed: (){
                      Navigator.pop(context);
                  }, icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.black,size: 25,)),
                  const Text('Go Back',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
                  color: Colors.black),)
                ],
              ),
              if(coursestrainer.isEmpty)
                const Center(
                  child: Text('No Course Found',style: TextStyle(
                    fontSize: 18,color: Colors.black
                  ),),
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
