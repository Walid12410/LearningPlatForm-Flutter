class ShowFirstVideo {
  String video;

  ShowFirstVideo({required this.video});

  factory ShowFirstVideo.fromJson(Map<String, dynamic> json) {
    return ShowFirstVideo(
      video: json['PartVideo'],
    );
  }
}
