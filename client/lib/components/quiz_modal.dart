import 'package:client/utils/classes.dart';
import 'package:client/utils/enums.dart';
import 'package:client/utils/helpers.dart';
import 'package:flutter/material.dart';

class QuizView extends StatefulWidget {
  final Subjects subject;

  const QuizView({super.key, required this.subject});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  List<Question> questions = [];
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    getQuestions(widget.subject).then((dynamic rawQuestions) {
      parseQuestions(rawQuestions).then((List<Question> parsedQuestions) {
        setState(() {
          questions = parsedQuestions;
        });
      });
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      } else {
        // Handle end of questions
        // For example, show a dialog or navigate to a new screen
        // when the last question is answered
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Quiz Completed'),
              content: const Text('You have completed the quiz!'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Question ${currentQuestionIndex + 1}:',
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          Text(
            questions[currentQuestionIndex].question,
            style: const TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 20.0),
          ...questions[currentQuestionIndex].options.entries.map((entry) {
            String option = entry.key;
            String optionText = entry.value;
            return RadioListTile<String>(
              title: Text(optionText),
              value: option,
              groupValue: null,
              onChanged: (String? value) {
                // Handle the user's selection, check if it's correct
                if (value == questions[currentQuestionIndex].correctOption) {
                  // Correct answer, move to the next question
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Correct!')),
                  );
                  nextQuestion();
                } else {
                  // Incorrect answer, show a message or take appropriate action
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Incorrect, try again!')),
                  );
                }
              },
            );
          }).toList(),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: nextQuestion,
            child: const Text('Next Question'),
          ),
        ],
      ),
    );
  }
}
