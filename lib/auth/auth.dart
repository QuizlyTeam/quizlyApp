import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quizly_app/pages/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import '../classes/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in anon
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

  signOutUser() async {
    await _auth.signOut();
    Get.to(() => const LoginPage());
  }

  signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return null;
    }
  }

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
      } else if (e.code == 'email-already-in-use') {
      }
    }
    return null;
  }

  loginUser(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {
      }
    }
    return null;
  }

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

  signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      return null;
    }
  }
}

createUser(String nickname) async {
  String token = "";
  await FirebaseAuth.instance.currentUser!.getIdToken(true).then((String result){
    token = result;
  });
  final response =
  await http.post(
      Uri.parse('http://10.0.2.2:8000/v1/users/'),
      headers:{ "Authorization": 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String,dynamic>{
        'nickname' : nickname,


      })
  );
  if (response.statusCode == 201) {
    return UserToApi.fromJson(jsonDecode(response.body));
  }else {
    //  print(response.body);
    return null;
  }
}


getUser() async {
  String token = "";
  await FirebaseAuth.instance.currentUser!.getIdToken(true).then((String result){
    token = result;
  });
  final response =
  await http.get(
      Uri.parse('http://10.0.2.2:8000/v1/users/'),
      headers:{ "Authorization": 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
  );
  if (response.statusCode == 200) {
    return 1;

  }else {
    return null;
  }
}



