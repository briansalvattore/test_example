abstract class AuthRepository {
  Future<Map<String, dynamic>> loginWithGoogle();

  Future<void> signOut();

  Map<String, dynamic> getUserFromLocal();
}
