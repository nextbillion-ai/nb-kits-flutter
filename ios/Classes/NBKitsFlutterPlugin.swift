import Flutter
import UIKit
import Turf
import CoreLocation

public class NBKitsFlutterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "nb_kits_flutter", binaryMessenger: registrar.messenger())
        let instance = NBKitsFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "nbKits/along":
            if let arguments = call.arguments as? [String: Any],
               let line = arguments["line"] as? [[Double]],
               let distance = arguments["distance"] as? Double {
                let points = line.map { CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0]) }
                let lineString = LineString(points)
                if let along = lineString.coordinateFromStart(distance: distance) {
                    result([along.latitude, along.longitude])
                    return
                }
                
            }
            result(nil)
            
        case "nbKits/bearing":
            if let arguments = call.arguments as? [String: Any],
               let point1 = arguments["point1"] as? [Double],
               let point2 = arguments["point2"] as? [Double] {
                let location1 = CLLocationCoordinate2D(latitude: point1[1], longitude: point1[0])
                let location2 = CLLocationCoordinate2D(latitude: point2[1], longitude: point2[0])
                let bearing = location1.direction(to: location2)
                result(bearing)
                return
            }
            result(nil)
            
        case "nbKits/circle":
            if let arguments = call.arguments as? [String: Any],
               let center = arguments["center"] as? [Double],
               let radius = arguments["radius"] as? Double,
               let steps = arguments["steps"] as? Int {
                let circle = circle(center: CLLocationCoordinate2D(latitude: center[1], longitude: center[0]), radius: radius, steps: steps)
                let coordinates = circle.map { point in
                    [point.longitude, point.latitude]
                }
                result(coordinates)
                return
            }
            result(nil)
            
            
        case "nbKits/degreesToRadians":
            if let arguments = call.arguments as? [String: Any],
               let degrees = arguments["degrees"] as? Double {
                let radians = degrees.toRadians()
                result(radians)
                return
            }
            result(nil)
            
        case "nbKits/destination":
            if let arguments = call.arguments as? [String: Any],
               let point = arguments["point"] as? [Double],
               let distance = arguments["distance"] as? Double,
               let bearing = arguments["bearing"] as? Double {
                let location = CLLocationCoordinate2D(latitude: point[1], longitude: point[0])
                let destination = location.coordinate(at: distance, facing: bearing)
                result([destination.longitude, destination.latitude])
                return
            }
            result(nil)
            
        case "nbKits/distance":
            if let arguments = call.arguments as? [String: Any],
               let point1 = arguments["point1"] as? [Double],
               let point2 = arguments["point2"] as? [Double] {
                let location1 = CLLocationCoordinate2D(latitude: point1[1], longitude: point1[0])
                let location2 = CLLocationCoordinate2D(latitude: point2[1], longitude: point2[0])
                let distance = location1.distance(to: location2)
                result(distance)
                return
            }
            result(nil)
            
    
        case "nbKits/length":
            if let arguments = call.arguments as? [String: Any],
               let line = arguments["points"] as? [[Double]] {
                let points = line.map { CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0]) }
                let lineString = LineString(points)
                result(lineString.distance())
                return
            }
            result(nil)
            
            
        case "nbKits/lineSlice":
            if let arguments = call.arguments as? [String: Any],
               let line = arguments["line"] as? [[Double]],
               let start = arguments["start"] as? [Double],
               let stop = arguments["stop"] as? [Double] {
                let points = line.map { CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0]) }
                let lineString = LineString(points)
                let startLocation = CLLocationCoordinate2D(latitude: start[1], longitude: start[0])
                let stopLocation = CLLocationCoordinate2D(latitude: stop[1], longitude: stop[0])
                let coordinates = lineString.sliced(from: startLocation, to: stopLocation)
                let sliced = coordinates.coordinates.map { [$0.longitude, $0.latitude] }
                result(sliced)
                return
            }
            result(nil)
            
        case "nbKits/lineSliceAlong":
            if let arguments = call.arguments as? [String: Any],
               let line = arguments["line"] as? [[Double]],
               let start = arguments["starDist"] as? Double,
               let stop = arguments["stopDist"] as? Double {
                let points = line.map { CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0]) }
                let lineString = LineString(points)
                if let startPoint = lineString.coordinateFromStart(distance: start) {
                    let distance = lineString.distance() - start - stop
                    let coordinates = lineString.trimmed(from: startPoint, distance: distance)
                    let trimmed = coordinates.coordinates.map { [$0.longitude, $0.latitude] }
                    result(trimmed)
                }
                return
            }
            result(nil)
            
            
        case "nbKits/nearestPoint":
            if let arguments = call.arguments as? [String: Any],
               let point = arguments["targetPoint"] as? [Double],
               let points = arguments["points"] as? [[Double]] {
                let location = CLLocationCoordinate2D(latitude: point[1], longitude: point[0])
                let lineString = LineString(points.map { CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0]) })
                if let nearestPoint = lineString.closestCoordinate(to: location) {
                    result([nearestPoint.coordinate.longitude, nearestPoint.coordinate.latitude])
                }
                return
            }
            result(nil)
            
        case "nbKits/radiansToDegrees":
            if let arguments = call.arguments as? [String: Any],
               let radians = arguments["radians"] as? Double {
                let degree = radians.toDegrees()
                result(degree)
                return
            }
            result(nil)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    func circle(center: CLLocationCoordinate2D, radius: Double, steps: Int) -> [CLLocationCoordinate2D] {
        var coordinates: [CLLocationCoordinate2D] = []
        for i in 0..<steps {
            let angle = Double(i) * 360.0 / Double(steps)
            let destination = center.coordinate(at: radius, facing: angle)
            coordinates.append(destination)
        }
        
        if coordinates.count > 0 {
            coordinates.append(coordinates[0])
        }
        return coordinates
    }
    
}
