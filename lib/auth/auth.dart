import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quizly_app/pages/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

///class used to improve and fasten writing code to authenticate user
class AuthService {
  ///Firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ///sign in anonymously
  signInAnon() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          break;
        default:
      }
    }
    return null;
  }
  ///sign out user
  signOutUser() async {
    await _auth.signOut();
    Get.to(() => const LoginPage());
  }
  /// sign in with Google account
  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return null;
    }
  }
  /// register user with given [email] and [password]
  registerUser(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {}
    }
    return null;
  }
///login user with [email] and [password]
  loginUser(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {}
    }
    return null;
  }
  /// sign in using Apple account
  signInWithApple() async {
    try {
      final appleProvider = AppleAuthProvider();
      if (kIsWeb) {
        await FirebaseAuth.instance.signInWithPopup(appleProvider);
      } else {
        await FirebaseAuth.instance.signInWithProvider(appleProvider);
      }
    } catch (e) {
      return null;
    }
  }
  /// sign in using Facebook account
  signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      return null;
    }
  }

  refreshSession() async {
    User currentUser = _auth.currentUser!;
    String? refreshToken = currentUser.refreshToken;
    var credential = GoogleAuthProvider.credential(accessToken: refreshToken);
    _auth.signInWithCredential(credential).then((user) {});
  }
}

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

getQuizzes() async {
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
    ;
    return json;
  } else {
    throw Exception("Failed to fetch quizid's");
  }
}

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
