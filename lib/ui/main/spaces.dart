import 'package:flutter/material.dart';

class AppSpaces {
  AppSpaces._();

  // ignore: library_private_types_in_public_api
  static _WidgetSpaces widget = const _WidgetSpaces._();
}

class _WidgetSpaces {
  const _WidgetSpaces._();

  Widget h100() => const SizedBox(height: 100.0);
  Widget h50() => const SizedBox(height: 50.0);
  Widget h20() => const SizedBox(height: 20.0);
}
