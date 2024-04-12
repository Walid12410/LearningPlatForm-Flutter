import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/Question.dart';
import 'package:learningplatformapp/AllClass/QuestionChoice.dart';
import 'package:learningplatformapp/CouseDetails/ResultOfQuiz.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:provider/provider.dart';
import '../generated/l10n.dart';
import '../provider/provider_data.dart';
import 'widget/QWidget.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key, required this.chapterID}) : super(key: key);
  final int chapterID;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late List<Question> questions;
  Map<int, questionChoice?> selectedOptions = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      provider.getQuizQuestions(widget.chapterID);
      provider.getQuestionChoice();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: true);
    questions = provider.question;

    return Scaffold(
      body: questions.isEmpty
          ?  Center(
              child: Text(
                S.of(context).NoQuizAddYet,
                style:const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                       Text(
                        S.of(context).quiz,
                        style:const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                       Text(
                        S.of(context).challenge,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: tdbrown,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: questions.length,
                      itemBuilder: (context, index) {
                        final question = questions[index];
                        return QuestionWidget(
                          question: question,
                          onClickOption: (option) {
                            if (!selectedOptions.containsKey(question.id)) {
                              setState(() {
                                selectedOptions[question.id] = option;
                              });
                            }
                          },
                          selectedOption: selectedOptions[question.id],
                        );
                      },
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: canSubmit() ? submitQuiz : null,
                    icon: const Icon(
                      Icons.calculate_rounded,
                      color: Colors.black,
                    ),
                    label:  Text(
                      S.of(context).SubmitQuiz,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: tdbrown, // Change the background color here
                      minimumSize: const Size(
                          150, 40), // Set the minimum width and height
                    ),
                  )
                ],
              ),
            ),
    );
  }

  bool canSubmit() {
    for (final question in questions) {
      if (!selectedOptions.containsKey(question.id)) {
        return false;
      }
    }
    return true;
  }

  void submitQuiz() {
    int correctAnswers = 0;
    int totalQuestions = questions.length;
    for (final question in questions) {
      final selectedOption = selectedOptions[question.id];
      if (selectedOption != null && selectedOption.isCorrect == 1) {
        correctAnswers++;
      }
    }
    double score = (correctAnswers / totalQuestions) * 100;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ResultQuiz(
                  score: score,
                )
        )
    );
  }
}
