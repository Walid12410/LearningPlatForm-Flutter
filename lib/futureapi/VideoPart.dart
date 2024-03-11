import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learningplatformapp/AllClass/ShowFirstVideo.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import 'package:provider/provider.dart';

Future<void> fetchVideo(int courseId,context) async {
  AppDataProvider appDataProvider = Provider.of<AppDataProvider>(context, listen: false);
  final url = 'http://192.168.1.13/EduPlatForm/CMS/api/part.php';
  try {
    final response = await http.post(
      Uri.parse(url),
      body: {
        'operation': 'VideoShow',
        'CourseID': courseId.toString(), // Convert courseId to String
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body) as List;
      final List<ShowFirstVideo> videoList = data.map((videoJson) => ShowFirstVideo.fromJson(videoJson)).toList();
      if(appDataProvider.firstvideo.isEmpty){
        appDataProvider.setFirstVideo(videoList);
        print(videoList);
      }
    } else {
      throw Exception('Failed to load videos');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
