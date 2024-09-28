// services/quiz_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_school_application/models/quiz_model.dart';

class QuizService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Quiz>> fetchQuizzes() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('quizzes').get();
      return snapshot.docs.map((doc) {
        return Quiz.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Error fetching quizzes: $e');
    }
  }

  Future<void> addQuiz(Quiz quiz) async {
    try {
      await _firestore.collection('quizzes').add(quiz.toMap());
    } catch (e) {
      throw Exception('Error adding quiz: $e');
    }
  }
}
