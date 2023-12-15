import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_01/app_project01/components/questions_summary/questions_summary.dart';
import 'package:project_01/app_project01/data/questions.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key, required this.choosenAnswer, required this.onRestart});
  final void Function() onRestart;
  final List<String> choosenAnswer;

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];
    for (int i = 0; i < choosenAnswer.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'correct_answer': questions[i].answers[0],
          'user_answer': choosenAnswer[i]
        },
      );
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData
        .where((element) => element['user_answer'] == element['correct_answer'])
        .length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'You answered the $numCorrectQuestions out of $numTotalQuestions questions correctly',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 230, 200, 253),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onHover: (value) => const BorderSide(
                width: 1.0,
                color: Colors.white,
              ),
              style: const ButtonStyle(
                  iconColor: MaterialStatePropertyAll(Colors.white)),
              onPressed: onRestart,
              icon: const Icon(Icons.refresh),
              label: const Text(
                'Restart Quiz!',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
