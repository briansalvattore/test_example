abstract class Storage {
  Map<String, dynamic> get user;

  set user(Map<String, dynamic> value);

  bool get isLogged;

  Map<String, dynamic> get weather;

  set weather(Map<String, dynamic> value);
}
