import 'package:brian_test/ui/controllers/home_controller.dart';
import 'package:brian_test/ui/l10n/l10n_extensions.dart';
import 'package:brian_test/ui/widgets/molecules/error_location_container.dart';
import 'package:flutter/material.dart';

class LocationContainer extends StatelessWidget {
  const LocationContainer({
    required this.state,
    required this.error,
    super.key,
  });

  final PositionState state;
  final String? error;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case PositionState.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case PositionState.disabled:
        return ErrorLocationContainer(
          message: context.t.locationErrorDisabled,
        );
      case PositionState.denied:
        return ErrorLocationContainer(
          message: context.t.locationErrorDenied,
        );
      case PositionState.error:
        return ErrorLocationContainer(
          message: '${context.t.locationError}$error',
        );
      // ignore: no_default_cases
      default:
        return const Offstage();
    }
  }
}
