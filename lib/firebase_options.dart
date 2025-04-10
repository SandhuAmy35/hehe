// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCKgYEHssOetgUnwd3yCl-cIsrFoc7wmNI',
    appId: '1:534325840294:web:68b25ac9eba452127d6767',
    messagingSenderId: '534325840294',
    projectId: 'engineer-app-e84b8',
    authDomain: 'engineer-app-e84b8.firebaseapp.com',
    storageBucket: 'engineer-app-e84b8.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDh0GmCLTmEksYfu87qYJZ-3MC0aIC1qqk',
    appId: '1:534325840294:android:535f690a8cd42bd67d6767',
    messagingSenderId: '534325840294',
    projectId: 'engineer-app-e84b8',
    storageBucket: 'engineer-app-e84b8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDKKTuu6Ml62wQqSBiAejDpZGyj5Bq9HtY',
    appId: '1:534325840294:ios:ca8c0588906fb2ee7d6767',
    messagingSenderId: '534325840294',
    projectId: 'engineer-app-e84b8',
    storageBucket: 'engineer-app-e84b8.firebasestorage.app',
    iosBundleId: 'com.example.engineerAppFrontend',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDKKTuu6Ml62wQqSBiAejDpZGyj5Bq9HtY',
    appId: '1:534325840294:ios:ca8c0588906fb2ee7d6767',
    messagingSenderId: '534325840294',
    projectId: 'engineer-app-e84b8',
    storageBucket: 'engineer-app-e84b8.firebasestorage.app',
    iosBundleId: 'com.example.engineerAppFrontend',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCKgYEHssOetgUnwd3yCl-cIsrFoc7wmNI',
    appId: '1:534325840294:web:a42a7a0abd1ffff87d6767',
    messagingSenderId: '534325840294',
    projectId: 'engineer-app-e84b8',
    authDomain: 'engineer-app-e84b8.firebaseapp.com',
    storageBucket: 'engineer-app-e84b8.firebasestorage.app',
  );

}