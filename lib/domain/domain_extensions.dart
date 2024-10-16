extension DynamicUtils on Object? {
  bool isEmptyOrNull() {
    if (this == null) {
      return true;
    } else if (this is String) {
      return (this! as String).isEmpty;
    }

    return true;
  }

  bool isNotEmptyOrNull() => !isEmptyOrNull();

  double toDouble() {
    if (this == null) {
      return 0.0;
    } //
    else if (this is String) {
      if ((this! as String).isEmpty) {
        return 0.0;
      } //
      else {
        final value = double.tryParse(this! as String) ?? 0.0;

        return value is int ? value * 1.0 : value;
      }
    } //
    else if (this is double) {
      return this! as double;
    } //
    else if (this is int) {
      return (this! as int) * 1.0;
    } //
    else {
      return 0.0;
    }
  }

  int toInt() {
    if (this == null) {
      return 0;
    } //
    else if (this is String) {
      if ((this! as String).isEmpty) {
        return 0;
      } //
      else {
        return int.tryParse(this! as String) ?? 0;
      }
    } //
    else if (this is double) {
      return (this! as double).round();
    } //
    else if (this is int) {
      return this! as int;
    } //
    else {
      return 0;
    }
  }

  List<T> toList<T>({T? Function(dynamic item)? parse}) {
    if (this == null) {
      return <T>[];
    }

    if (this is! Iterable) {
      return <T>[];
    }

    return List<dynamic>.from(this! as Iterable)
        .map<T?>((item) {
          try {
            return parse != null ? parse(item) : item as T;
          } //
          catch (_) {
            return null;
          }
        })
        .where((o) => o != null)
        .map((o) => o!)
        .toList();
  }

  String _toStr() {
    if (this == null) {
      return '';
    } //
    else {
      final str = '$this'.trim();

      if (str.toLowerCase() == 'null') {
        return '';
      } //
      else if (str.toLowerCase() == 'none') {
        return '';
      }

      return '$this'.trim();
    }
  }

  String toStr([String? defaultValue]) {
    final str = _toStr();

    return ((defaultValue?.isEmpty ?? true)
            ? str
            : (str.isEmpty ? defaultValue! : str))
        .trim();
  }
}

extension MapStringExtension on Map<String, dynamic> {
  String getString(String key, [String? defaultValue]) {
    return ((this[key.camelCase] ??
            this[key.snakeCase] ??
            this[key.sentenceCase]) as Object?)
        .toStr(defaultValue);
  }

  int getInt(String key) {
    return ((this[key.camelCase] ??
            this[key.snakeCase] ??
            this[key.sentenceCase]) as Object?)
        .toInt();
  }

  double getDouble(String key) {
    return ((this[key.camelCase] ??
            this[key.snakeCase] ??
            this[key.sentenceCase]) as Object?)
        .toDouble();
  }

  // ignore: avoid_positional_boolean_parameters
  bool getBool(String key, [bool defaultValue = true]) {
    return (this[key.camelCase] as bool?) ??
        (this[key.snakeCase] as bool?) ??
        (this[key.sentenceCase] as bool?) ??
        defaultValue;
  }

  Map<String, dynamic> getMap(String key) {
    final seed = (this[key.camelCase] ??
        this[key.snakeCase] ??
        this[key.sentenceCase]) as Object?;

    if (seed == null) {
      return {};
    }

    return Map<String, dynamic>.from(seed as Map);
  }

  List<T> getList<T>(
    String key, [
    T Function(Map<String, dynamic> value)? parser,
  ]) {
    final seed = (this[key.camelCase] ??
        this[key.snakeCase] ??
        this[key.sentenceCase]) as Object?;

    if (seed == null) {
      return [];
    }

    final list = seed as List;

    if (parser == null) {
      return [
        for (final value in list) value as T,
      ];
    }

    return [
      for (final value in list) //
        parser(Map<String, dynamic>.from(value as Map)),
    ];
  }
}

class ReCase {
  ReCase(String text) {
    originalText = text;
    _words = _groupIntoWords(text);
  }
  final RegExp _upperAlphaRegex = RegExp('[A-Z]');

  final symbolSet = {' ', '.', '/', '_', r'\', '-'};

  late String originalText;
  late List<String> _words;

  List<String> _groupIntoWords(String text) {
    final sb = StringBuffer();
    final words = <String>[];
    final isAllCaps = text.toUpperCase() == text;

    for (var i = 0; i < text.length; i++) {
      final char = text[i];
      final nextChar = i + 1 == text.length ? null : text[i + 1];

      if (symbolSet.contains(char)) {
        continue;
      }

      sb.write(char);

      final isEndOfWord = nextChar == null ||
          (_upperAlphaRegex.hasMatch(nextChar) && !isAllCaps) ||
          symbolSet.contains(nextChar);

      if (isEndOfWord) {
        words.add(sb.toString());
        sb.clear();
      }
    }

    return words;
  }

  /// camelCase
  String get camelCase => _getCamelCase();

  /// CONSTANT_CASE
  String get constantCase => _getConstantCase();

  /// Sentence case
  String get sentenceCase => _getSentenceCase();

  /// snake_case
  String get snakeCase => _getSnakeCase();

  /// dot.case
  String get dotCase => _getSnakeCase(separator: '.');

  /// param-case
  String get paramCase => _getSnakeCase(separator: '-');

  /// path/case
  String get pathCase => _getSnakeCase(separator: '/');

  /// PascalCase
  String get pascalCase => _getPascalCase();

  /// Header-Case
  String get headerCase => _getPascalCase(separator: '-');

  /// Title Case
  String get titleCase => _getPascalCase(separator: ' ');

  String _getCamelCase({String separator = ''}) {
    final words = _words.map(_upperCaseFirstLetter).toList();
    if (_words.isNotEmpty) {
      words[0] = words[0].toLowerCase();
    }

    return words.join(separator);
  }

  String _getConstantCase({String separator = '_'}) {
    final words = _words.map((word) => word.toUpperCase()).toList();

    return words.join(separator);
  }

  String _getPascalCase({String separator = ''}) {
    final words = _words.map(_upperCaseFirstLetter).toList();

    return words.join(separator);
  }

  String _getSentenceCase({String separator = ' '}) {
    final words = _words.map((word) => word.toLowerCase()).toList();
    if (_words.isNotEmpty) {
      words[0] = _upperCaseFirstLetter(words[0]);
    }

    return words.join(separator);
  }

  String _getSnakeCase({String separator = '_'}) {
    final words = _words.map((word) => word.toLowerCase()).toList();

    return words.join(separator);
  }

  String _upperCaseFirstLetter(String word) {
    // ignore: lines_longer_than_80_chars
    return '${word.substring(0, 1).toUpperCase()}${word.substring(1).toLowerCase()}';
  }
}

extension StringReCase on String {
  String get camelCase => ReCase(this).camelCase;

  String get constantCase => ReCase(this).constantCase;

  String get sentenceCase => ReCase(this).sentenceCase;

  String get snakeCase => ReCase(this).snakeCase;

  String get dotCase => ReCase(this).dotCase;

  String get paramCase => ReCase(this).paramCase;

  String get pathCase => ReCase(this).pathCase;

  String get pascalCase => ReCase(this).pascalCase;

  String get headerCase => ReCase(this).headerCase;

  String get titleCase => ReCase(this).titleCase;
}
