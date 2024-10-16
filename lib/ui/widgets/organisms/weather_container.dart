import 'package:brian_test/ui/controllers/home_controller.dart';
import 'package:brian_test/ui/widgets/molecules/home_header.dart';
import 'package:brian_test/ui/widgets/molecules/home_temperature.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class WeatherContainer extends StatelessWidget {
  WeatherContainer({super.key});

  final controller = HomeController.instance;

  @override
  Widget build(BuildContext context) {
    return Watch((_) {
      final weather = controller.weather.value;

      if (weather == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return Column(
        children: [
          HomeHeader(
            weather: weather,
          ),
          Expanded(
            child: HomeTemperature(
              weather: weather,
            ),
          ),
        ],
      );
    });
  }
}
