// models/quiz_model.dart
class QuizModel {
  String? id;
  String title;
  List<Question> questions;

  QuizModel({
    this.id,
    required this.title,
    required this.questions,
  });

  // Convert QuizModel to a Map for Firebase storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'questions': questions.map((q) => q.toMap()).toList(),
    };
  }

  // Factory method to create QuizModel from a Map
  factory QuizModel.fromMap(Map<String, dynamic> map, String documentId) {
    return QuizModel(
      id: documentId,
      title: map['title'],
      questions: List<Question>.from(
        map['questions'].map((q) => Question.fromMap(q)),
      ),
    );
  }
}

class Question {
  String questionText;
  List<String> options;
  int correctOptionIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctOptionIndex,
  });

  // Convert Question to a Map for Firebase storage
  Map<String, dynamic> toMap() {
    return {
      'questionText': questionText,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
    };
  }

  // Factory method to create Question from a Map
  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      questionText: map['questionText'],
      options: List<String>.from(map['options']),
      correctOptionIndex: map['correctOptionIndex'],
    );
  }
}
