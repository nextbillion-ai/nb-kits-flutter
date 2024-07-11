part of '../nb_kits_flutter.dart';

class TurfConversion {
  static final NBKitsFlutterPlatform _nbKitsFlutterPlatform = NBKitsFlutterPlatform.instance;

  /// Converts an angle in degrees to radians.
  ///
  /// @param degrees angle between 0 and 360 degrees
  /// @return angle in radians
  ///
  static Future<double?> degreesToRadians(double degree) async {
    return await _nbKitsFlutterPlatform.degreesToRadians(degree);
  }

  /// Converts an angle in radians to degrees.
  ///
  /// @param radians angle in radians
  /// @return degrees between 0 and 360 degrees
  ///
  static Future<double?> radiansToDegrees(double radians) async {
    return await _nbKitsFlutterPlatform.radiansToDegrees(radians);
  }

}
