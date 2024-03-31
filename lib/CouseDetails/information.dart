import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:learningplatformapp/futureapi/RatingCourses.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';

class CourseInformation extends StatefulWidget {
  const CourseInformation({required this.courseid});

  final int courseid;

  @override
  State<CourseInformation> createState() => _CourseInformationState();
}

class _CourseInformationState extends State<CourseInformation> {
  double? _averageRating;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      provider.fetchCourseByID(widget.courseid);
      provider.getCourseTine(widget.courseid);
      provider.getPartNumber(widget.courseid);
      provider.getTrainerCourseShow(widget.courseid);
    });
    loadData(context);
  }

  void loadData(context)  {
    try {
      fetchAverageRating(widget.courseid).then((value) {
        if (mounted) {
          setState(() {
            _averageRating = value;
          });
        }
      });

    } catch (error) {
      print('Error: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AppDataProvider>(
          builder: (context, provider, child) {
            var TotalCoureTime = provider.courseTime;
            var data = provider.data;
            var partNumbers = provider.partNumber;
            var courses = provider.CourseByID;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      child: Image.asset('assets/image1.png',fit: BoxFit.cover,),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Row(
                        children: [
                          if (data.isNotEmpty)
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                Border.all(color: Colors.black, width: 2),
                              ),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: data[0].profilePicture,
                                  placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                    color: tdbrown,
                                  ),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          const SizedBox(
                            width: 2,
                          ),
                          if (data.isNotEmpty)
                            Text(
                              data[0].toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          const Spacer(),
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
                            initialRating: _averageRating ?? 1,
                            ignoreGestures: true,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, top: 4),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(Icons.access_time_outlined),
                              const SizedBox(width: 3),
                              if (TotalCoureTime.isNotEmpty && mounted)
                                Text(
                                  '${TotalCoureTime[0].getTotalHours()} Hours (${partNumbers.length} Lessons)',
                                )
                            ],
                          ),
                          const Row(
                            children: [
                              Icon(Icons.school),
                              SizedBox(width: 3),
                              Text('Certification Available'),
                            ],
                          ),
                          const Row(
                            children: [
                              Icon(Icons.language),
                              SizedBox(width: 3),
                              Text('Arabic'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'About The Course',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (courses.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                '${courses[0].title}.${courses[0].description}'),
                          ],
                        ),
                      )
                    else
                      const Center(
                        child: Text(
                          "No Details Yet",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}