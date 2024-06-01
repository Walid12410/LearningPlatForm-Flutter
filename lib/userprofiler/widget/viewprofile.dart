import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import 'package:learningplatformapp/userprofiler/editprofile.dart';


class Profileview extends StatelessWidget {
  const Profileview({
    super.key,
    required this.title,
    required this.desc,
  });

  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8).w,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10).w,
            color: tdBGColor
        ),
        child: ListTile(
          title: Text(
            title,
            style:  TextStyle(color: tdBlue, fontWeight: FontWeight.bold,fontSize: 12.sp),
          ),
          subtitle: Text(
            desc,
            style:  TextStyle(color: tdBlue,fontSize: 10.sp),
          ),
          trailing: IconButton(
            icon:  Icon(Icons.edit,size: 20.w,),
            onPressed: () {
              Navigator.push(context,
                  CustomPageRoute(child: const UpdateProfileScreen()));
            },
          ),
        ),
      ),
    );
  }
}
