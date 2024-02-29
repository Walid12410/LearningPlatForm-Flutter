import 'package:learningplatformapp/AllClass/course.dart';
import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {},
        child: SizedBox(
          width: 250, // Adjust as needed
          child: Card(
            color: Colors.white,
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/image1.png',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.name,
                    style: const TextStyle(
                      fontSize: 22,
                      color: tdBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    course.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: tdBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RatingBar.builder(
                    direction: Axis.horizontal,
                    itemBuilder: (context,_) => const Icon(Icons.star,
                      color: Colors.red,),
                    onRatingUpdate: (index){},
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                    minRating: 1,
                    itemCount: 5,
                    itemSize: 18,
                    initialRating: 1,
                    ignoreGestures: true, // Set this to true to disable user interaction
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${course.price}', // Replace with actual price data
                        style: const TextStyle(
                          fontSize: 14,
                          color: tdBlue,
                        ),
                      ),
                      const Icon(Icons.bookmark_border,size: 30,)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
