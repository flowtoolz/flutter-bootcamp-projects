import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat_new/firebase_options.dart';

ensureFirebaseIsInitialized() async {
  if (firebaseApp != null) { return; }

  firebaseApp = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

FirebaseApp? firebaseApp;