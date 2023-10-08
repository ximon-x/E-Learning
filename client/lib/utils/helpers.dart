import 'dart:convert';

import 'package:client/utils/classes.dart';
import 'package:client/utils/enums.dart';
import 'package:flutter/services.dart';

Future<List<Question>> getQuestions(Subjects subject) async {
  String key = subject.toString().split(".")[1];

  final String response =
      await rootBundle.loadString("assets/mocks/questions.json");

  final rawQuestions = await json.decode(response);

  dynamic questions = List<Question>.from(rawQuestions[key]
      .map((element) => Question(
            question: element['question'],
            options: element['options'],
            correctOption: element['correct_option'],
          ))
      .toList());

  return questions;
}

String getOption(int index) {
  switch (index) {
    case 0:
      return "A";
    case 1:
      return "B";
    case 2:
      return "C";
    case 3:
      return "D";
    default:
      throw Exception("Invalid option index");
  }
}
