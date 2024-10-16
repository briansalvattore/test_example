import 'package:brian_test/data/logger_interface.dart';
import 'package:brian_test/data/storage/app_get_storage.dart';
import 'package:brian_test/data/storage/storage_interface.dart';
import 'package:get_storage/get_storage.dart';

class StorageImpl extends Storage {
  static const index = 1;

  final _userStorage = AppGetStorage.init('user_$index');
  final _weatherStorage = AppGetStorage.init('weather_$index');

  static Future<StorageImpl> init() async {
    await GetStorage.init().then((_) {
      log.i('init storage');
    });

    return StorageImpl();
  }

  @override
  Map<String, dynamic> get user {
    try {
      final map = _userStorage.get() ?? <String, dynamic>{};

      return map;
    } //
    catch (e) {
      throw UnsupportedError('user local not available');
    }
  }

  @override
  set user(Map<String, dynamic> value) {
    _userStorage.set(value);
  }

  @override
  bool get isLogged {
    return user.keys.isNotEmpty;
  }

  @override
  Map<String, dynamic> get weather {
    try {
      final map = _weatherStorage.get() ?? <String, dynamic>{};

      return map;
    } //
    catch (e) {
      throw UnsupportedError('weather local not available');
    }
  }

  @override
  set weather(Map<String, dynamic> value) {
    _weatherStorage.set(value);
  }
}
