enum ApiMethod { get }

// ignore: one_member_abstracts
abstract class Http {
  Future<(int, T)> call<T>({
    required ApiMethod method,
    required String url,
    Map<String, dynamic>? queryParameters,
  });
}
