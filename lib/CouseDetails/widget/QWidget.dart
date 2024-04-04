import 'package:flutter/material.dart';
import 'package:learningplatformapp/AllClass/Question.dart';
import 'package:learningplatformapp/AllClass/QuestionChoice.dart';
import 'package:provider/provider.dart';
import '../../provider/provider_data.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    Key? key,
    required this.question,
    required this.onClickOption,
    required this.selectedOption,
  }) : super(key: key);

  final Question question;
  final ValueChanged<questionChoice> onClickOption;
  final questionChoice? selectedOption;

  bool isOptionSelected(questionChoice option) {
    return selectedOption != null && selectedOption!.id == option.id;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppDataProvider>(context, listen: true);
    final choiceList = provider.qChoice;
    final filteredChoices = choiceList
        ?.where((choice) => choice.questionID == question.id)
        .toList() ??
        [];

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Colors.white60,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  question.question,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SingleChildScrollView(
                  child: filteredChoices.isNotEmpty
                      ? Column(
                    children: filteredChoices
                        .map((choice) => buildOption(context, choice))
                        .toList(),
                  )
                      : const Text('No choices available'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOption(BuildContext context, questionChoice option) {
    final color = getColorForOption(option);
    final bool optionSelected = isOptionSelected(option);
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: optionSelected ? null : () => onClickOption(option),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(option.answer),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getColorForOption(questionChoice option) {
    if (selectedOption != null && selectedOption!.id == option.id) {
      if (option.isCorrect == 1) {
        return Colors.green; // Correct answer selected
      } else {
        return Colors.red; // Incorrect answer selected
      }
    }
    return Colors.grey.shade200; // Default color for unselected options
  }
}
