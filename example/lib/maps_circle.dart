import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_kits_flutter/nb_kits_flutter.dart';
import 'package:nb_maps_flutter/nb_maps_flutter.dart';

class MapsCircle extends StatefulWidget {
  const MapsCircle();

  @override
  State createState() => MapsCircleState();
}

class MapsCircleState extends State<MapsCircle> {
  static const CameraPosition _kInitialPosition = CameraPosition(
    target: LatLng(-33.852, 151.211),
    zoom: 16.0,
  );

  NextbillionMapController? mapController;
  Fill? _selectedFill;
  int _fillCount = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NBMap(
            initialCameraPosition: _kInitialPosition,
            onMapCreated: onMapCreated,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
              onPressed: (_fillCount >= 1) ? null : _add,
              child: const Text('add'),
            ),
            TextButton(
              onPressed: (_selectedFill == null) ? null : _remove,
              child: const Text('remove'),
            ),
          ],
        ),
      ],
    );
  }

  void onMapCreated(NextbillionMapController controller) {
    mapController = controller;
    controller.onFillTapped.add(_onFillTapped);
  }

  void _onFillTapped(Fill fill) {
    setState(() {
      _selectedFill = fill;
    });
  }

  Future<List<LatLng>?> convertTurfPointsToPoints(
      TurfPoint center, double radius,
      {int steps = 128}) async {
    List<TurfPoint>? turfPoints =
        await TurfTransformation.circle(center, radius, steps: steps);
    return turfPoints
        ?.map((turfPoint) => LatLng(turfPoint.latitude, turfPoint.longitude))
        .toList();
  }

  void _add() async {
    List<TurfPoint>? turfPoints =
        await TurfTransformation.circle(const TurfPoint(-33.852, 151.211), 50);
    List<LatLng>? geometry = turfPoints
        ?.map((turfPoint) => LatLng(turfPoint.latitude, turfPoint.longitude))
        .toList();
    mapController!.addFill(
      FillOptions(
        geometry: [geometry!],
        fillOpacity: 0.5,
        fillColor: "#FF0000",
        fillOutlineColor: "#00FF00",
      ),
    );

    setState(() {
      _fillCount += 1;
    });
  }

  void _remove() {
    mapController!.removeFill(_selectedFill!);
    setState(() {
      _selectedFill = null;
      _fillCount -= 1;
    });
  }

  @override
  void dispose() {
    mapController?.onFillTapped.remove(_onFillTapped);
    super.dispose();
  }
}
