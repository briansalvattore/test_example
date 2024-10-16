import 'package:brian_test/data/repository/location_repository_impl.dart';
import 'package:brian_test/domain/model/lat_long.dart';
import 'package:flutter/foundation.dart';

mixin GetCurrentPositionUseCase {
  Future<void> call({
    required ValueSetter<LatLong> onSuccess,
    required VoidCallback onServiceDisabled,
    required VoidCallback onPermissionDenied,
    required ValueSetter<String> onError,
  });
}

class GetCurrentPosition implements GetCurrentPositionUseCase {
  final _locationRepository = LocationRepositoryImpl();

  @override
  Future<void> call({
    required ValueSetter<LatLong> onSuccess,
    required VoidCallback onServiceDisabled,
    required VoidCallback onPermissionDenied,
    required ValueSetter<String> onError,
  }) async {
    try {
      final position = await _locationRepository.getCurrentPosition();

      final latLong = LatLong(position.$1, position.$2);

      onSuccess(latLong);
    } //
    on LocationDisabledException catch (_) {
      onServiceDisabled();
    } //
    on PermissionDeniedException catch (_) {
      onPermissionDenied();
    } //
    catch (e) {
      onError('$e');
    }
  }
}
