import 'package:flutter/material.dart';
import 'package:learningplatformapp/mainpages/TrainerCourses.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';

class TrainerInfo extends StatelessWidget {
  const TrainerInfo({
    Key? key,
    required this.trainers,
  }) : super(key: key);

  final Trainer trainers;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: tdbrown,
        ),
        child: ListTile(
          leading:  CircleAvatar(
            backgroundImage: NetworkImage(trainers.tpicture),
            radius: 25,
          ),
          title: Text(
            '$trainers',
            style: const TextStyle(color: tdBlue, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${trainers.email}',
            style: const TextStyle(color: tdBlue),
          ),
          trailing: TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                CustomPageRoute(child: TrainerCourse(userid: trainers.id))
              );
            },
            icon: const Icon(
              Icons.forward,
              color: tdBlue,
            ),
            label: const Text(
              'All Courses', // Your button label text here
              style: TextStyle(color: tdBlue),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
