// screens/student/attend_quiz.dart
import 'package:flutter/material.dart';
import 'package:go_school_application/models/quiz_model.dart';
import 'package:go_school_application/services/quiz_services.dart';
import 'package:go_school_application/widgets/common_widgets.dart';

class AttendQuizPage extends StatefulWidget {
  const AttendQuizPage({super.key});

  @override
  State<AttendQuizPage> createState() => _AttendQuizPageState();
}

class _AttendQuizPageState extends State<AttendQuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool isQuizFinished = false;
  bool isAnswered = false;
  String? selectedOption;
  List<Quiz> selectedQuestions = [];

  final QuizService _quizService = QuizService();

  @override
  void initState() {
    super.initState();
    _loadQuizQuestions();
  }

  Future<void> _loadQuizQuestions() async {
    try {
      List<Quiz> quizzes = await _quizService.fetchQuizzes();
      setState(() {
        selectedQuestions = quizzes
          ..shuffle(); // Shuffle and use first 10 questions
        selectedQuestions = selectedQuestions.take(10).toList();
      });
    } catch (e) {
      print('Failed to load quizzes: $e');
    }
  }

  void _submitAnswer(String selectedOption) {
    setState(() {
      isAnswered = true;
      this.selectedOption = selectedOption;

      if (selectedOption ==
          selectedQuestions[currentQuestionIndex].correctAnswer) {
        score++;
      }
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < selectedQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        isAnswered = false;
        selectedOption = null;
      });
    } else {
      setState(() {
        isQuizFinished = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Attend Quiz"),
      body: selectedQuestions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : isQuizFinished
              ? _buildQuizResults()
              : _buildQuizQuestion(),
    );
  }

  Widget _buildQuizQuestion() {
    Quiz currentQuestion = selectedQuestions[currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${currentQuestionIndex + 1}/${selectedQuestions.length}',
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber),
          ),
          const SizedBox(height: 20),
          Text(
            currentQuestion.question,
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
          const SizedBox(height: 20),
          ...currentQuestion.options.map((option) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getButtonColor(option),
                ),
                onPressed: isAnswered ? null : () => _submitAnswer(option),
                child: Text(option),
              ),
            );
          }),
          const SizedBox(height: 20),
          if (isAnswered)
            ElevatedButton(
              onPressed: _nextQuestion,
              child: const Text('Next'),
            ),
        ],
      ),
    );
  }

  Color _getButtonColor(String option) {
    if (!isAnswered) {
      return Colors.blueAccent;
    } else if (option ==
        selectedQuestions[currentQuestionIndex].correctAnswer) {
      return Colors.green;
    } else if (option == selectedOption) {
      return Colors.red;
    } else {
      return Colors.blueAccent;
    }
  }

  Widget _buildQuizResults() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Quiz Completed!',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 20),
            Text(
              'Your Score: $score/${selectedQuestions.length}',
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  currentQuestionIndex = 0;
                  score = 0;
                  isQuizFinished = false;
                  isAnswered = false;
                  selectedOption = null;
                  _loadQuizQuestions();
                });
              },
              child: const Text('Restart Quiz'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to HomePage'),
            ),
          ],
        ),
      ),
    );
  }
}
