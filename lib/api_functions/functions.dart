import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizly_app/classes/own_question.dart';
import 'package:http/http.dart' as http;
import '../classes/user.dart';

///create User in Database which chosen [nickname]
createUser(String nickname) async {
  String token = "";
  await FirebaseAuth.instance.currentUser!
      .getIdToken(true)
      .then((String result) {
    token = result;
  });
  final response = await http.post(Uri.parse('http://10.0.2.2:8000/v1/users/'),
      headers: {
        "Authorization": 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nickname': nickname,
      }));
  if (response.statusCode == 201) {
    return UserToApi.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}
///get User`s datas from database
getUser() async {
  String token = "";
  await FirebaseAuth.instance.currentUser!
      .getIdToken(true)
      .then((String result) {
    token = result;
  });
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/v1/users/'),
    headers: {
      "Authorization": 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return data;
  } else {
    return null;
  }
}
///create quiz in database which contains [title], [category], [difficulty], [tags] and [questions]
// ignore: non_constant_identifier_names
createQuiz(String title, String category, String difficulty, List<String> tags,
    List<OwnQuestion> questions) async {
  String token = "";
  // ignore: non_constant_identifier_names
  String OwnQuizToJson(OwnQuiz data) => json.encode(data.toJson());
  await FirebaseAuth.instance.currentUser!
      .getIdToken(true)
      .then((String result) {
    token = result;
  });
  final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/v1/quizzes/'),
      headers: {
        "Authorization": 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: OwnQuizToJson(OwnQuiz(
          title: title,
          category: category,
          difficulty: difficulty,
          tags: tags,
          questions: questions)));
  if (response.statusCode == 201) {
    return OwnQuiz.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}
///return List of quizzes` ids
Future<List<String>> getQuizzesID() async {
  String token = "";
  if (FirebaseAuth.instance.currentUser != null) {
    await FirebaseAuth.instance.currentUser!
        .getIdToken(true)
        .then((String result) {
      token = result;
    });
  }
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/v1/quizzes/'),
    headers: {
      "Authorization": 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    Map myMap = json;
    List<String> quizzesID = [];
    for (int i = 0; i < myMap.keys.length; i++) {
      quizzesID.add(myMap.keys.elementAt(i).toString());
    }
    return quizzesID;
  } else {
    throw Exception("Failed to fetch quizid's");
  }
}
///get quiz datas using [quizID]
Future<OwnQuiz> getQuizById(String quizID) async {
  String token = "";
  await FirebaseAuth.instance.currentUser!
      .getIdToken(true)
      .then((String result) {
    token = result;
  });
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8000/v1/quizzes/$quizID'),
    headers: {
      "Authorization": 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);

    List<String> tags2 = [];
    if (json['tags'] != null) {
      List<dynamic> tagsjson = json['tags'];

      for (int i = 0; i < tagsjson.length; i++) {
        tags2.add(tagsjson[i]);
      }
    }

    List<OwnQuestion> questions = [];
    if (json['questions'] != null) {
      List<dynamic> questionsjson = json['questions'];
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
    }

    return OwnQuiz(
        title: json['title'],
        category: json['category'],
        difficulty: json['difficulty'],
        tags: tags2,
        questions: questions);
  } else {
    throw Exception("Faild to fetch quiz from id");
  }
}
///delete quiz using its [quizID]
deleteQuizByID(String quizID) async {
  String token = "";
  await FirebaseAuth.instance.currentUser!
      .getIdToken(true)
      .then((String result) {
    token = result;
  });
  final response = await http.delete(
    Uri.parse('http://10.0.2.2:8000/v1/quizzes/$quizID'),
    headers: {
      "Authorization": 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 204) {
    return true;
  } else {
    return false;
  }
}
///edit current quiz using [quizID] and given new [quiz]
editQuiz(String quizID, OwnQuiz quiz) async {
  String token = "";
  await FirebaseAuth.instance.currentUser!
      .getIdToken(true)
      .then((String result) {
    token = result;
  });
  // ignore: non_constant_identifier_names
  String OwnQuizToJson(OwnQuiz data) => json.encode(data.toJson());

  final response =
  await http.patch(Uri.parse('http://10.0.2.2:8000/v1/quizzes/$quizID'),
      headers: {
        "Authorization": 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: OwnQuizToJson(quiz));
  if (response.statusCode == 200) {
    return OwnQuiz.fromJson(jsonDecode(response.body));
  } else {
    return null;
  }
}
