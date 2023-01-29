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
        return macos;
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
    apiKey: 'AIzaSyB6AgU8rqs6JQ0-7gghAbDH4EvrNcQmOSA',
    appId: '1:893552389783:web:a188c9a9df1fa7051c83d2',
    messagingSenderId: '893552389783',
    projectId: 'ders-program-yeni',
    authDomain: 'ders-program-yeni.firebaseapp.com',
    storageBucket: 'ders-program-yeni.appspot.com',
    measurementId: 'G-ZBLGQ57BXE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyATAQIo9U6cfeYv6FTBYZZn0nbk0XuCVxs',
    appId: '1:893552389783:android:9e6d41bfc1e9882c1c83d2',
    messagingSenderId: '893552389783',
    projectId: 'ders-program-yeni',
    storageBucket: 'ders-program-yeni.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAyTWRWTFg8aPb7UtXfn_424oCVFVdEEEk',
    appId: '1:893552389783:ios:3b809de38e9821491c83d2',
    messagingSenderId: '893552389783',
    projectId: 'ders-program-yeni',
    storageBucket: 'ders-program-yeni.appspot.com',
    iosClientId: '893552389783-0l687cmi4btf1qvru9l9l19rmog843ve.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterDeneme',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAyTWRWTFg8aPb7UtXfn_424oCVFVdEEEk',
    appId: '1:893552389783:ios:3b809de38e9821491c83d2',
    messagingSenderId: '893552389783',
    projectId: 'ders-program-yeni',
    storageBucket: 'ders-program-yeni.appspot.com',
    iosClientId: '893552389783-0l687cmi4btf1qvru9l9l19rmog843ve.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterDeneme',
  );
}