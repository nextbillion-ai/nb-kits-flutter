part of '../nb_kits_flutter.dart';

class TurfTransformation {
  static final NBKitsFlutterPlatform _nbKitsFlutterPlatform = NBKitsFlutterPlatform.instance;

  /// Takes a [TurfPoint] and calculates the circle polygon given a radius in meters
  /// and steps for precision.
  ///
  /// @param center a [TurfPoint] which the circle will center around
  /// @param radius the radius of the circle
  /// @param steps  number of steps which make up the circle parameter
  /// @return a polygon which represents the newly created circle
  ///
  static Future<List<TurfPoint>?> circle(TurfPoint center, double radius, {int steps = 64}) async {
    return await _nbKitsFlutterPlatform.circle(center, radius, steps: steps);
  }
}
