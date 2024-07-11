package ai.nextbillion.kits.nb_kits_flutter

import ai.nextbillion.kits.geojson.LineString
import ai.nextbillion.kits.geojson.Point
import ai.nextbillion.kits.turf.TurfClassification
import ai.nextbillion.kits.turf.TurfConstants
import ai.nextbillion.kits.turf.TurfConversion
import ai.nextbillion.kits.turf.TurfMeasurement
import ai.nextbillion.kits.turf.TurfMisc
import ai.nextbillion.kits.turf.TurfTransformation
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** NBKitsFlutterPlugin */
class NBKitsFlutterPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "nb_kits_flutter")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "nbKits/along" -> {
        val arguments = call.arguments as? Map<*, *>
        arguments?.let { it ->
          val line: List<List<Double>> = it["line"] as List<List<Double>>
          val distance: Double = it["distance"] as Double
          val points = line.map { Point.fromLngLat(it[0], it[1]) }
          val lineString = LineString.fromLngLats(points)
          val along = TurfMeasurement.along(lineString, distance, TurfConstants.UNIT_METERS)
          result.success(along.coordinates())
          return
        }
        result.success(null)

      }

      "nbKits/bearing" -> {
        val arguments = call.arguments as? Map<*, *>
        arguments?.let { it ->
          val point1: List<Double> = it["point1"] as List<Double>
          val point2: List<Double> = it["point2"] as List<Double>
          val bearing = TurfMeasurement.bearing(
            Point.fromLngLat(point1[0], point1[1]),
            Point.fromLngLat(point2[0], point2[1])
          )
          result.success(bearing)
          return
        }
        result.success(null) // Replace with actual result
      }

      "nbKits/circle" -> {
        val arguments = call.arguments as? Map<*, *>
        arguments?.let { it ->
          val center: List<Double> = it["center"] as List<Double>
          val radius: Double = it["radius"] as Double
          val steps: Int = it["steps"] as Int
          val circle = TurfTransformation.circle(
            Point.fromLngLat(center[0], center[1]),
            radius,
            steps,
            TurfConstants.UNIT_METERS
          )
          if (circle.coordinates().isNotEmpty()) {
            val coors = circle.coordinates()[0].map { point ->
              point.coordinates()
            }
            result.success(coors)
            return
          }

        }
        result.success(null)
      }

      "nbKits/degreesToRadians" -> {
        val arguments = call.arguments as? Map<*, *>
        arguments?.let { it ->
          val degrees: Double = it["degrees"] as Double
          val radians = TurfConversion.degreesToRadians(degrees)
          result.success(radians)
          return
        }
        result.success(null)
      }

      "nbKits/destination" -> {
        val arguments = call.arguments as? Map<*, *>
        arguments?.let { it ->
          val point: List<Double> = it["point"] as List<Double>
          val distance: Double = it["distance"] as Double
          val bearing: Double = it["bearing"] as Double
          val destination = TurfMeasurement.destination(
            Point.fromLngLat(point[0], point[1]),
            distance,
            bearing,
            TurfConstants.UNIT_METERS
          )
          result.success(destination.coordinates())
          return
        }
        result.success(null)
      }

      "nbKits/distance" -> {
        val arguments = call.arguments as? Map<*, *>
        arguments?.let { it ->
          val point1: List<Double> = it["point1"] as List<Double>
          val point2: List<Double> = it["point2"] as List<Double>
          val distance = TurfMeasurement.distance(
            Point.fromLngLat(point1[0], point1[1]),
            Point.fromLngLat(point2[0], point2[1]),
            TurfConstants.UNIT_METERS
          )
          result.success(distance)
          return
        }
        result.success(null)
      }

      "nbKits/length" -> {
        val arguments = call.arguments as? Map<*, *>
        arguments?.let { it ->
          val line: List<List<Double>> = it["points"] as List<List<Double>>
          val points = line.map { Point.fromLngLat(it[0], it[1]) }
          val lineString = LineString.fromLngLats(points)
          val length = TurfMeasurement.length(lineString, TurfConstants.UNIT_METERS)
          result.success(length)
          return
        }
        result.success(null)
      }

      "nbKits/lineSlice" -> {
        val arguments = call.arguments as? Map<*, *>
        arguments?.let { it ->
          val line: List<List<Double>> = it["line"] as List<List<Double>>
          val start: List<Double> = it["start"] as List<Double>
          val stop: List<Double> = it["stop"] as List<Double>
          val points = line.map { Point.fromLngLat(it[0], it[1]) }
          val lineString = LineString.fromLngLats(points)
          val lineSlice = TurfMisc.lineSlice(Point.fromLngLat(start[0], start[1]), Point.fromLngLat(stop[0], stop[1]), lineString)
          result.success(lineSlice.coordinates())
          return
        }
        result.success(null)
      }

      "nbKits/lineSliceAlong" -> {
        val arguments = call.arguments as? Map<*, *>
        arguments?.let { it ->
          val line: List<List<Double>> = it["line"] as List<List<Double>>
          val start: Double = it["starDist"] as Double
          val stop: Double = it["stopDist"] as Double
          val points = line.map { Point.fromLngLat(it[0], it[1]) }
          val lineString = LineString.fromLngLats(points)
          val lineSliceAlong = TurfMisc.lineSliceAlong(lineString, start, stop, TurfConstants.UNIT_METERS)
          result.success(lineSliceAlong.coordinates())
          return
        }
        result.success(null)
      }

      "nbKits/nearestPoint" -> {
        val arguments = call.arguments as? Map<*, *>
        arguments?.let { it ->
          val point: List<Double> = it["targetPoint"] as List<Double>
          val points: List<List<Double>> = it["points"] as List<List<Double>>
          val nearestPoint = TurfClassification.nearestPoint(
            Point.fromLngLat(point[0], point[1]),
            points.map { Point.fromLngLat(it[0], it[1]) }
          )
          result.success(nearestPoint.coordinates())
          return
        }
        result.success(null)
      }

      "nbKits/radiansToDegrees" -> {
        val arguments = call.arguments as? Map<*, *>
        arguments?.let { it ->
          val radians: Double = it["radians"] as Double
          val degrees = TurfConversion.radiansToDegrees(radians)
          result.success(degrees)
          return
        }
        result.success(null)
      }

      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
