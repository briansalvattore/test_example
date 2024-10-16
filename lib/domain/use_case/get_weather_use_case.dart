import 'dart:math';

import 'package:brian_test/data/repository/weather_repository_impl.dart';
import 'package:brian_test/domain/model/lat_long.dart';
import 'package:brian_test/domain/model/weather.dart';
import 'package:flutter/foundation.dart';

mixin GetWeatherUseCase {
  Future<void> call({
    required LatLong latLong,
    required ValueSetter<Weather> onSuccess,
    required ValueSetter<String> onError,
  });
}

class GetWeather implements GetWeatherUseCase {
  final _weatherRepository = WeatherRepositoryImpl();

  @override
  Future<void> call({
    required LatLong latLong,
    required ValueSetter<Weather> onSuccess,
    required ValueSetter<String> onError,
  }) async {
    final cache = Weather.fromJson(_weatherRepository.getCache());

    if (cache.isEmpty) {
      final newWeather = await _requestWeather(latLong);

      onSuccess(newWeather);
      return;
    }

    final now = DateTime.now();

    final diffInTime = now.difference(cache.date);

    if (diffInTime.inHours > 1) {
      final newWeather = await _requestWeather(latLong);

      onSuccess(newWeather);
      return;
    } //

    final diffInMiles = _diffDistanceInMiles(
      latLong.latitude,
      latLong.longitude,
      cache.latLong.latitude,
      cache.latLong.longitude,
    );

    if (diffInMiles > 20) {
      final newWeather = await _requestWeather(latLong);

      onSuccess(newWeather);
      return;
    }

    onSuccess(cache);
  }

  Future<Weather> _requestWeather(LatLong latLong) async {
    final newWeather = await _weatherRepository.getFromNetwork(
      latLong.latitude,
      latLong.longitude,
    );

    _weatherRepository.setCache(newWeather);

    return Weather.fromJson(newWeather);
  }

  double _diffDistanceInMiles(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const earthRadius = 3958.8;

    double rad(double value) => value * pi / 180;

    final dLat = rad(lat2 - lat1);
    final dLon = rad(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(rad(lat1)) * cos(rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }
}
