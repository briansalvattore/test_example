import 'package:brian_test/data/layer_data.dart';
import 'package:brian_test/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final repository = LayerData.repository;

  @override
  Future<Map<String, dynamic>> loginWithGoogle() async {
    final googleCredentials = await repository.google.getCredentials();

    final firebaseUser = await repository.firebase.loginWithCredentials(
      accessToken: googleCredentials.$1,
      idToken: googleCredentials.$2,
    );

    final userMap = {
      'id': firebaseUser.uid,
      'email': firebaseUser.email,
      'fullName': firebaseUser.displayName,
      'photoUrl': firebaseUser.photoURL,
    };

    repository.storage.user = userMap;

    return userMap;
  }

  @override
  Future<void> signOut() async {
    repository.storage.user = {};
    await repository.firebase.signOut();
  }

  @override
  Map<String, dynamic> getUserFromLocal() {
    return repository.storage.user;
  }
}
