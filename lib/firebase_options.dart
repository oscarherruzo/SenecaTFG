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
    apiKey: 'AIzaSyCyZ7FIKiUH4JHdPgigMOxuqOcyWkG57i0',
    appId: '1:696079309074:web:d60f414a6d9fdf04d47bcb',
    messagingSenderId: '696079309074',
    projectId: 'senecatfg',
    authDomain: 'senecatfg.firebaseapp.com',
    databaseURL: 'https://senecatfg-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'senecatfg.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8Uy6tmeRpatdAe60lrCuXTB8PlV7GDJ4',
    appId: '1:696079309074:android:6a08d4c665ffba7fd47bcb',
    messagingSenderId: '696079309074',
    projectId: 'senecatfg',
    databaseURL: 'https://senecatfg-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'senecatfg.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1QbldNLqMlJeIgKrTYPZW6BIYzjN-TGU',
    appId: '1:696079309074:ios:b2948d418e324092d47bcb',
    messagingSenderId: '696079309074',
    projectId: 'senecatfg',
    databaseURL: 'https://senecatfg-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'senecatfg.appspot.com',
    iosClientId: '696079309074-d43325pdpi7rf9llqcjeukmum4u986au.apps.googleusercontent.com',
    iosBundleId: 'com.example.senecaTfg',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA1QbldNLqMlJeIgKrTYPZW6BIYzjN-TGU',
    appId: '1:696079309074:ios:b2948d418e324092d47bcb',
    messagingSenderId: '696079309074',
    projectId: 'senecatfg',
    databaseURL: 'https://senecatfg-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'senecatfg.appspot.com',
    iosClientId: '696079309074-d43325pdpi7rf9llqcjeukmum4u986au.apps.googleusercontent.com',
    iosBundleId: 'com.example.senecaTfg',
  );
}
