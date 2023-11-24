import 'package:iLearn/utils/classes.dart';
import 'package:iLearn/utils/enums.dart';
import 'package:iLearn/utils/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QuizView extends StatefulWidget {
  final Subjects subject;

  const QuizView({super.key, required this.subject});

  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  final db = FirebaseFirestore.instance;

  late List<Question> questions = [];
  late List<int> selectedOptions = [];
  int currentQuestionIndex = 0;

  void handleReset() {
    questions = [];
    selectedOptions = [];
  }

  Future handleSubmit() async {
    for (int i = 0; i < questions.length; i++) {
      if (selectedOptions[i] == -1) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("Please answer all the questions before submitting")));
        return;
      }
    }

    int correctAnswers = 0;

    for (int i = 0; i < questions.length; i++) {
      if (questions[i].correctOption == getOption(selectedOptions[i])) {
        correctAnswers++;
      }
    }

    final score = <String, dynamic>{
      "user": FirebaseAuth.instance.currentUser!.uid,
      "subject": widget.subject.toString().split(".")[1],
      "score": correctAnswers,
      "total": questions.length,
      "timestamp": DateTime.now()
    };

    db
        .collection("scores")
        .add(score)
        .then((value) => print('DocumentSnapshot Added with ID: ${value.id}'))
        .catchError((error) => print('Failed to add document: $error'));

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Quiz Results"),
            content: Text(
                "You answered $correctAnswers out of ${questions.length} questions correctly"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Close"))
            ],
          );
        });
  }

  @override
  void initState() {
    getQuestions(widget.subject).then((res) => setState(() {
          res.shuffle();
          questions = res.sublist(0, 10);
          selectedOptions = List<int>.filled(questions.length, -1);
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          child: ListView.builder(
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
                      })));
        },
      )),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
          ElevatedButton(
            onPressed: handleSubmit,
            child: const Text("Submit"),
          ),
          // ElevatedButton(
          //   onPressed: handleReset,
          //   child: const Text("Reset"),
          // ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
        ],
      )
    ]);
  }
}
