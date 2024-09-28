// screens/teacher/quiz_form.dart
import 'package:flutter/material.dart';
import 'package:go_school_application/services/quiz_services.dart';
import '../../models/quiz_model.dart';

class QuizFormPage extends StatefulWidget {
  const QuizFormPage({Key? key}) : super(key: key);

  @override
  _QuizFormPageState createState() => _QuizFormPageState();
}

class _QuizFormPageState extends State<QuizFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  List<Question> _questions = [];

  final _titleController = TextEditingController();

  void _addQuestion() {
    setState(() {
      _questions.add(
        Question(
          questionText: '',
          options: ['', '', '', ''],
          correctOptionIndex: 0,
        ),
      );
    });
  }

  void _saveQuiz() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      QuizModel newQuiz = QuizModel(title: _title, questions: _questions);
      QuizServices().createQuiz(newQuiz);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quiz created successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Quiz Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quiz title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _questions.length,
                  itemBuilder: (context, index) {
                    return _buildQuestionForm(index);
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _addQuestion,
                child: const Text('Add Question'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveQuiz,
                child: const Text('Save Quiz'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionForm(int index) {
    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(labelText: 'Question'),
          onChanged: (value) {
            _questions[index].questionText = value;
          },
        ),
        for (int i = 0; i < 4; i++)
          TextFormField(
            decoration: InputDecoration(labelText: 'Option ${i + 1}'),
            onChanged: (value) {
              _questions[index].options[i] = value;
            },
          ),
        DropdownButtonFormField<int>(
          value: _questions[index].correctOptionIndex,
          decoration: const InputDecoration(labelText: 'Correct Option'),
          items: List.generate(
            4,
            (i) => DropdownMenuItem<int>(
              value: i,
              child: Text('Option ${i + 1}'),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _questions[index].correctOptionIndex = value!;
            });
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
