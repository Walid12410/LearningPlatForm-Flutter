import 'package:flutter/material.dart';
import 'package:learningplatformapp/futureapi/VideoPart.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class courseinformation extends StatefulWidget {
  const courseinformation({super.key, required this.courseid});

  final int courseid;
  @override
  State<courseinformation> createState() => _courseinformationState();
}

class _courseinformationState extends State<courseinformation> {
  late List<String> video;
  late String errorMessage;

  @override
  void initState() {
    super.initState();
    getVideo();
  }

  Future<void> getVideo() async {
    try {
      List<String>? fetchvideo = await fetchVideos(widget.courseid);
      setState(() {
        if (fetchvideo != null) {
          video = fetchvideo.map((e) => e ?? '').toList(); // Convert nullable String? to non-nullable String
          print("gell $video");
          errorMessage = '';
        } else {
          video = [];
          errorMessage = 'Failed to load videos';
        }
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}