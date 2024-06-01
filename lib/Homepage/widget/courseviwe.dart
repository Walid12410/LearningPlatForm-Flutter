import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseView extends StatelessWidget {
  const CourseView(
      {Key? key,
      required this.cname,
      required this.image,
      required this.price,
      required this.view,
      required this.press,
      required this.desc,
      required this.averageRating})
      : super(key: key);

  final String cname;
  final String image;
  final double price;
  final GestureTapCallback press;
  final int view;
  final String desc;
  final double averageRating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5,right: 5).w,
      child: Container(
        width: 170.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10).w,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  offset: const Offset(0, 0)),
            ]),
        child: GestureDetector(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Center(
                    child: Image.asset(
                      image,
                      height: 100.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        cname,
                        style:  TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                     Icon(Icons.verified, size: 15.w),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(desc,
                    style:  TextStyle(
                        fontSize: 10.sp, overflow: TextOverflow.ellipsis)),
                 SizedBox(height: 10.h),
                RatingBar.builder(
                  direction: Axis.horizontal,
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.red),
                  onRatingUpdate: (index) {},
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2).w,
                  minRating: 1,
                  itemCount: 5,
                  itemSize: 15.w,
                  initialRating: averageRating ?? 1,
                  ignoreGestures: true,
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    const Icon(Icons.remove_red_eye),
                    Text(
                      '$view',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.sp),
                    ),
                    const Spacer(),
                    Text(
                      '\$$price',
                      style:  TextStyle(
                          fontSize: 10.sp, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
