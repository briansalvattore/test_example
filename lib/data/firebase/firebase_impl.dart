import 'package:brian_test/data/firebase/firebase_interface.dart';
import 'package:brian_test/data/firebase/firebase_options.dart';
import 'package:brian_test/data/logger_interface.dart';
import 'package:firebase_auth/firebase_auth.dart' //
    as firebase_auth;
import 'package:firebase_core/firebase_core.dart' //
    as firebase_core;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' //
    as firebase_crashlytics;

class FirebaseImpl extends Firebase {
  static Future<void> init() async {
    await firebase_core.Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((_) {
      log.i('init firebase');
    });

    return;
  }

  final _firebaseAuth = firebase_auth.FirebaseAuth.instance;

  @override
  Future<InternalUser> loginWithCredentials({
    required String accessToken,
    required String idToken,
  }) async {
    final credential = firebase_auth.GoogleAuthProvider.credential(
      accessToken: accessToken,
      idToken: idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(
      credential,
    );

    final user = userCredential.user;

    if (user == null) {
      throw ArgumentError('user cannot be null');
    }

    final token = await user.getIdToken();

    if (token == null) {
      throw ArgumentError('token cannot be null');
    }

    return (
      uid: user.uid,
      displayName: user.displayName ?? '',
      email: user.email ?? '',
      photoURL: user.photoURL ?? '',
    );
  }

  @override
  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<void> sendCrash(
    dynamic exception,
    StackTrace? stack, {
    bool fatal = false,
  }) {
    return firebase_crashlytics.FirebaseCrashlytics.instance
        .recordError(exception, stack, fatal: fatal);
  }
}
