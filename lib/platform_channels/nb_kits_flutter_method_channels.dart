part of '../nb_kits_flutter.dart';

class NBKitsFlutterMethodChannel extends NBKitsFlutterPlatform {
  final MethodChannel _channel = NBKitsMethodChannelsFactory.nbKitsFlutterChannel;

  NBKitsFlutterMethodChannel() {
    _channel.setMethodCallHandler(handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      default:
        throw MissingPluginException();
    }
  }

  @override
  Future<TurfPoint?> along(List<TurfPoint> line, double distance) async {
    try {
      Map<String, dynamic> args = {
        "line": line.map((e) => e.toGeoJsonCoordinates()).toList(),
        "distance": distance,
      };
      List<dynamic> coors = await _channel.invokeMethod("nbKits/along", args);
      return TurfPoint(((coors[1] as num).toDouble() as num).toDouble(), ((coors[0] as num).toDouble() as num).toDouble());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  @override
  Future<double?> bearing(TurfPoint point1, TurfPoint point2) async {
    try {
      Map<String, dynamic> args = {"point1": point1.toGeoJsonCoordinates(), "point2": point2.toGeoJsonCoordinates()};
      return await _channel.invokeMethod("nbKits/bearing", args);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  @override
  Future<List<TurfPoint>?> circle(TurfPoint center, double radius, {int steps = 64}) async {
    try {
      Map<String, dynamic> args = {
        "center": center.toGeoJsonCoordinates(),
        "radius": radius,
        "steps": steps,
      };
      List<dynamic> result = await _channel.invokeMethod("nbKits/circle", args);
      return result.map((coors) {
        return TurfPoint((coors[1] as num).toDouble(), (coors[0] as num).toDouble());
      }).toList();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  @override
  Future<double?> degreesToRadians(double degrees) async {
    try {
      Map<String, dynamic> args = {"degrees": degrees};
      return await _channel.invokeMethod("nbKits/degreesToRadians", args);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  @override
  Future<TurfPoint?> destination(TurfPoint point, double distance, double bearing) async {
    try {
      Map<String, dynamic> args = {
        "point": point.toGeoJsonCoordinates(),
        "distance": distance,
        "bearing": bearing,
      };
      List<dynamic> result = await _channel.invokeMethod("nbKits/destination", args);
      return TurfPoint(result[1], result[0]);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  @override
  Future<double?> distance(TurfPoint point1, TurfPoint point2) async {
    try {
      Map<String, dynamic> args = {
        "point1": point1.toGeoJsonCoordinates(),
        "point2": point2.toGeoJsonCoordinates(),
      };
      return await _channel.invokeMethod("nbKits/distance", args);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  @override
  Future<double?> length(List<TurfPoint> points) async {
    try {
      Map<String, dynamic> args = {
        "points": points.map((e) => e.toGeoJsonCoordinates()).toList(),
      };
      return await _channel.invokeMethod("nbKits/length", args);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  @override
  Future<List<TurfPoint>?> lineSlice(TurfPoint start, TurfPoint stop, List<TurfPoint> line) async {
    try {
      Map<String, dynamic> args = {
        "start": start.toGeoJsonCoordinates(),
        "stop": stop.toGeoJsonCoordinates(),
        "line": line.map((e) => e.toGeoJsonCoordinates()).toList()
      };
      List<dynamic> result = await _channel.invokeMethod("nbKits/lineSlice", args);
      return result.map((coors) {
        return TurfPoint((coors[1] as num).toDouble(), (coors[0] as num).toDouble());
      }).toList();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  @override
  Future<List<TurfPoint>?> lineSliceAlong(List<TurfPoint> line, double starDist, double stopDist) async {
    try {
      Map<String, dynamic> args = {
        "line": line.map((e) => e.toGeoJsonCoordinates()).toList(),
        "starDist": starDist,
        "stopDist": stopDist,
      };
      List<dynamic> result = await _channel.invokeMethod("nbKits/lineSliceAlong", args);
      return result.map((coors) {
        return TurfPoint((coors[1] as num).toDouble(), (coors[0] as num).toDouble());
      }).toList();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  @override
  Future<TurfPoint?> nearestPoint(TurfPoint targetPoint, List<TurfPoint> points) async {
    try {
      Map<String, dynamic> args = {
        "targetPoint": targetPoint.toGeoJsonCoordinates(),
        "points": points.map((e) => e.toGeoJsonCoordinates()).toList()
      };
      List<dynamic> result = await _channel.invokeMethod("nbKits/nearestPoint", args);
      return TurfPoint(result[1], result[0]);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  @override
  Future<double?> radiansToDegrees(double radians) async {
    try {
      Map<String, dynamic> args = {"radians": radians};
      return await _channel.invokeMethod("nbKits/radiansToDegrees", args);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }
}
