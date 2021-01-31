import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ToWinchMap extends StatelessWidget {
  static String routeName = '/ToWinchMap';
  GoogleMapController _googleMapController;
  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(41.40338, 2.17403));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        mapType: MapType.satellite,
      ),
    );
  }
}
