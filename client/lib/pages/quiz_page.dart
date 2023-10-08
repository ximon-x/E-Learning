import 'package:client/utils/classes.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> questions = [];
  int selectedOptionIndex = -1;

  Widget quizModal() {
    switch (selectedOptionIndex) {
      case 0:
        return const Text('Math!');
      case 1:
        return const Text('English!');
      case 2:
        return const Text('General!');
      default:
        return const Text('History!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => setState(() {
                    selectedOptionIndex = 0;
                  }),
                  child: const Text('Math'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() {
                    selectedOptionIndex = 1;
                  }),
                  child: const Text('English'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() {
                    selectedOptionIndex = 2;
                  }),
                  child: const Text('General'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() {
                    selectedOptionIndex = 3;
                  }),
                  child: const Text('History'),
                )
              ],
            ),
            questions.isEmpty ? Container() : quizModal(),
          ],
        ));
  }
}
