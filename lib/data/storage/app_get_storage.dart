import 'package:get_storage/get_storage.dart';

class AppGetStorage {
  AppGetStorage.init(this._currentKey);

  final _box = GetStorage();
  final String _currentKey;

  Map<String, dynamic>? get() {
    return _getLocalJson(_currentKey);
  }

  void set(Map<String, dynamic>? value) {
    return _setLocalJson(_currentKey, value);
  }

  void delete() {
    _box.remove(_currentKey);
  }

  void _setLocalJson(String key, Map<String, dynamic>? value) {
    _box.write(key, value);
  }

  Map<String, dynamic>? _getLocalJson(String key) {
    final value = _box.read<dynamic>(key);

    if (value == null) {
      return null;
    }

    return Map<String, dynamic>.from(value as Map);
  }
}
