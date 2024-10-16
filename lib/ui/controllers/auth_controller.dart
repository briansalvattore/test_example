import 'package:brian_test/domain/model/user.dart';
import 'package:brian_test/domain/use_case/get_user_use_case.dart';
import 'package:brian_test/domain/use_case/login_with_social_network_use_case.dart';
import 'package:get_it/get_it.dart';

class AuthController {
  AuthController._();

  static final _getIt = GetIt.instance;

  static final instance = _getIt.get<AuthController>();

  static void setup() {
    _getIt.registerSingleton<AuthController>(
      AuthController._(),
      dispose: (d) => d.dispose(),
    );
  }

  final _loginWithSocialNetworkUseCase = LoginWithSocialNetwork();
  final _getUserUseCase = GetUser();

  bool get isLogged {
    return !user.isEmpty;
  }

  User get user => _getUserUseCase.call();

  Future<String?> loginSocialNetwork() async {
    String? errorKey;

    await _loginWithSocialNetworkUseCase.call(
      onSuccess: () {},
      onError: (e) {
        errorKey = e;
      },
    );

    return errorKey;
  }

  void dispose() {}
}
