import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const QuizSelection(),
    );
  }
}

class QuizSelection extends StatefulWidget {
  const QuizSelection({super.key});

  @override
  State<QuizSelection> createState() => _QuizSelectionState();
}

class _QuizSelectionState extends State<QuizSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select a Quiz',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => QuizScreen(
                          quizType: 'Java',
                          questions: javaQuestions,
                        ),
                  ),
                );
              },
              child: const Text('Java Quiz'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => QuizScreen(
                          quizType: 'Python',
                          questions: pythonQuestions,
                        ),
                  ),
                );
              },
              child: const Text('Python Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String text;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
  });
}

// Java Quiz Questions
final List<Question> javaQuestions = [
  Question(
    text: 'Which keyword is used to define a class in Java?',
    options: ['struct', 'class', 'interface', 'object'],
    correctAnswerIndex: 1,
  ),
  Question(
    text: 'What is the correct way to declare a main method in Java?',
    options: [
      'public static void main()',
      'public void main(String[] args)',
      'public static void main(String[] args)',
      'static void main(String args[])',
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    text: 'What is the default value of an int variable in Java?',
    options: ['0', 'null', 'undefined', '1'],
    correctAnswerIndex: 0,
  ),
];

// Python Quiz Questions
final List<Question> pythonQuestions = [
  Question(
    text: 'Which is NOT a valid way to comment in Python?',
    options: [
      '# Comment',
      '/* Comment */',
      "''' Comment '''",
      '""" Comment """',
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    text: 'How do you define a function in Python?',
    options: [
      'function name():',
      'def name():',
      'define name():',
      'func name():',
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    text: 'Which method is used to add an element to a list in Python?',
    options: ['add()', 'insert()', 'append()', 'extend()'],
    correctAnswerIndex: 2,
  ),
];

class QuizScreen extends StatefulWidget {
  final String quizType;
  final List<Question> questions;

  const QuizScreen({
    super.key,
    required this.quizType,
    required this.questions,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;

  void checkAnswer(int selectedIndex) {
    if (selectedIndex ==
        widget.questions[currentQuestionIndex].correctAnswerIndex) {
      setState(() {
        score++;
      });
    }

    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // Navigate to results screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => ResultScreen(
                score: score,
                totalQuestions: widget.questions.length,
                quizType: widget.quizType,
              ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: Text('${widget.quizType} Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}/${widget.questions.length}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              currentQuestion.text,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...List.generate(
              currentQuestion.options.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  onPressed: () => checkAnswer(index),
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(currentQuestion.options[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final String quizType;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.quizType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Results')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Quiz Completed!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              '$quizType Quiz Results:',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              'Score: $score out of $totalQuestions',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Back to Quiz Selection'),
            ),
          ],
        ),
      ),
    );
  }
}
