import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/AllClass/Chapter.dart';
import 'package:learningplatformapp/CouseDetails/PdfViewer.dart';
import 'package:learningplatformapp/CouseDetails/video.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:learningplatformapp/pageroute/BottomAndMore.dart';
import 'package:provider/provider.dart';
import 'package:learningplatformapp/provider/provider_data.dart';
import '../AllClass/Lesson.dart';
import '../generated/l10n.dart';

class chapterPage extends StatelessWidget {
  const chapterPage({Key? key, required this.courseid, required this.isStudent})
      : super(key: key);
  final int courseid;
  final bool isStudent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Consumer<AppDataProvider>(
            builder: (context, provider, _) {
              List<Chapter> chapters = provider.allchapter;
              List<Lesson> lessons = provider.lesson;
              if (chapters.isEmpty) {
                return Center(
                  child: Text(
                    S.of(context).NoChapterAvailable,
                    style: TextStyle(fontSize: 12.sp),
                  ),
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
                          padding: const EdgeInsets.all(5).w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                c.title,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  color: tdBlue,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0).w,
                                child: Text(
                                  c.description,
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                              )
                            ],
                          ),
                        ),
                        Center(
                          child: Text(
                            S.of(context).Lesson,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.sp),
                          ),
                        ),
                        if (chapterLessons.isNotEmpty)
                          Column(
                            children: chapterLessons.map((lesson) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0)
                                        .w,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            lesson.title,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const Spacer(),
                                        if (lesson.mediatype == 'v')
                                          GestureDetector(
                                            onTap: isStudent
                                                ? () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                YoutubeVideo(
                                                                    videoUrl: lesson
                                                                        .mobilelink,
                                                                    name: lesson
                                                                        .title)));
                                                  }
                                                : null,
                                            child: Icon(
                                              Icons.play_arrow,
                                              color: Colors.black,
                                              size: 20.w,
                                            ),
                                          ),
                                        if (lesson.mediatype != 'v')
                                          GestureDetector(
                                            onTap: isStudent
                                                ? () {
                                                    Navigator.push(
                                                        context,
                                                        CustomPageRoute2(
                                                            child: PdfViewer(
                                                          pdfUrl:
                                                              lesson.filepath,
                                                          title: lesson.title,
                                                        )));
                                                  }
                                                : null,
                                            child: Icon(
                                              Icons.file_copy,
                                              color: Colors.black,
                                              size: 20.w,
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
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0).w,
                            child: Text(
                              S.of(context).NoLessonOfChapter,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 12.sp),
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
      ],
    );
  }
}
