import 'package:brian_test/data/logger_interface.dart';
import 'package:brian_test/data/storage/app_get_storage.dart';
import 'package:brian_test/data/storage/storage_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageImpl extends Storage {
  StorageImpl.instance();

  late AppGetStorage _userStorage;
  late AppGetStorage _weatherStorage;

  Future<void> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    const index = 1;

    _userStorage = AppGetStorage.init(sharedPreferences, 'user_$index');
    _weatherStorage = AppGetStorage.init(sharedPreferences, 'weather_$index');

    log.i('init storage');
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
