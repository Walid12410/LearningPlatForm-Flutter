import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/Chapter.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import '../AllClass/Lesson.dart';

class Chapterpage extends StatefulWidget {
  const Chapterpage({Key? key, required this.courseid}) : super(key: key);
  final int courseid;

  @override
  State<Chapterpage> createState() => _ChapterpageState();
}

class _ChapterpageState extends State<Chapterpage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        final provider = Provider.of<AppDataProvider>(context, listen: false);
        provider.getChapterByID(widget.courseid);
        provider.getLessonById(widget.courseid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<AppDataProvider>(
          builder: (context, provider, _) {
            List<Chapter> chapters = provider.allchapter;
            List<Lesson> lessons = provider.lesson;
            if (chapters.isEmpty) {
              return const Center(
                child: Text('No chapters available'),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: chapters.map((c) {
                  List<Lesson> chapterLessons = lessons
                      .where((lesson) => lesson.chpaterID == c.id)
                      .toList();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          c.title,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: tdBlue,
                          ),
                        ),
                      ),
                      if (chapterLessons.isNotEmpty)
                        Column(
                          children: chapterLessons.map((lesson) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: ListTile(
                                title: Text(lesson.name),
                                // You can add more details about the lesson here if needed
                              ),
                            );
                          }).toList(),
                        )
                      else
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'No lessons available for this chapter',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      const Divider(), // Divider between chapters
                    ],
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
