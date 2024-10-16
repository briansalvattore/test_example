typedef InternalUser = ({
  String uid,
  String displayName,
  String email,
  String photoURL,
});

abstract class Firebase {
  Future<InternalUser> loginWithCredentials({
    required String accessToken,
    required String idToken,
  });

  Future<void> signOut();

  Future<void> sendCrash(
    dynamic exception,
    StackTrace? stack, {
    bool fatal = false,
  });
}
