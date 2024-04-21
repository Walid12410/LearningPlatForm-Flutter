import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:learningplatformapp/mainpages/TrainerCourses.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/AllClass/trainer.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import '../generated/l10n.dart';

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
          leading: ClipOval(
            child: trainers.picture == ''
                ? Image.asset('assets/user.png', fit: BoxFit.cover)
                : CachedNetworkImage(
                    imageUrl: trainers.picture,
                    placeholder: (context, url) =>
                        Image.asset('assets/gif-unscreen.gif',
                          fit: BoxFit.cover,),
              errorWidget: (context, url, error) =>
                        Image.asset('assets/user.png', fit: BoxFit.cover),
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover, // Adjust fit as needed
                  ),
          ),
          title: Text(
            '$trainers',
            style: const TextStyle(color: tdBlue, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            trainers.email,
            style: const TextStyle(color: tdBlue),
          ),
          trailing: TextButton.icon(
            onPressed: () {
              Navigator.push(context,
                  CustomPageRoute(child: TrainerCourse(userid: trainers.id)));
            },
            icon: const Icon(
              Icons.forward,
              color: tdBlue,
            ),
            label: Text(
              S.of(context).AllCourses,
              style: const TextStyle(color: tdBlue),
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
