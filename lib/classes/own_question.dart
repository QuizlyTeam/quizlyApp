///class used to create questions  and modify its data to json format
///[question] - question
///[correct_answer] - correct answer
///[inCorrectanswers] - list of incorrect answers
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
      inCorrectanswers: json['incorrect_answers'],
    );
  }
  Map<String, dynamic> toJson() => {
        "question": question,
        "correct_answer": correct_answer,
        "incorrect_answers": inCorrectanswers
      };
}
///class used to create quiz in page and modify its data to json format
///[title] - title of quiz
///[category] - category of quiz
///[difficulty] difficulty of quiz
///[tags] - list of quiz`s tags
///[questions] - list of questions (OwnQuestion instances)
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
  //odcyzt z JSONa
  factory OwnQuiz.fromJson(Map<String, dynamic> json) {
    List tagsjson = json['tags'];
    List<String> tags = [];
    for (int i = 0; i < tagsjson.length; i++) {
      tags.add(tagsjson[i]);
    }

    List questionsjson = json['questions'];
    List<OwnQuestion> questions = [];

    for (int i = 0; i < questionsjson.length; i++) {
      List incorrectjson = questionsjson[i]['incorrect_answers'];
      List<String> incorrect = [];
      for (int j = 0; j < incorrectjson.length; j++) {
        incorrect.add(incorrectjson[i]);
      }
      questions.add(OwnQuestion(
          question: questionsjson[i]['question'],
          correct_answer: questionsjson[i]['correct_answer'],
          inCorrectanswers: incorrect));
    }

    return OwnQuiz(
      title: json['title'],
      category: json['category'],
      difficulty: json['difficulty'],
      tags: tags,
      questions: questions,
    );
  }
  // do JSONa
  Map<String, dynamic> toJson() => {
        "title": title,
        "category": category,
        "difficulty": difficulty,
        "tags": tags,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };
}
