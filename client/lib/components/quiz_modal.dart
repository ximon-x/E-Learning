import 'package:client/utils/classes.dart';
import 'package:client/utils/enums.dart';
import 'package:client/utils/helpers.dart';
import 'package:flutter/material.dart';

class QuizView extends StatefulWidget {
  final Subjects subject;

  void handleReset() {}
  void handleSubmit() {}

  const QuizView({super.key, required this.subject});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  late List<Question> questions = [];
  late List<int> selectedOptions = [];
  int currentQuestionIndex = 0;

  @override
  void initState() {
    getQuestions(widget.subject).then((res) => setState(() {
          questions = res;
          selectedOptions = List<int>.filled(questions.length, -1);
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        return Card(
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: ListTile(
                leading: Text("${index + 1}"),
                title: Text(
                  questions[index].question,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: ListView.builder(
                  shrinkWrap: true,
                  itemCount: questions[index].options.length,
                  itemBuilder: (context, optionIndex) {
                    return RadioListTile(
                      title: Text(
                          "${questions[index].options[getOption(optionIndex)]}"),
                      value: optionIndex,
                      groupValue: selectedOptions[index],
                      onChanged: (value) {
                        setState(() {
                          selectedOptions[index] = value as int;
                        });
                      },
                    );
                  },
                )));
      },
    );
    //   Row(
    //     children: [
    //       ElevatedButton(
    //         onPressed: handleSubmit,
    //         child: const Text("Submit"),
    //       ),
    //       ElevatedButton(
    //         onPressed: handleReset,
    //         child: const Text("Reset"),
    //       ),
    //     ],
    //   )
    // ]);
  }
}
