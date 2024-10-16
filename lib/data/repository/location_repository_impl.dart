import 'package:brian_test/data/layer_data.dart';
import 'package:brian_test/domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final repository = LayerData.repository;

  @override
  Future<(double, double)> getCurrentPosition() async {
    final isEnabled = await repository.location.isLocationEnabled();

    if (!isEnabled) {
      throw LocationDisabledException();
    }

    final isPermissionGranted = await repository.location.isPermissionGranted();

    if (!isPermissionGranted) {
      throw PermissionDeniedException();
    }

    final position = await repository.location.getLocation();

    return (position.$1, position.$2);
  }
}

class LocationDisabledException implements Exception {}

class PermissionDeniedException implements Exception {}
