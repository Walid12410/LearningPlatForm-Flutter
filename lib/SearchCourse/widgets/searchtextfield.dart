import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/SearchCourse/Searchpage.dart';
import 'package:learningplatformapp/pageroute/BottomAndMore.dart';

import '../../generated/l10n.dart';


class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CustomPageRoute2(child: SearchPage()
          ),
        );
      },
      child: Container(
        height: 35.h,
        margin: const EdgeInsets.all(5.0).w,
        padding: const EdgeInsets.symmetric(horizontal: 12.0).w,
        decoration: BoxDecoration(
          color: tdbrown, // Use your desired color here
          borderRadius: BorderRadius.circular(7).w,
        ),
        child: Row(
          children: [
             Icon(Icons.search, color: tdBlue,size: 20.w,), // Use your desired color here
             SizedBox(width: 5.w),
            Expanded(
              child: Text(
                S.of(context).Search,
                style:  TextStyle(color: tdBlue,fontSize: 12.sp), // Use your desired color here
              ),
            ),
          ],
        ),
      ),
    );
  }
}
