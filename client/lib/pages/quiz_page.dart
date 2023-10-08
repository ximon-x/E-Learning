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
            title: const Text('Self Quiz'),
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
