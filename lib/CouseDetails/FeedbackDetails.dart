import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../provider/provider_data.dart';
import 'package:readmore/readmore.dart';

class FeedbackCourse extends StatefulWidget {
  const FeedbackCourse({Key? key, required this.courseId});

  final int courseId;

  @override
  State<FeedbackCourse> createState() => _FeedbackCourseState();
}

class _FeedbackCourseState extends State<FeedbackCourse> {
  List<dynamic> reviewDetails = []; // Initialize with empty list

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      reviewDetails = await provider.getReviewCourseDetails(widget.courseId);
    });
  }



  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                  final review = reviewDetails[index];
                  final userId = reviewDetails[index].userId;

                  return FutureBuilder(
                    future: provider.getTrainer(userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Return a loading indicator if the data is still loading
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        // Handle error if there's any
                        return Text('Error: ${snapshot.error}');
                      } else {
                        // Extract user data from the snapshot
                        var users = snapshot.data;

                        // Check if users is not null and not empty
                        if (users != null && users.isNotEmpty) {
                          // Build your UI using the user data
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
                                        child: CachedNetworkImage(
                                          imageUrl: users,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      users.toString(), // Use empty string if user is null
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        } else {
                          // Return an empty container if users is null or empty
                          return Container();
                        }
                      }
                    },
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
