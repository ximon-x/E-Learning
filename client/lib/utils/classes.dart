class Question {
  final String question;
  final Map<String, dynamic> options;
  final String correctOption;

  Question({
    required this.question,
    required this.options,
    required this.correctOption,
  });
}
