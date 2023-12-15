// ignore: file_names
class QuizQuestion {
  const QuizQuestion({required this.text, required this.answers});

  final String text;
  final List<String> answers;

  List<String> get shuffledAnswer {
    final shuffleList = List.of(answers);
    shuffleList.shuffle();
    return shuffleList;
  }
}
