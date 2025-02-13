import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AppGetStorage {
  AppGetStorage.init(this._box, this._currentKey);

  final SharedPreferences _box;
  final String _currentKey;

  Map<String, dynamic>? get() {
    return _getLocalJson(_currentKey);
  }

  void set(Map<String, dynamic>? value) {
    if (value == null) {
      return;
    }

    return _setLocalJson(_currentKey, value);
  }

  void delete() {
    _box.remove(_currentKey);
  }

  void _setLocalJson(String key, Map<String, dynamic> value) {
    _box.setString(key, jsonEncode(value));
  }

  Map<String, dynamic>? _getLocalJson(String key) {
    final value = _box.getString(key);

    if (value == null) {
      return null;
    }

    return Map<String, dynamic>.from(jsonDecode(value) as Map);
  }
}
