import 'package:brian_test/domain/model/weather.dart';
import 'package:brian_test/ui/widgets/atoms/custom_text.dart';
import 'package:flutter/material.dart';

class HomeTemperature extends StatelessWidget {
  const HomeTemperature({
    required this.weather,
    super.key,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final first = weather.temperature.toInt();
    final second = double.parse(
      (weather.temperature - first).toStringAsFixed(2),
    ).toString().split('.')[1];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox.square(
          dimension: 310.0,
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomText.big('$first°'),
              ),
              Positioned(
                bottom: 80.0,
                right: 10.0,
                child: CustomText.small(second),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
