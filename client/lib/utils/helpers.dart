import 'dart:convert';

import 'package:client/utils/classes.dart';
import 'package:client/utils/enums.dart';
import 'package:flutter/services.dart';

Future<dynamic> getQuestions(Subjects subject) async {
  final String response =
      await rootBundle.loadString("assets/mocks/questions.json");
  final rawQuestions = await json.decode(response);
  return rawQuestions[subject.toString()];
}

Future<List<Question>> parseQuestions(dynamic rawQuestions) async {
  return List<Question>.from(rawQuestions.map((element) {
    return Question(
      question: element['question'],
      options: element['options'],
      correctOption: element['correct_option'],
    );
  }).toList());
}
