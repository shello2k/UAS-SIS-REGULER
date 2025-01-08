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
    apiKey: 'AIzaSyArI7qs7eDpFyemFmoDdYaxBFqHzV7pIhI',
    appId: '1:676225836277:web:df3a01edc64f5b28f6d1bc',
    messagingSenderId: '676225836277',
    projectId: 'mailingsystem-b2d6b',
    authDomain: 'mailingsystem-b2d6b.firebaseapp.com',
    storageBucket: 'mailingsystem-b2d6b.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBgeQCTxU_nWiuVgR_dJcAODCuWaLv8Fks',
    appId: '1:676225836277:android:a2b7ea2366cf185bf6d1bc',
    messagingSenderId: '676225836277',
    projectId: 'mailingsystem-b2d6b',
    storageBucket: 'mailingsystem-b2d6b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBzsxyZyVxYks1Bu2kwdMae6J9KUAg2Z_Y',
    appId: '1:676225836277:ios:6c1f7a126b2a5bcdf6d1bc',
    messagingSenderId: '676225836277',
    projectId: 'mailingsystem-b2d6b',
    storageBucket: 'mailingsystem-b2d6b.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBzsxyZyVxYks1Bu2kwdMae6J9KUAg2Z_Y',
    appId: '1:676225836277:ios:6c1f7a126b2a5bcdf6d1bc',
    messagingSenderId: '676225836277',
    projectId: 'mailingsystem-b2d6b',
    storageBucket: 'mailingsystem-b2d6b.firebasestorage.app',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyArI7qs7eDpFyemFmoDdYaxBFqHzV7pIhI',
    appId: '1:676225836277:web:e15b5906d0dc59aaf6d1bc',
    messagingSenderId: '676225836277',
    projectId: 'mailingsystem-b2d6b',
    authDomain: 'mailingsystem-b2d6b.firebaseapp.com',
    storageBucket: 'mailingsystem-b2d6b.firebasestorage.app',
  );
}
