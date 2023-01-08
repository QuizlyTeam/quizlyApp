// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTH2pFW2K6uObn_tLX8Bg0oiThRU6R3N4',
    appId: '1:935478523711:android:c1a7b0261aebaa95ed058a',
    messagingSenderId: '935478523711',
    projectId: 'quizly-70118',
    databaseURL: 'https://quizly-70118-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'quizly-70118.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAwK7_Pxa8wA_zzOLKaMgbK_pWgBouCeJ8',
    appId: '1:935478523711:ios:0a0929e10d7d0334ed058a',
    messagingSenderId: '935478523711',
    projectId: 'quizly-70118',
    databaseURL: 'https://quizly-70118-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'quizly-70118.appspot.com',
    androidClientId: '935478523711-ojcms6sgv12e0h7ida8f733h9lbh38em.apps.googleusercontent.com',
    iosClientId: '935478523711-ra8t0gqkq49mtqhntr43atquqv2u3vtb.apps.googleusercontent.com',
    iosBundleId: 'com.example.quizlyApp',
  );
}
