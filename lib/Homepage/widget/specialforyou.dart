import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/colors/color.dart';

import '../../generated/l10n.dart';


class Specialforyou extends StatelessWidget {
  const Specialforyou({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);
  final String text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style:  TextStyle(
              fontSize: 12.sp,
              color: tdBlue,
            ),
          ),
          GestureDetector(
            onTap: press,
            child:  Text(
             S.of(context).SeeMore,
              style:TextStyle(color: tdBlue,fontSize: 12.sp),
            ),
          )
        ],
      ),
    );
  }
}
