import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class CourseView extends StatelessWidget {
  const CourseView({
    Key? key,
    required this.cname,
    required this.image,
    required this.price,
    required this.view,
    required this.press,
    required this.desc,
    required this.averageRating
  }) : super(key: key);

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
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        width: 200,
        height: 265,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 10,
              offset: Offset(0, 3)
            ),
          ]
        ),
        child: GestureDetector(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                 // alignment: Alignment.center,
                  child: Image.asset(image,height: 150,),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        cname,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const Icon(Icons.verified, size: 20),
                  ],
                ),
                Text(desc,
                  style:const TextStyle(fontSize: 15,overflow: TextOverflow.ellipsis)
                  ),
                const SizedBox(height: 2),
                RatingBar.builder(
                  direction: Axis.horizontal,
                  itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.red),
                  onRatingUpdate: (index) {},
                  itemPadding:
                  const EdgeInsets.symmetric(horizontal: 4),
                  minRating: 1,
                  itemCount: 5,
                  itemSize: 18,
                  initialRating: averageRating ?? 1,
                  ignoreGestures: true,
                ),
                const SizedBox(height: 1),
                Row(
                  children: [
                    const Icon(Icons.remove_red_eye),
                    Text('$view',style:const TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 15),),
                    const Spacer(),
                    Text('\$$price',
                      style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
