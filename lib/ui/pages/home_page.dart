import 'package:brian_test/ui/controllers/home_controller.dart';
import 'package:brian_test/ui/widgets/organisms/location_container.dart';
import 'package:brian_test/ui/widgets/organisms/weather_container.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key}) {
    controller.initSettings();
  }

  final controller = HomeController.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Watch((_) {
        final state = controller.positionState.value;

        if (state == PositionState.success) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: WeatherContainer(),
          );
        }

        return LocationContainer(
          state: state,
          error: controller.errorPosition,
        );
      }),
    );
  }
}
