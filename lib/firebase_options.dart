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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAvuwphUdfrJ1IHgEyzUNTeWueiFFke7gs',
    appId: '1:519336276930:web:eb5fb3bcca5f2f322fdc5b',
    messagingSenderId: '519336276930',
    projectId: 'pisale-80b0a',
    authDomain: 'pisale-80b0a.firebaseapp.com',
    storageBucket: 'pisale-80b0a.appspot.com',
    measurementId: 'G-JMECZR40W3',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCqLLYLGIYsYXcF8nn15wvnxoZWU31e4As',
    appId: '1:519336276930:android:8c45619bc22ff5722fdc5b',
    messagingSenderId: '519336276930',
    projectId: 'pisale-80b0a',
    storageBucket: 'pisale-80b0a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAK9pTV9KdMMBm3yhqCoydi2XVV-W_tb10',
    appId: '1:519336276930:ios:d6798d33cc1918a12fdc5b',
    messagingSenderId: '519336276930',
    projectId: 'pisale-80b0a',
    storageBucket: 'pisale-80b0a.appspot.com',
    iosClientId: '519336276930-7014panfru2lm5aet0qf807sb1iqqhnr.apps.googleusercontent.com',
    iosBundleId: 'com.example.pisale',
  );
}
