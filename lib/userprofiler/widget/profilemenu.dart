import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/colors/color.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.textColor,
    this.endIcon = true,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Color textColor;
  final bool endIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Container(
        width: 30.w,
        height: 30.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: tdBGColor,
        ),
        child: Icon(
          icon,
          color: tdBlue,
        ),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 15.sp,
        ),
      ),
      trailing: endIcon
          ? Container(
              width: 20.w,
              height: 20.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100).w,
                color: tdBGColor,
              ),
              child:  Icon(
                Icons.arrow_forward_ios,
                size: 15.w,
                color: tdBlue,
              ),
            )
          : null,
    );
  }
}
