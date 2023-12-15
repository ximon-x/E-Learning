import 'package:flutter/material.dart';
import 'package:iLearn/components/quiz_modal.dart';
import 'package:iLearn/utils/classes.dart';
import 'package:iLearn/utils/enums.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Subjects? selectedSubject;
  Difficulty? selectedDifficulty;

  bool started = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Self Quiz"),
          ),
          body: Center(
              child: !started
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Select a subject and difficulty to start"),
                        const SizedBox(height: 20),
                        DropdownButton<Subjects>(
                          value: selectedSubject,
                          hint: const Text("Select a subject"),
                          onChanged: (Subjects? value) {
                            setState(() {
                              selectedSubject = value!;
                            });
                          },
                          items: Subjects.values.map((Subjects subject) {
                            return DropdownMenuItem<Subjects>(
                              value: subject,
                              child: Text(subject.toString().split(".")[1]),
                            );
                          }).toList(),
                        ),
                        DropdownButton<Difficulty>(
                          value: selectedDifficulty,
                          hint: const Text("Select a difficulty"),
                          onChanged: (Difficulty? value) {
                            setState(() {
                              selectedDifficulty = value!;
                            });
                          },
                          items: Difficulty.values.map((Difficulty difficulty) {
                            return DropdownMenuItem<Difficulty>(
                              value: difficulty,
                              child: Text(difficulty.toString().split(".")[1]),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              started = true;
                            });
                          },
                          child: const Text("Start Quiz"),
                        ),
                      ],
                    )
                  : QuizView(
                      subject: selectedSubject!,
                      difficulty: selectedDifficulty!))),
    );
  }
}
