import 'package:flutter/material.dart';
import 'package:go_school_application/constants/constant_colors.dart';
import 'package:go_school_application/screens/student/student_screen.dart';
import 'package:go_school_application/widgets/common_widgets.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool isQuizFinished = false;
  bool isAnswered = false;
  String? selectedOption;
  List<Question> selectedQuestions = [];

  // Predefined questions and options with the correct answer
  final List<Question> allQuestions = [
    Question(
        text: 'What is the capital of France?',
        options: ['Berlin', 'Madrid', 'Paris', 'Lisbon'],
        correctAnswer: 'Paris'),
    Question(
        text: 'Who developed the theory of relativity?',
        options: ['Newton', 'Einstein', 'Tesla', 'Curie'],
        correctAnswer: 'Einstein'),
    Question(
        text: 'What is the largest planet in our solar system?',
        options: ['Earth', 'Mars', 'Jupiter', 'Saturn'],
        correctAnswer: 'Jupiter'),
    Question(
        text: 'Who painted the Mona Lisa?',
        options: ['Van Gogh', 'Picasso', 'Da Vinci', 'Rembrandt'],
        correctAnswer: 'Da Vinci'),
    Question(
        text: 'What is the chemical symbol for water?',
        options: ['O2', 'H2', 'CO2', 'H2O'],
        correctAnswer: 'H2O'),
    // Add more questions as needed...
  ];

  @override
  void initState() {
    super.initState();
    _generateRandomQuestions();
  }

  void _generateRandomQuestions() {
    // Randomly select 10 questions from the predefined list
    selectedQuestions = (allQuestions.toList()..shuffle()).take(10).toList();
  }

  void _submitAnswer(String selectedOption) {
    setState(() {
      isAnswered = true;
      this.selectedOption = selectedOption;

      // Check if the selected option is correct
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

  Color _getButtonColor(String option) {
    if (!isAnswered) {
      return Colors.blueAccent; // Default color when no answer is selected
    } else if (option ==
        selectedQuestions[currentQuestionIndex].correctAnswer) {
      return Colors.green; // Green for the correct answer
    } else if (option == selectedOption) {
      return Colors.red; // Red for the selected wrong answer
    } else {
      return Colors.blueAccent; // Blue for other options after answering
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Attend Quiz"),
      body: isQuizFinished ? _buildQuizResults() : _buildQuizQuestion(),
    );
  }

  Widget _buildQuizQuestion() {
    Question currentQuestion = selectedQuestions[currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${currentQuestionIndex + 1}/${selectedQuestions.length}',
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: amberTextColor),
          ),
          const SizedBox(height: 20),
          Text(
            currentQuestion.text,
            style: const TextStyle(fontSize: 18, color: textColor),
          ),
          const SizedBox(height: 20),
          ...currentQuestion.options.map((option) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(0, 23, 38, 244),
                  // Set button color based on selection
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
            )
        ],
      ),
    );
  }

  Widget _buildQuizResults() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Quiz Completed!',
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple),
            ),
            const SizedBox(height: 20),
            Text(
              'Your Score: $score/${selectedQuestions.length}',
              style: const TextStyle(fontSize: 20, color: textColor),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Reset quiz
                  currentQuestionIndex = 0;
                  score = 0;
                  isQuizFinished = false;
                  isAnswered = false;
                  selectedOption = null;
                  _generateRandomQuestions();
                });
              },
              child: const Text('Restart Quiz'),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => StudentScreen())),
                child: Text("Back to HomePage"))
          ],
        ),
      ),
    );
  }
}

class Question {
  final String text;
  final List<String> options;
  final String correctAnswer;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswer,
  });
}
