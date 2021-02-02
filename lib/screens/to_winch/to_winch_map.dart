import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class ToWinchMap extends StatelessWidget {
  static String routeName = '/ToWinchMap';
  Completer<GoogleMapController> _completerGoogleMap = Completer();
  GoogleMapController _googleMapController;
  Position currentPosition;
  var geoLocator = Geolocator();

  void locatePosition() async
  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = new CameraPosition(target: latLatPosition, zoom: 15.5);
    _googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  final CameraPosition _initialPosition =
        CameraPosition(target: LatLng(31.2001, 29.9187),
          zoom: 15.4746,
        );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children :[
       GoogleMap(
        initialCameraPosition: _initialPosition,
        mapType: MapType.satellite,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,

         onMapCreated: (GoogleMapController controller)
           {
             _completerGoogleMap.complete(controller);
             _googleMapController = controller;
             locatePosition();
           }
      ),
      ],
    ),
    );
  }
}
