part of '../nb_kits_flutter.dart';

class TurfMeasurement {
  static final NBKitsFlutterPlatform _nbKitsFlutterPlatform = NBKitsFlutterPlatform.instance;

  /// Takes two [TurfPoint]s and finds the geographic bearing between them.
  ///
  /// @param point1 first point used for calculating the bearing
  /// @param point2 second point used for calculating the bearing
  /// @return bearing in decimal degrees
  ///
  static Future<double?> bearing(TurfPoint point1, TurfPoint point2) async {
    return await _nbKitsFlutterPlatform.bearing(point1, point2);
  }

  /// Takes a Point and calculates the location of a destination point given a distance in
  /// degrees, radians, miles, or kilometers; and bearing in degrees. This uses the Haversine
  /// formula to account for global curvature.
  ///
  /// @param point    starting point used for calculating the destination
  /// @param distance distance from the starting point
  /// @param bearing  ranging from -180 to 180 in decimal degrees
  /// @return destination [TurfPoint] result where you specified
  ///
  static Future<TurfPoint?> destination(TurfPoint point, double distance, double bearing) async {
    return await _nbKitsFlutterPlatform.destination(point, distance, bearing);
  }

  /// Calculates the distance between two points in degrees, radians, miles, or kilometers. This
  /// uses the Haversine formula to account for global curvature.
  ///
  /// @param point1 first point used for calculating the bearing
  /// @param point2 second point used for calculating the bearing
  /// @return distance between the two points in kilometers
  static Future<double?> distance(TurfPoint point1, TurfPoint point2) async {
    return await _nbKitsFlutterPlatform.distance(point1, point2);
  }

  /// Takes a [List] of [TurfPoint] and measures its length in the specified units.
  ///
  /// @param points geometry to measure
  /// @return length of the input line in the meters
  static Future<double?> length(List<TurfPoint> points) async {
    return await _nbKitsFlutterPlatform.length(points);
  }

  /// Takes a list of points and returns a point at a specified distance along the line.
  ///
  /// @param line   that the point should be placed upon
  /// @param distance along the linestring geometry which the point should be placed on
  /// @return a [TurfPoint] which is on the linestring provided and at the distance from
  ///         the origin of that line to the end of the distance
  ///
  static Future<TurfPoint?> along(List<TurfPoint> line, double distance) async {
    return await _nbKitsFlutterPlatform.along(line, distance);
  }
}
