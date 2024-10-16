import 'dart:convert';

import 'package:brian_test/data/http/http_interface.dart';
import 'package:brian_test/data/logger_interface.dart';
import 'package:http/http.dart' as http;

class HttpImpl extends Http {
  @override
  Future<(int, T)> call<T>({
    required ApiMethod method,
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    final queryString = queryParameters?.entries
        .map((e) => '${e.key}=${e.value}')
        .toList()
        .join('&');

    final uri = Uri.parse('$url${queryString != null ? '?$queryString' : ''}');

    late Future<http.Response> request;

    switch (method) {
      case ApiMethod.get:
        request = http.get(
          uri,
          headers: {
            'Content-Type': 'application/json',
          },
        );
    }

    try {
      final response = await request;

      final statusCode = response.statusCode;

      final jsonResponse = jsonDecode(utf8.decode(response.bodyBytes)) as T;

      return (statusCode, jsonResponse);
    } //
    catch (e) {
      log.wtf(e);
      throw Exception('http error $e');
    }
  }
}
