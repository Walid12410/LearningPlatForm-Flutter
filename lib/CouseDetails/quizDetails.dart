import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learningplatformapp/CouseDetails/QuizPage.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';
import '../provider/provider_data.dart';

class Quizzes extends StatefulWidget {
  const Quizzes({Key? key, required this.courseId, required this.isStudent})
      : super(key: key);
  final int courseId;
  final bool isStudent;

  @override
  State<Quizzes> createState() => _QuizzesState();
}

class _QuizzesState extends State<Quizzes> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      provider.getChapterByID(widget.courseId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: true);
    var chapter = provider.allchapter;

    return Scaffold(
      body: chapter.isEmpty
          ? Center(
              child: Text(
                S.of(context).NoQuizAvailable,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(5.0).w,
                child: ListView.builder(
                  itemCount: chapter.length,
                  itemBuilder: (context, i) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chapter[i].title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5).w,
                          child: Row(
                            children: [
                              Icon(
                                Icons.quiz,
                                color: Colors.black,
                                size: 25.w,
                              ),
                              Text(
                                S.of(context).quiz,
                                style: TextStyle(fontSize: 15.sp),
                              ),
                              const Spacer(),
                              GestureDetector(
                                  onTap: widget.isStudent
                                      ? () {
                                          Navigator.push(
                                              context,
                                              CustomPageRoute(
                                                  child: QuizPage(
                                                      chapterID:
                                                          chapter[i].id)));
                                        }
                                      : null,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                    size: 25.w,
                                  ))
                            ],
                          ),
                        ),
                        const Divider(thickness: 5, color: Colors.black)
                      ],
                    );
                  },
                ),
              ),
            ),
    );
  }
}
