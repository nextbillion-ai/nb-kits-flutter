import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nb_kits_flutter/nb_kits_flutter.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('nbKitsFlutterChannel');

  final List<MethodCall> log = <MethodCall>[];

  setUp(() {
    log.clear();
  });

  testWidgets('along method', (WidgetTester tester) async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.along([Point(0.0, 0.0)], 100.0);
    expect(result, isNotNull);
    expect(result?.latitude, 0.0);
    expect(result?.longitude, 0.0);
  });

  testWidgets('bearing method', (WidgetTester tester) async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.bearing(Point(0.0, 0.0), Point(1.0, 1.0));
    expect(result, 44.99563645534486);
  });

  testWidgets('circle method', (WidgetTester tester) async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.circle(Point(0.0, 0.0), 100.0);
    expect(result, isNotNull);
    expect(result?.length, 65);
  });

  testWidgets('degreesToRadians method', (WidgetTester tester) async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.degreesToRadians(45.0);
    expect(result, 0.7853981633974483);
  });

  testWidgets('destination method', (WidgetTester tester) async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.destination(Point(0.0, 0.0), 100.0, 45.0);
    expect(result, isNotNull);
    expect(result?.latitude, 0.0006357168402045899);
    expect(result?.longitude, 0.0006357168402360003);
  });

  testWidgets('distance method', (WidgetTester tester) async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.distance(Point(0.0, 0.0), Point(1.0, 1.0));
    expect(result, 157298.7453847275);
  });


  testWidgets('length method', (WidgetTester tester) async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.length([Point(0.0, 0.0), Point(1.0, 1.0)]);
    expect(result, 157298.7453847275);
  });


  // testWidgets('lineSlice method', (WidgetTester tester) async {
  //   final platform = NBKitsFlutterMethodChannel();
  //   final result = await platform.lineSlice(Point(1.0, 2.0), Point(3.5, 4.5), [Point(5.0, 6.0), Point(7.0, 1.0)]);
  //   expect(result, isNotNull);
  //   expect(result?.length, 1);
  //   expect(result?[0].latitude, 0.0);
  //   expect(result?[0].longitude, 0.0);
  // });
  //
  // testWidgets('lineSliceAlong method', (WidgetTester tester) async {
  //   final platform = NBKitsFlutterMethodChannel();
  //   final result = await platform.lineSliceAlong([Point(2.0, 3.0), Point(4.0, 5.0)], 10.0, 5.0);
  //   expect(result, isNotNull);
  //   expect(result?.length, 1);
  //   expect(result?[0].latitude, 0.0);
  //   expect(result?[0].longitude, 0.0);
  // });


  testWidgets('nearestPoint method', (WidgetTester tester) async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.nearestPoint(Point(0.0, 0.0), [Point(1.0, 1.0)]);
    expect(result, isNotNull);
    expect(result?.latitude, 1.0);
    expect(result?.longitude, 1.0);
  });

  testWidgets('radiansToDegrees method', (WidgetTester tester) async {
    final platform = NBKitsFlutterMethodChannel();
    final result = await platform.radiansToDegrees(0.785398);
    expect(result, 44.99999063801584);
  });

}
