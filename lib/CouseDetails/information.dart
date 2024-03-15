import 'package:flutter/material.dart';
import 'package:learningplatformapp/futureapi/CourseApi.dart';
import 'package:learningplatformapp/futureapi/LeasonCalculate.dart';
import 'package:learningplatformapp/futureapi/TotalCourseTime.dart';
import 'package:learningplatformapp/futureapi/TrainerCourseShowApi.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:learningplatformapp/futureapi/RatingCourses.dart';

class CourseInformation extends StatefulWidget {
  const CourseInformation({required this.courseid, required this.fvideo});

  final int courseid;
  final String fvideo;

  @override
  State<CourseInformation> createState() => _CourseInformationState();
}

class _CourseInformationState extends State<CourseInformation> {
  late YoutubePlayerController _controller;
  double? _averageRating;

  @override
  void initState() {
    super.initState();
    getData(context);
  }

  void getData(context) {
    getDataTrainerCourse(context, widget.courseid);
    fetchAverageRating(widget.courseid).then((value) {
      setState(() {
        _averageRating = value;
      });
    });
    TotalCourseTime(context, 1);
    fetchPartNumbers(widget.courseid);
    getCourseByID(widget.courseid, context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? videoId;
    if (widget.fvideo.isNotEmpty) {
      videoId = YoutubePlayer.convertUrlToId(widget.fvideo);
      _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (widget.fvideo.isNotEmpty && videoId != null)
                  YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    bottomActions: [
                      CurrentPosition(),
                      ProgressBar(isExpanded: true),
                    ],
                  )
                else if (widget.fvideo.isNotEmpty && videoId == null)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  const Center(
                    child: Text(
                      'No Video Yet',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Row(
                    children: [
                      if (data.isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(data[0].ProfilePicture),
                            radius: 15,
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
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4),
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
                          if (TotalCoureTime.isNotEmpty)
                            Text(
                                '${TotalCoureTime[0].getTotalHours()} Hours (${partNumbers.length} Lessons)')
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(Icons.school),
                          SizedBox(width: 3),
                          Text('Certification Available')
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(Icons.language),
                          SizedBox(width: 3),
                          Text('Arabic')
                        ],
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'About The Course',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                if (courses.isNotEmpty)
                  Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('${courses[0].name} ${courses[0].description}')
                        ],
                      ))
                else
                  const Center(
                    child: Text(
                      "No Details Yet",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
