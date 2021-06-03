import 'dart:async';
import 'package:customer_app/services/maps_services/maps_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:customer_app/models/maps/address.dart';
import 'package:customer_app/models/maps/direction_details.dart';
import 'package:customer_app/screens/dash_board/profile/profile_body.dart';
import 'package:customer_app/widgets/progress_Dialog.dart';

class PolyLineProvider extends ChangeNotifier {

  DirectionDetails tripDirectionDetails;
  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};
  Marker initialLocMarker;
  //BitmapDescriptor mapMarker;

  void resetPolyLine() {
    polylineSet.clear();
    markersSet.clear();
    circlesSet.clear();
    pLineCoordinates.clear();
    initialLocMarker = null;
    notifyListeners();
  }


  Future<void> getPlaceDirection(context, Address initialPosition, Address finalPosition, GoogleMapController _googleMapController, BitmapDescriptor startMapMarker, BitmapDescriptor destinationMapMarker) async {


    print("initial position descriptor:: " + initialPosition.descriptor + "initial position name" + initialPosition.placeName);
    print("final position:: " + finalPosition.descriptor + finalPosition.placeName);
    var initialLatLng = LatLng(initialPosition.latitude, initialPosition.longitude);
    var finalLatLng = LatLng(finalPosition.latitude, finalPosition.longitude);

    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
            message:
            currentLang == "en" ? "Please wait.." : "انتظر قليلا...."));

    var details = await MapsApiService.obtainPlaceDirectionDetails(
        initialLatLng, finalLatLng);

      tripDirectionDetails = details;

    Navigator.pop(context);

    print("This is Encoded Points ::");
    print(details.encodedPoints);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolylinePointsResult =
    polylinePoints.decodePolyline(details.encodedPoints);

    pLineCoordinates.clear();

    if (decodedPolylinePointsResult.isNotEmpty) {
      decodedPolylinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }
    polylineSet.clear();

      Polyline polyline = Polyline(
        color: Theme.of(context).primaryColor,
        polylineId: PolylineId("PolylineID"),
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );
      polylineSet.add(polyline);

    LatLngBounds latLngBounds;

    if (initialLatLng.latitude > finalLatLng.latitude &&
        initialLatLng.longitude > finalLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: finalLatLng, northeast: initialLatLng);
    } else if (initialLatLng.longitude > finalLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(initialLatLng.latitude, finalLatLng.longitude),
          northeast: LatLng(finalLatLng.latitude, initialLatLng.longitude));
    } else if (initialLatLng.latitude > finalLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(finalLatLng.latitude, initialLatLng.longitude),
          northeast: LatLng(initialLatLng.latitude, finalLatLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: initialLatLng, northeast: finalLatLng);
    }

    _googleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    //String initialSnippet = initialPosition.descriptor + " location";
    initialLocMarker = Marker(
        icon: startMapMarker,
        infoWindow:
        InfoWindow(title: initialPosition.placeName,
            //snippet: initialSnippet
        ),
        position: initialLatLng,
        markerId: MarkerId("winchId"));

   Marker finalLocMarker = Marker(
        icon: destinationMapMarker,
        infoWindow:
        InfoWindow(title: finalPosition.placeName, snippet: "PickUp location"),
        position: finalLatLng,
        markerId: MarkerId("pickUpId"));

      markersSet.add(initialLocMarker);
      markersSet.add(finalLocMarker);

    Circle startLocCircle = Circle(
      fillColor: Colors.blue,
      center: initialLatLng,
      radius: 12.0,
      strokeWidth: 4,
      strokeColor: Colors.blue,
      circleId: CircleId("startId"),
    );

    Circle endLocCircle = Circle(
      fillColor: Theme.of(context).hintColor,
      center: finalLatLng,
      radius: 12.0,
      strokeWidth: 4,
      strokeColor: Theme.of(context).hintColor,
      circleId: CircleId("endId"),
    );

      circlesSet.add(startLocCircle);
      circlesSet.add(endLocCircle);

      print("polyline");
      notifyListeners();

  }


  Future<void> updateMarkerPos(context, LatLng newLatLngPos, BitmapDescriptor updateMapMarker, Address finalPos ) async {
    markersSet.remove(initialLocMarker);
    var finalLatLng = LatLng(finalPos.latitude, finalPos.longitude);
    var details = await MapsApiService.obtainPlaceDirectionDetails(
        newLatLngPos, finalLatLng);

    tripDirectionDetails = details;

    initialLocMarker = Marker(
        icon: updateMapMarker,
        position: newLatLngPos,
        markerId: MarkerId("endId"));

    markersSet.add(initialLocMarker);


    notifyListeners();
  }

  }
