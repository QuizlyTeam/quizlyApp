class OwnQuestion{
  final String question;
  final String correct_answer;
  final List<String> inCorrectanswers;

  // ignore: non_constant_identifier_names
  OwnQuestion({required this.question,required this.correct_answer,required this.inCorrectanswers});
  factory OwnQuestion.fromJson(Map<String, dynamic> json){
    return OwnQuestion(
    question: json['question'],
    correct_answer: json['correct_answer'],
    inCorrectanswers: json['incorrect_answers'],
    );
  }

}

class OwnQuiz{
  final String title;
  final String category;
  final String difficulty;
  final List<String> tags;
  final List<OwnQuestion> questions;

  OwnQuiz({required this.title,required this.category,required this.difficulty, required this.tags, required this.questions});
  factory OwnQuiz.fromJson(Map<String, dynamic> json) {
    return OwnQuiz(
      title: json['title'],
      category: json['category'],
      difficulty: json['difficulty'],
      tags: json['tags'],
      questions: json['questions'] ,

    );
  }
}
