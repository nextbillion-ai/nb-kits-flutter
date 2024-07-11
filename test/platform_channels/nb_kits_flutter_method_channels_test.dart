import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nb_kits_flutter/nb_kits_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('nb_kits_flutter');

  final List<MethodCall> log = <MethodCall>[];

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      log.add(methodCall);
      // Add mock responses for each method call if necessary
      switch (methodCall.method) {
        case 'nbKits/along':
          return [0, 0]; // mock response
        case 'nbKits/bearing':
          return 45.0; // mock response
        case 'nbKits/circle':
          return [
            [
              [0.0, 0.0]
            ]
          ]; // mock response
        case 'nbKits/convertLength':
          return 1.0; // mock response
        case 'nbKits/degreesToRadians':
          return 0.785398; // mock response
        case 'nbKits/destination':
          return [0.0, 0.0]; // mock response
        case 'nbKits/distance':
          return 1.0; // mock response
        case 'nbKits/inside':
          return true; // mock response
        case 'nbKits/length':
          return 1.0; // mock response
        case 'nbKits/lengthToDegrees':
          return 1.0; // mock response
        case 'nbKits/lengthToRadians':
          return 1.0; // mock response
        case 'nbKits/lineSlice':
          return [
            [0.0, 0.0]
          ]; // mock response
        case 'nbKits/lineSliceAlong':
          return [
            [0.0, 0.0]
          ]; // mock response
        case 'nbKits/midpoint':
          return [0.0, 0.0]; // mock response
        case 'nbKits/nearestPoint':
          return [0.0, 0.0]; // mock response
        case 'nbKits/radiansToDegrees':
          return 45.0; // mock response
        case 'nbKits/radiansToLength':
          return 1.0; // mock response
        default:
          return null;
      }
    });
    log.clear();
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('along method', () async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.along([TurfPoint(0.0, 0.0)], 100.0);
    expect(result, isNotNull);
    expect(result?.latitude, 0.0);
    expect(result?.longitude, 0.0);

    expect(
      log,
      <Matcher>[
        isMethodCall('nbKits/along', arguments: <String, dynamic>{
          'line': [
            [0.0, 0.0]
          ],
          'distance': 100.0,
        }),
      ],
    );
  });

  test('bearing method', () async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.bearing(TurfPoint(0.0, 0.0), TurfPoint(1.0, 1.0));
    expect(result, 45.0);

    expect(
      log,
      <Matcher>[
        isMethodCall('nbKits/bearing', arguments: <String, dynamic>{
          'point1': [0.0, 0.0],
          'point2': [1.0, 1.0],
        }),
      ],
    );
  });

  test('circle method', () async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.circle(TurfPoint(0.0, 0.0), 100.0);
    expect(result, isNotNull);
    expect(result?.length, 1);
    expect(result?.length, 1);
    expect(result?[0].latitude, 0.0);
    expect(result?[0].longitude, 0.0);

    expect(
      log,
      <Matcher>[
        isMethodCall('nbKits/circle', arguments: <String, dynamic>{
          'center': [0.0, 0.0],
          'radius': 100.0,
          'steps': 64,
        }),
      ],
    );
  });


  test('degreesToRadians method', () async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.degreesToRadians(45.0);
    expect(result, 0.785398);

    expect(
      log,
      <Matcher>[
        isMethodCall('nbKits/degreesToRadians', arguments: <String, dynamic>{
          'degrees': 45.0,
        }),
      ],
    );
  });

  test('destination method', () async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.destination(TurfPoint(0.0, 0.0), 100.0, 45.0);
    expect(result, isNotNull);
    expect(result?.latitude, 0.0);
    expect(result?.longitude, 0.0);

    expect(
      log,
      <Matcher>[
        isMethodCall('nbKits/destination', arguments: <String, dynamic>{
          'point': [0.0, 0.0],
          'distance': 100.0,
          'bearing': 45.0,
        }),
      ],
    );
  });

  test('distance method', () async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.distance(TurfPoint(0.0, 0.0), TurfPoint(1.0, 1.0));
    expect(result, 1.0);

    expect(
      log,
      <Matcher>[
        isMethodCall('nbKits/distance', arguments: <String, dynamic>{
          'point1': [0.0, 0.0],
          'point2': [1.0, 1.0],
        }),
      ],
    );
  });


  test('length method', () async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.length([TurfPoint(0.0, 0.0), TurfPoint(1.0, 1.0)]);
    expect(result, 1.0);

    expect(
      log,
      <Matcher>[
        isMethodCall('nbKits/length', arguments: <String, dynamic>{
          'points': [
            [0.0, 0.0],
            [1.0, 1.0]
          ],
        }),
      ],
    );
  });


  test('lineSlice method', () async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.lineSlice(TurfPoint(0.0, 0.0), TurfPoint(1.0, 1.0), [TurfPoint(0.0, 0.0), TurfPoint(1.0, 1.0)]);
    expect(result, isNotNull);
    expect(result?.length, 1);
    expect(result?[0].latitude, 0.0);
    expect(result?[0].longitude, 0.0);

    expect(
      log,
      <Matcher>[
        isMethodCall('nbKits/lineSlice', arguments: <String, dynamic>{
          'start': [0.0, 0.0],
          'stop': [1.0, 1.0],
          'line': [
            [0.0, 0.0],
            [1.0, 1.0]
          ]
        }),
      ],
    );
  });

  test('lineSliceAlong method', () async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.lineSliceAlong([TurfPoint(0.0, 0.0), TurfPoint(1.0, 1.0)], 0.0, 1.0);
    expect(result, isNotNull);
    expect(result?.length, 1);
    expect(result?[0].latitude, 0.0);
    expect(result?[0].longitude, 0.0);

    expect(
      log,
      <Matcher>[
        isMethodCall('nbKits/lineSliceAlong', arguments: <String, dynamic>{
          'line': [
            [0.0, 0.0],
            [1.0, 1.0]
          ],
          'starDist': 0.0,
          'stopDist': 1.0,
        }),
      ],
    );
  });

  test('nearestPoint method', () async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.nearestPoint(TurfPoint(0.0, 0.0), [TurfPoint(1.0, 1.0)]);
    expect(result, isNotNull);
    expect(result?.latitude, 0.0);
    expect(result?.longitude, 0.0);

    expect(
      log,
      <Matcher>[
        isMethodCall('nbKits/nearestPoint', arguments: <String, dynamic>{
          'targetPoint': [0.0, 0.0],
          'points': [
            [1.0, 1.0]
          ]
        }),
      ],
    );
  });

  test('radiansToDegrees method', () async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.radiansToDegrees(0.785398);
    expect(result, 45.0);

    expect(
      log,
      <Matcher>[
        isMethodCall('nbKits/radiansToDegrees', arguments: <String, dynamic>{
          'radians': 0.785398,
        }),
      ],
    );
  });

}
