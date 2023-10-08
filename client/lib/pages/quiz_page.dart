import 'package:client/components/quiz_modal.dart';
import 'package:client/utils/classes.dart';
import 'package:client/utils/enums.dart';
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
      case 3:
        return const Text('History!');
    }

    return const Text('No quiz selected');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: "Math"),
                Tab(text: "English"),
                Tab(text: "General"),
                Tab(text: "History"),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [
              QuizView(subject: Subjects.mathQuestions),
              QuizView(subject: Subjects.englishQuestions),
              QuizView(subject: Subjects.generalQuestions),
              QuizView(subject: Subjects.historyQuestions),
            ],
          )),
    );
  }
}
