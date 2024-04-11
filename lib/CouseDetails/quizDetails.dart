import 'package:flutter/material.dart';
import 'package:learningplatformapp/CouseDetails/QuizPage.dart';
import 'package:learningplatformapp/pageroute/LeftToRight.dart';
import 'package:provider/provider.dart';
import '../provider/provider_data.dart';

class Quizzes extends StatefulWidget {
  const Quizzes({Key? key, required this.courseId,required this.isStudent}) : super(key: key);
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
          ? const Center(
              child: Text(
                'No Quiz Available ',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: chapter.length,
                  itemBuilder: (context, i) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chapter[i].title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.quiz,
                                color: Colors.black,
                                size: 33,
                              ),
                              const Text(
                                'Quiz',
                                style: TextStyle(fontSize: 20),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: widget.isStudent ? () {
                                    Navigator.push(
                                        context,
                                        CustomPageRoute(
                                            child: QuizPage(
                                                chapterID: chapter[i].id)));
                                  } : null,
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                    size: 33,
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
