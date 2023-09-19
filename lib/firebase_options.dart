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
    apiKey: 'AIzaSyB5P7jg2Zg72ZMfvv22CBDTiMoJTW0_tRQ',
    appId: '1:182512457954:web:6d9631fc11d2c4ca8666bb',
    messagingSenderId: '182512457954',
    projectId: 'do-you-math-391805',
    authDomain: 'do-you-math-391805.firebaseapp.com',
    storageBucket: 'do-you-math-391805.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBbx0yf_8blPionKAFTKyr_RYwLe3WoxqA',
    appId: '1:182512457954:android:ac5167646199b31f8666bb',
    messagingSenderId: '182512457954',
    projectId: 'do-you-math-391805',
    storageBucket: 'do-you-math-391805.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCp5iSvX0UXn7_cKumeJEw9hbsDEkjNojk',
    appId: '1:182512457954:ios:9b75b58a9ed1bd928666bb',
    messagingSenderId: '182512457954',
    projectId: 'do-you-math-391805',
    storageBucket: 'do-you-math-391805.appspot.com',
    iosClientId: '182512457954-7lh3ahn5kvqtt4jbs5cfah12ar23je18.apps.googleusercontent.com',
    iosBundleId: 'com.example.doYouMath',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCp5iSvX0UXn7_cKumeJEw9hbsDEkjNojk',
    appId: '1:182512457954:ios:e7eb513a4fe394c38666bb',
    messagingSenderId: '182512457954',
    projectId: 'do-you-math-391805',
    storageBucket: 'do-you-math-391805.appspot.com',
    iosClientId: '182512457954-c06io9j974detmvs5p1fmbf3dipuj7g5.apps.googleusercontent.com',
    iosBundleId: 'com.example.doYouMath.RunnerTests',
  );
}
