abstract class WeatherRepository {
  Map<String, dynamic> getCache();

  void setCache(Map<String, dynamic> value);

  Future<Map<String, dynamic>> getFromNetwork(
    double latitude,
    double longitude,
  );
}
