import 'package:brian_test/domain/model/weather.dart';
import 'package:brian_test/ui/main/spaces.dart';
import 'package:brian_test/ui/widgets/atoms/custom_chip.dart';
import 'package:brian_test/ui/widgets/atoms/custom_text.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.weather,
    super.key,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpaces.widget.h50(),
        CustomText.title(weather.location),
        AppSpaces.widget.h20(),
        CustomChip(title: weather.humaDate),
      ],
    );
  }
}
