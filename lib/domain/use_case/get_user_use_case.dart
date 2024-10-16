import 'package:brian_test/data/repository/auth_repository_impl.dart';
import 'package:brian_test/domain/model/user.dart';

mixin GetUserUseCase {
  User call();
}

class GetUser implements GetUserUseCase {
  final _authRepository = AuthRepositoryImpl();

  @override
  User call() {
    return User.fromJson(_authRepository.getUserFromLocal());
  }
}
