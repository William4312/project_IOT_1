import 'package:flutter/material.dart';
import 'package:project_01/app_project01/data/questions.dart';
import 'package:project_01/app_project01/pages/quiz_screen.dart';
import 'package:project_01/app_project01/pages/result_screen.dart';
import 'package:project_01/app_project01/pages/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var activeScreen = 'start-screen';
  List<String> _selectedAnswers = [];

  void switchScreen() {
    setState(() {
      activeScreen = 'quiz-screen';
    });
  }

  void choosenAnswers(String answer) {
    _selectedAnswers.add(answer);
    if (_selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

    void restartQuiz() {
    setState(() {
        _selectedAnswers = [];
      activeScreen = 'questions-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'quiz-screen') {
      screenWidget = QuizScreen(
        onSelected: choosenAnswers,
      );
    }
    if (activeScreen == 'result-screen') {
      screenWidget = ResultScreen(choosenAnswer: _selectedAnswers, onRestart: restartQuiz);
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 78, 13, 151),
            Color.fromARGB(255, 107, 15, 168)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: screenWidget,
      ),
    );
  }
}
