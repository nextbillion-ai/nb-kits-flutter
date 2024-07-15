import 'package:flutter/material.dart';
import 'package:nb_maps_flutter/nb_maps_flutter.dart';

import 'maps_circle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {


  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const String accessKey = String.fromEnvironment("ACCESS_KEY");

  @override
  void initState() {
    super.initState();
    NextBillion.initNextBillion(accessKey);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const MapsCircle(),
      ),
    );
  }
}
