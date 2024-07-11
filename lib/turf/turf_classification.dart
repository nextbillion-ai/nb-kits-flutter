part of '../nb_kits_flutter.dart';

class TurfClassification {
  static final NBKitsFlutterPlatform _nbKitsFlutterPlatform = NBKitsFlutterPlatform.instance;

  /// Takes a reference point and a list of [TurfPoint] geometries and returns the point from the
  /// set point list closest to the reference. This calculation is geodesic.
  ///
  /// @param targetPoint the reference point
  /// @param points      set list of points to run against the input point
  /// @return the closest point in the set to the reference point
  ///
  static Future<TurfPoint?> nearestPoint(TurfPoint targetPoint, List<TurfPoint> points) async {
    return await _nbKitsFlutterPlatform.nearestPoint(targetPoint, points);
  }
}
