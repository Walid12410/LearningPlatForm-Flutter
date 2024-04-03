import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/QuestionChoice.dart';
import 'package:learningplatformapp/colors/color.dart';
import 'package:provider/provider.dart';
import '../provider/provider_data.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key, required this.chapterID}) : super(key: key);
  final int chapterID;

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int? _selectedChoiceIndex;
  List<bool> _answerResults = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      provider.getQuizQuestions(widget.chapterID);
      provider.getQuestionChoice();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: true);
    var questions = provider.question;
    var choiceList = provider.qChoice;

    return Scaffold(
      body: questions.isEmpty
          ? const Center(
        child: Text(
          'No quiz added yet for this chapter',
          style: TextStyle(
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
                const Text(
                  'Quiz',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Challenge',
                  style: TextStyle(
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
                  final filteredChoices = choiceList
                      .where((choice) => choice.questionID == question.id)
                      .toList();
                  final isCorrectAnswer = _answerResults.isNotEmpty &&
                      !_answerResults[index] &&
                      _selectedChoiceIndex == filteredChoices.firstWhere(
                            (choice) => choice.isCorrect == 1,
                        orElse: () => questionChoice(
                            id: 0,
                            qCNum: 0,
                            answer: '',
                            isCorrect: 0,
                            questionID: 0,
                            isActive: 0),
                      ).id;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isCorrectAnswer)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Correct answer: ${filteredChoices.firstWhere((choice) => choice.isCorrect == 1).answer}',
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                      Card(
                        margin:const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Padding(
                          padding:const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                question.question,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: filteredChoices.map((choice) {
                                  return RadioListTile<int>(
                                    activeColor: _answerResults.isNotEmpty && !_answerResults[index] && _selectedChoiceIndex == choice.id
                                        ? Colors.red
                                        : null,
                                    title: Text(choice.answer),
                                    value: choice.id,
                                    groupValue: _selectedChoiceIndex,
                                    onChanged: (int? value) {
                                      setState(() {
                                        _selectedChoiceIndex = value;
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _answerResults.clear();
                  for (final question in questions) {
                    final correctChoice = choiceList.firstWhere(
                          (choice) => choice.questionID == question.id && choice.isCorrect == 1,
                      orElse: () => questionChoice(id: 0, qCNum: 0, answer: '', isCorrect: 0, questionID: 0, isActive: 0),
                    );
                    _answerResults.add(_selectedChoiceIndex == correctChoice.id);
                  }
                });
              },
              child: const Text('Submit'),
            ),
            if (_answerResults.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Result: ${_answerResults.where((result) => result).length}/${_answerResults.length}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
