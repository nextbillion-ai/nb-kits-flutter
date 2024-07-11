part of '../nb_kits_flutter.dart';

class TurfMisc {
  static final NBKitsFlutterPlatform _nbKitsFlutterPlatform = NBKitsFlutterPlatform.instance;

  /// Takes a line, a start [TurfPoint], and a stop point and returns the line in between those
  /// points.
  ///
  /// @param start used for calculating the lineSlice
  /// @param stop  used for calculating the lineSlice
  /// @param line    geometry that should be sliced
  /// @return a sliced [TurfPoint]s
  ///
  static Future<List<TurfPoint>?> lineSlice(TurfPoint start, TurfPoint stop, List<TurfPoint> line) async {
    return await _nbKitsFlutterPlatform.lineSlice(start, stop, line);
  }

  /// Takes a line [TurfPoint]s, a specified distance along the line to a start [TurfPoint],
  /// and a specified distance along the line to a stop point,
  /// returns a subsection of the line in-between those points.
  ///
  /// This can be useful for extracting only the part of a route between two distances.
  ///
  /// @param line input line
  /// @param startDist distance along the line to starting point
  /// @param stopDist distance along the line to ending point
  /// @return sliced line [TurfPoint]s
  ///
  static Future<List<TurfPoint>?> lineSliceAlong(List<TurfPoint> line, double starDist, double stopDist) async {
    return await _nbKitsFlutterPlatform.lineSliceAlong(line, starDist, stopDist);
  }
}
