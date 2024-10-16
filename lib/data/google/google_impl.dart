import 'package:brian_test/data/google/google_interface.dart';
import 'package:brian_test/data/logger_interface.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleImpl implements Google {
  @override
  Future<(String, String)> getCredentials() async {
    final googleSignIn = GoogleSignIn(scopes: ['email']);

    try {
      await googleSignIn.signOut();
    } //
    catch (e) {
      log.wtf(e);
    }

    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      throw Exception('User cancelled the sign-in.');
    }

    final googleAuth = await googleUser.authentication;

    if (googleAuth.accessToken == null || googleAuth.idToken == null) {
      throw Exception('Google invalid credentials.');
    }

    return (googleAuth.accessToken ?? '', googleAuth.idToken ?? '');
  }
}
