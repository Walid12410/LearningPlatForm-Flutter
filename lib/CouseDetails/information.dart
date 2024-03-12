import 'package:flutter/material.dart';
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
  late YoutubePlayerController _controller; // Initialize with empty controller
  double? _averageRating;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: '', // Empty video ID
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    if (widget.fvideo.isNotEmpty) {
      final videoID = YoutubePlayer.convertUrlToId(widget.fvideo);
      if (videoID != null) {
        setState(() {
          _controller = YoutubePlayerController(
            initialVideoId: videoID,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
            ),
          );
        });
      } else {
        print("Invalid video URL: ${widget.fvideo}");
      }
    }
    getData(context);
  }

  void getData(context) {
    getDataTrainerCourse(context, widget.courseid);
    fetchAverageRating(widget.courseid).then((value) {
      setState(() {
        _averageRating = value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (widget.fvideo.isNotEmpty && _controller != null)
                  YoutubePlayer(
                    controller: _controller!,
                    showVideoProgressIndicator: true,
                    bottomActions: [
                      CurrentPosition(),
                      ProgressBar(isExpanded: true),
                    ],
                  )
                else if (widget.fvideo.isNotEmpty && _controller == null)
                  const Center(
                    child:
                        CircularProgressIndicator(), // or any other loading indicator
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
                            backgroundImage: NetworkImage(data[0]
                                .ProfilePicture), // Replace with your image path
                            radius: 15,
                          ),
                        ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        data[0].toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Spacer(),
                      RatingBar.builder(
                        direction: Axis.horizontal,
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.red),
                        onRatingUpdate: (index) {},
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                        minRating: 1,
                        itemCount: 5,
                        itemSize: 18,
                        initialRating:
                            _averageRating ?? 1, // Use fetched average rating
                        ignoreGestures: true,
                      ),
                    ],
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
