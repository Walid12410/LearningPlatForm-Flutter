import 'package:flutter/material.dart';


class YoutubeVideo extends StatefulWidget {
  const YoutubeVideo({super.key,required this.video, required this.name});

  final String video;
  final String name;
  @override
  State<YoutubeVideo> createState() => _YoutubeVideoState();
}

class _YoutubeVideoState extends State<YoutubeVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(widget.video),
            Text(widget.name)
          ],
        ),
      ),
    );
  }
}
