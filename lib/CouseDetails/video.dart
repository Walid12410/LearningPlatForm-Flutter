import 'package:flutter/material.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideo extends StatefulWidget {
  const YoutubeVideo({Key? key, required this.videoUrl, required this.name})
      : super(key: key);

  final String videoUrl;
  final String name;

  @override
  _YoutubeVideoState createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<YoutubeVideo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: isLandscape
          ? null
          : AppBar(
              title: Text(
                widget.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
              backgroundColor: tdbrown,
            ),
      body: Center(
        child: _controller != null
            ? YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: tdbrown,
                progressColors: const ProgressBarColors(
                  playedColor: tdbrown,
                  handleColor: tdbrown,
                ),
                onReady: () {
                  print('Player is ready.');
                },
              )
            : const CircularProgressIndicator(
                color: tdbrown,
              ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
