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
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAQAf46iJq6hGYsKAedFrzmw6GXqMFMqQ0',
    appId: '1:358778482650:web:ae8c2f2aae9fd3bc069ae3',
    messagingSenderId: '358778482650',
    projectId: 'stackves-c5a55',
    authDomain: 'stackves-c5a55.firebaseapp.com',
    storageBucket: 'stackves-c5a55.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBEGyPYHrJVUjIs07TA0-oLE-o3KSxvZM',
    appId: '1:358778482650:android:6623495fe8ed648d069ae3',
    messagingSenderId: '358778482650',
    projectId: 'stackves-c5a55',
    storageBucket: 'stackves-c5a55.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdRTY1olwn6jyqksLZ5zcRYutdgVJx8PA',
    appId: '1:358778482650:ios:dc6cabb52c754d1e069ae3',
    messagingSenderId: '358778482650',
    projectId: 'stackves-c5a55',
    storageBucket: 'stackves-c5a55.appspot.com',
    iosBundleId: 'com.example.rashinStackvase',
  );
}
