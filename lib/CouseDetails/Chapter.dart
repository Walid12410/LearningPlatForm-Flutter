import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/Chapter.dart';
import 'package:learningplatformapp/CouseDetails/FeedbackDetails.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/pageroute/BottomAndMore.dart';
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
                      .where((lesson) => lesson.chapterID == c.id)
                      .toList();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c.title,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: tdBlue,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(c.description),
                            )
                          ],
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Lesson',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ),
                      if (chapterLessons.isNotEmpty)
                        Column(
                          children: chapterLessons.map((lesson) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          lesson.title,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Spacer(),
                                      if (lesson.mediatype == 'v')
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                CustomPageRoute2(
                                                    child: FeedbackCourse(
                                                  courseId: widget.courseid,
                                                )));
                                          },
                                          icon: const Icon(
                                            Icons.play_arrow,
                                            color: Colors.black,
                                            size: 25,
                                          ),
                                        ),
                                      if (lesson.mediatype != 'v')
                                        IconButton(
                                          onPressed: () {
                                            // Add your eye icon logic here
                                          },
                                          icon: const Icon(
                                            Icons.file_copy,
                                            color: Colors.black,
                                            size: 25,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const Divider(), // Add a divider after each row
                              ],
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
                      const Divider(
                        color: Colors.black,
                        thickness: 5,
                      ), // Divider between chapters
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
