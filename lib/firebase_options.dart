 
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
    apiKey: 'AIzaSyC_vmSs0K35YDMX1_YC_VxtV-hLJd6wmhU',
    appId: '1:414121755451:web:7e37baa97667b6e19cad1e',
    messagingSenderId: '414121755451',
    projectId: 'galaxieapp-43578',
    authDomain: 'galaxieapp-43578.firebaseapp.com',
    storageBucket: 'galaxieapp-43578.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBxD8nGokTtinS6JMmt5HU3yePt7Ugqn3I',
    appId: '1:414121755451:android:6fa8fa85658215369cad1e',
    messagingSenderId: '414121755451',
    projectId: 'galaxieapp-43578',
    storageBucket: 'galaxieapp-43578.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDpOP7fYVz-kdx2YXBpzrTikbw-JvdvvMs',
    appId: '1:414121755451:ios:ba0f3865d154bcbf9cad1e',
    messagingSenderId: '414121755451',
    projectId: 'galaxieapp-43578',
    storageBucket: 'galaxieapp-43578.appspot.com',
    androidClientId: '414121755451-qld1cnq6mabhmbb3vmmkuvig5f5i4899.apps.googleusercontent.com',
    iosClientId: '414121755451-kgomv9pe6ac75447qtlvgei6ogbh91ok.apps.googleusercontent.com',
    iosBundleId: 'com.example.galaxieApp',
  );

}