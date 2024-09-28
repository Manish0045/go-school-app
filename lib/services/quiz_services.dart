// services/quiz_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/quiz_model.dart';

class QuizServices {
  final CollectionReference quizCollection =
      FirebaseFirestore.instance.collection('quizzes');

  // Create a new quiz
  Future<void> createQuiz(QuizModel quiz) async {
    await quizCollection.add(quiz.toMap());
  }

  // Get quizzes
  Stream<List<QuizModel>> getQuizzes() {
    return quizCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return QuizModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
