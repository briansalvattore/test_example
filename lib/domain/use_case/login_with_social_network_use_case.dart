import 'package:brian_test/data/logger_interface.dart';
import 'package:brian_test/data/repository/auth_repository_impl.dart';
import 'package:flutter/foundation.dart';

mixin LoginWithSocialNetworkUseCase {
  Future<void> call({
    required VoidCallback onSuccess,
    required ValueSetter<String> onError,
  });
}

class LoginWithSocialNetwork implements LoginWithSocialNetworkUseCase {
  final _authRepository = AuthRepositoryImpl();

  @override
  Future<void> call({
    required VoidCallback onSuccess,
    required ValueSetter<String> onError,
  }) async {
    try {
      final user = await _authRepository.loginWithGoogle();

      log.i(user);

      if (user.isEmpty) {
        throw Exception('user not found');
      }

      onSuccess();
    } //
    catch (e) {
      onError('$e');
    }
  }
}
