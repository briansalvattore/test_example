import 'package:brian_test/data/location/location_interface.dart';
import 'package:geolocator/geolocator.dart';

class LocationImpl implements Location {
  @override
  Future<(double, double)> getLocation() async {
    final position = await Geolocator.getCurrentPosition();

    return (position.latitude, position.longitude);
  }

  @override
  Future<bool> isLocationEnabled() async {
    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    return isServiceEnabled;
  }

  @override
  Future<bool> isPermissionGranted() async {
    final firstPermission = await Geolocator.checkPermission();

    if (firstPermission == LocationPermission.denied) {
      final requestPermission = await Geolocator.requestPermission();

      if (requestPermission == LocationPermission.denied) {
        return false;
      } //
      else if (requestPermission == LocationPermission.deniedForever) {
        return false;
      }
    } //
    else if (firstPermission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }
}
