import 'package:brian_test/data/http/http_interface.dart';
import 'package:brian_test/data/layer_data.dart';
import 'package:brian_test/domain/domain_extensions.dart';
import 'package:brian_test/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final repository = LayerData.repository;

  @override
  Map<String, dynamic> getCache() {
    return repository.storage.weather;
  }

  @override
  Future<Map<String, dynamic>> getFromNetwork(
    double latitude,
    double longitude,
  ) async {
    final request = await repository.http.call<Map<String, dynamic>>(
      method: ApiMethod.get,
      url: 'https://api.openweathermap.org/data/2.5/weather',
      queryParameters: {
        'lat': '$latitude',
        'lon': '$longitude',
        'units': 'metric',
        'appid': '0532db85786c00b49f99adaa33afd7d4',
      },
    );

    if (request.$1 != 200) {
      throw Exception('Failed to fetch weather data');
    }

    final temperature = request.$2.getMap('main').getDouble('temp');
    final location = request.$2.getString('name');

    return {
      'latitude': latitude,
      'longitude': longitude,
      'temperature': temperature,
      'date': DateTime.now().toIso8601String(),
      'location': location,
    };
  }

  @override
  void setCache(Map<String, dynamic> value) {
    repository.storage.weather = value;
  }
}
