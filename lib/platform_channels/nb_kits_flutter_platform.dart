part of '../nb_kits_flutter.dart';

abstract class NBKitsFlutterPlatform {
  static final NBKitsFlutterPlatform _instance = NBKitsFlutterMethodChannel();

  static NBKitsFlutterPlatform get instance => _instance;


  Future<TurfPoint?> nearestPoint(TurfPoint targetPoint, List<TurfPoint> points);

  Future<double?> degreesToRadians(double degrees);

  Future<double?> radiansToDegrees(double radians);

  Future<double?> bearing(TurfPoint point1, TurfPoint point2);

  Future<TurfPoint?> destination(TurfPoint point, double distance, double bearing);

  Future<double?> distance(TurfPoint point1, TurfPoint point2);

  Future<double?> length(List<TurfPoint> points);

  Future<TurfPoint?> along(List<TurfPoint> line, double distance);

  Future<List<TurfPoint>?> lineSlice(TurfPoint start, TurfPoint stop, List<TurfPoint> line);

  Future<List<TurfPoint>?> lineSliceAlong(List<TurfPoint> line, double starDist, double stopDist);

  Future<List<TurfPoint>?> circle(TurfPoint center, double radius, {int steps = 64});
}
