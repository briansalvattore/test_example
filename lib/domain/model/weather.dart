import 'package:brian_test/data/logger_interface.dart';
import 'package:brian_test/domain/domain_extensions.dart';
import 'package:brian_test/domain/model/lat_long.dart';
import 'package:intl/intl.dart';

class Weather {
  Weather._({
    required this.latLong,
    required this.date,
    required this.temperature,
    required this.location,
  });

  Weather.empty()
      : latLong = LatLong.empty(),
        date = DateTime.now(),
        temperature = 0.0,
        location = '';

  final LatLong latLong;
  final DateTime date;
  final double temperature;
  final String location;

  @override
  String toString() {
    return 'Weather'
        '{latLong: {${latLong.latitude}, ${latLong.longitude}}, '
        'date: $date, '
        'temperature: $temperature}';
  }

  // ignore: prefer_constructors_over_static_methods
  static Weather fromJson(Map<String, dynamic> value) {
    return Weather._(
      latLong: LatLong(
        value.getDouble('latitude'),
        value.getDouble('longitude'),
      ),
      date: () {
        try {
          return DateTime.parse(value.getString('date'));
        } //
        catch (_) {
          log.wtf('ignore error parsing date: {$value}');
          return DateTime.now();
        }
      }(),
      temperature: value.getDouble('temperature'),
      location: value.getString('location'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latLong.latitude,
      'longitude': latLong.longitude,
      'date': date.toIso8601String(),
      'temperature': temperature,
      'location': location,
    };
  }

  bool get isEmpty => latLong.isEmpty;

  String get humaDate {
    final format = DateFormat('EEEE, d MMMM');

    return format.format(date);
  }
}
