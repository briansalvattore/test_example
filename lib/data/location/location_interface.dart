abstract class Location {
  Future<bool> isLocationEnabled();

  Future<bool> isPermissionGranted();

  Future<(double, double)> getLocation();
}
