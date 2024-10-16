class LatLong {
  LatLong(this.latitude, this.longitude);

  LatLong.empty() : this(0.0, 0.0);

  final double latitude;
  final double longitude;

  @override
  String toString() {
    return 'LatLong($latitude, $longitude)';
  }

  bool get isEmpty => latitude == 0.0 && longitude == 0.0;
}
