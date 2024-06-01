import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      padding: const EdgeInsets.all(3.0).w,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5).w,
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
            style:  TextStyle(color: tdBlue, fontWeight: FontWeight.bold,fontSize: 12.sp),
          ),
          subtitle: Text(
            trainers.email,
            style:  TextStyle(color: tdBlue,fontSize: 10.sp),
          ),
          trailing: TextButton.icon(
            onPressed: () {
              Navigator.push(context,
                  CustomPageRoute(child: TrainerCourse(userid: trainers.id)));
            },
            icon:  Icon(
              Icons.forward,
              color: tdBlue,
              size: 20.w,
            ),
            label: Text(
              S.of(context).AllCourses,
              style:  TextStyle(color: tdBlue,fontSize: 10.sp),
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
