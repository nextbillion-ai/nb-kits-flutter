part of '../nb_kits_flutter.dart';

/// A pair of latitude and longitude coordinates, stored as degrees.
class TurfPoint {
  /// Creates a geographical location specified in degrees [latitude] and
  /// [longitude].
  ///
  /// The latitude is clamped to the inclusive interval from -90.0 to +90.0.
  ///
  /// The longitude is normalized to the half-open interval from -180.0
  /// (inclusive) to +180.0 (exclusive)
  const TurfPoint(double latitude, double longitude)
      : latitude = (latitude < -90.0 ? -90.0 : (90.0 < latitude ? 90.0 : latitude)),
        longitude = (longitude + 180.0) % 360.0 - 180.0;

  /// The latitude in degrees between -90.0 and 90.0, both inclusive.
  final double latitude;

  /// The longitude in degrees between -180.0 (inclusive) and 180.0 (exclusive).
  final double longitude;

  TurfPoint operator +(TurfPoint o) {
    return TurfPoint(latitude + o.latitude, longitude + o.longitude);
  }

  TurfPoint operator -(TurfPoint o) {
    return TurfPoint(latitude - o.latitude, longitude - o.longitude);
  }

  dynamic toJson() {
    return <double>[latitude, longitude];
  }

  dynamic toGeoJsonCoordinates() {
    return <double>[longitude, latitude];
  }

  static TurfPoint fromJson(List<dynamic> json) {
    return TurfPoint(json[0], json[1]);
  }

  @override
  String toString() => '$runtimeType($latitude, $longitude)';

  @override
  bool operator ==(Object o) {
    return o is TurfPoint && o.latitude == latitude && o.longitude == longitude;
  }

  @override
  int get hashCode => Object.hash(latitude, longitude);
}
