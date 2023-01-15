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

}

