import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:iLearn/utils/classes.dart';
import 'package:iLearn/utils/enums.dart';

num getBestHour(List<dynamic> scores) {
  Map<int, num> hours = {};

  for (var score in scores) {
    int hour = score["timestamp"].toDate().hour;

    if (hours.containsKey(hour)) {
      hours[hour] = hours[hour]! + score["score"];
    } else {
      hours[hour] = 0;
    }
  }

  int bestHour = 0;
  int bestHourScore = 0;

  for (var hour in hours.keys) {
    if (hours[hour]! > bestHourScore) {
      bestHour = hour;
      bestHourScore = hours[hour]!.toInt();
    }
  }

  return bestHour;
}

String getBestSubject(List<dynamic> scores) {
  Map<String, num> subjects = {};

  for (var score in scores) {
    String subject = score["subject"];

    if (subjects.containsKey(subject)) {
      subjects[subject] = subjects[subject]! + score["score"];
    } else {
      subjects[subject] = 0;
    }
  }

  String bestSubject = "";
  int bestSubjectScore = 0;

  for (var subject in subjects.keys) {
    if (subjects[subject]! >= bestSubjectScore) {
      bestSubject = subject;
      bestSubjectScore = subjects[subject]!.toInt();
    }
  }

  return bestSubject;
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

Subjects? getSubject(String subject) {
  switch (subject) {
    case "math":
      return Subjects.Math;
    case "english":
      return Subjects.English;
    case "history":
      return Subjects.History;
    case "general":
      return Subjects.General;
    default:
      return null;
  }
}

num getWorstHour(List<dynamic> scores) {
  Map<int, num> hours = {};

  for (var score in scores) {
    int hour = score["timestamp"].toDate().hour;

    if (hours.containsKey(hour)) {
      hours[hour] = hours[hour]! + score[score];
    } else {
      hours[hour] = 1;
    }
  }

  int worstHour = 0;
  int worstHourScore = 0;

  for (var hour in hours.keys) {
    if (hours[hour]! <= worstHourScore) {
      worstHour = hour;
      worstHourScore = hours[hour]!.toInt();
    }
  }

  return worstHour;
}

String getWorstSubject(List<dynamic> scores) {
  Map<String, num> subjects = {};

  for (var score in scores) {
    String subject = score["subject"];

    if (subjects.containsKey(subject)) {
      subjects[subject] = subjects[subject]! + score["score"];
    } else {
      subjects[subject] = 1;
    }
  }

  num worstScore = subjects.values.first;
  List<String> worstSubjects = [];

  for (String key in subjects.keys) {
    num value = subjects[key]!;

    if (value < worstScore) {
      worstScore = value;
    }
  }

  for (var subject in subjects.keys) {
    if (subjects[subject]! == worstScore) {
      worstSubjects.add(subject);
    }
  }

  switch (worstSubjects.length) {
    case 1:
      return "Your worst subject is ${worstSubjects[0]}";
    case 2:
      return "You're currently struggling with ${worstSubjects[0]} and ${worstSubjects[1]}";
    case 3:
      return "These are your worst subjects: ${worstSubjects[0]}, ${worstSubjects[1]} and ${worstSubjects[2]}";
  }

  return "You don't have a worst subject!";
}
