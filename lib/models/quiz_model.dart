class Quiz {
  final String id;
  final String question;
  final List<String> options;
  final String correctAnswer;

  Quiz({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  factory Quiz.fromMap(Map<String, dynamic> data, String id) {
    return Quiz(
      id: id,
      question: data['question'],
      options: List<String>.from(data['options']),
      correctAnswer: data['correctAnswer'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
    };
  }
}
