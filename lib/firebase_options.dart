import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        return web;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAy8VoArE6EPMLE5qL_1vkjByphA0fExuc',
    appId: '1:262618091919:web:caeabfd75e7e5fb8737bfa',
    messagingSenderId: '262618091919',
    projectId: 'reread-62e9d',
    authDomain: 'reread-62e9d.firebaseapp.com',
    storageBucket: 'reread-62e9d.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAy8VoArE6EPMLE5qL_1vkjByphA0fExuc',
    appId: '1:262618091919:android:caeabfd75e7e5fb8737bfa',
    messagingSenderId: '262618091919',
    projectId: 'reread-62e9d',
    storageBucket: 'reread-62e9d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAy8VoArE6EPMLE5qL_1vkjByphA0fExuc',
    appId: '1:262618091919:ios:caeabfd75e7e5fb8737bfa',
    messagingSenderId: '262618091919',
    projectId: 'reread-62e9d',
    storageBucket: 'reread-62e9d.firebasestorage.app',
  );
}
