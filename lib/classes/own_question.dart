class OwnQuestion {
  String? question;
  // ignore: non_constant_identifier_names
  String? correct_answer;
  List<String>? inCorrectanswers;

  // ignore: non_constant_identifier_names
  OwnQuestion({this.question, this.correct_answer, this.inCorrectanswers});
  factory OwnQuestion.fromJson(Map<String, dynamic> json) {
    return OwnQuestion(
      question: json['question'],
      correct_answer: json['correct_answer'],
      inCorrectanswers: List<String>.from(json['incorrect_answers']),
    );
  }
  Map<String, dynamic> toJson() => {
        "question": question,
        "correct_answer": correct_answer,
        "incorrect_answers": inCorrectanswers
      };
}

class OwnQuiz {
  final String title;
  final String category;
  final String difficulty;
  final List<String> tags;
  final List<OwnQuestion> questions;

  OwnQuiz(
      {required this.title,
      required this.category,
      required this.difficulty,
      required this.tags,
      required this.questions});
  factory OwnQuiz.fromJson(Map<String, dynamic> json) {
    return OwnQuiz(
      title: json['title'],
      category: json['category'],
      difficulty: json['difficulty'],
      tags: json.keys.contains('tags') ? List<String>.from(json['tags']) : [],
      questions: List<OwnQuestion>.from(
          json['questions'].map((x) => OwnQuestion.fromJson(x))),
    );
  }
  Map<String, dynamic> toJson() => {
        "title": title,
        "category": category,
        "difficulty": difficulty,
        "tags": tags,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}
