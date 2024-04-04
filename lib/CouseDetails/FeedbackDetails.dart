import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../provider/provider_data.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackCourse extends StatefulWidget {
  const FeedbackCourse({Key? key, required this.courseId});

  final int courseId;

  @override
  State<FeedbackCourse> createState() => _FeedbackCourseState();
}

class _FeedbackCourseState extends State<FeedbackCourse> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppDataProvider provider =
          Provider.of<AppDataProvider>(context, listen: false);
      provider.getReviewCourseDetails(widget.courseId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: true);
    var reviewDetails = provider.courseReview;

    return Scaffold(
      body: SafeArea(
        child: reviewDetails.isEmpty
            ? const Center(
                child: Text(
                  'no feedback for this course',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          'Rating & Review',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Unlock the potential of collaborative learning by contributing your unique insights and experiences to Course Review. Join our vibrant community in shaping the future of online education, one review at a time.',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: reviewDetails.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: reviewDetails != null
                                          ? CachedNetworkImage(
                                              imageUrl:
                                                  reviewDetails[index].photo,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                        'assets/user.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                              fit: BoxFit.cover,
                                            )
                                          : Container(), // Use Container if user is null
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    reviewDetails[index]
                                        .toString(), // Use empty string if user is null
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const Spacer(),
                                  RatingBar.builder(
                                    direction: Axis.horizontal,
                                    itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.red),
                                    onRatingUpdate: (index) {},
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    minRating: 1,
                                    itemCount: 5,
                                    itemSize: 18,
                                    initialRating:
                                        reviewDetails[index].rating.toDouble(),
                                    ignoreGestures: true,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: ReadMoreText(
                                  reviewDetails[index].comment,
                                  trimLines: 3,
                                  trimMode: TrimMode.Line,
                                  trimExpandedText: 'show less',
                                  trimCollapsedText: 'show more',
                                  moreStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueAccent,
                                  ),
                                  lessStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                              const Divider(color: Colors.black)
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
