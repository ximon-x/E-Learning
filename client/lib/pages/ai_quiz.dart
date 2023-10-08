// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';


// class QuizPage extends StatefulWidget {
//   const QuizPage({super.key});

//   @override
//   State<StatefulWidget> createState() => _QuizPageState();
// }

// class _QuizPageState extends State<QuizPage> {
//   Future<List<Question>> get questions async =>
//       await parseQuestions(getQuestions());

//   get startQuiz => null;


//   int currentQuestionIndex = 0;

//   void nextQuestion() {
//     setState(() {
//       if (currentQuestionIndex < questions.length - 1) {
//         currentQuestionIndex++;
//       } else {
//         // Handle end of questions
//         // For example, show a dialog or navigate to a new screen
//         // when the last question is answered
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Quiz Completed'),
//               content: const Text('You have completed the quiz!'),
//               actions: [
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     parseQuestions(getQuestions());

//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Text(
//             'Question ${currentQuestionIndex + 1}:',
//             style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10.0),
//           Text(
//             questions[currentQuestionIndex].question,
//             style: const TextStyle(fontSize: 20.0),
//           ),
//           const SizedBox(height: 20.0),
//           ...questions[currentQuestionIndex].options.entries.map((entry) {
//             String option = entry.key;
//             String optionText = entry.value;
//             return RadioListTile<String>(
//               title: Text(optionText),
//               value: option,
//               groupValue: null,
//               onChanged: (String? value) {
//                 // Handle the user's selection, check if it's correct
//                 if (value == questions[currentQuestionIndex].correctOption) {
//                   // Correct answer, move to the next question
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Correct!')),
//                   );
//                   nextQuestion();
//                 } else {
//                   // Incorrect answer, show a message or take appropriate action
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Incorrect, try again!')),
//                   );
//                 }
//               },
//             );
//           }).toList(),
//           const SizedBox(height: 20.0),
//           ElevatedButton(
//             onPressed: nextQuestion,
//             child: const Text('Next Question'),
//           ),
//         ],
//       ),
//     );
//   }
// }
