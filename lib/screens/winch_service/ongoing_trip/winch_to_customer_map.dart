import 'dart:async';
import 'package:customer_app/local_db/customer_info_db.dart';
import 'package:customer_app/models/maps/direction_details.dart';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/provider/winch_request/winch_request_provider.dart';
import 'package:customer_app/services/maps_services/maps_services.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:customer_app/widgets/progress_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'accepted_winch_driver_sheet.dart';

class WinchToCustomer extends StatefulWidget {
  static String routeName = '/WinchToCustomer';
  @override
  _WinchToCustomerState createState() => _WinchToCustomerState();
}

class _WinchToCustomerState extends State<WinchToCustomer> {
  String currentLang = loadCurrentLangFromDB();
  String fname = loadFirstNameFromDB();
  String jwtToken = loadJwtTokenFromDB();

  @override
  void initState() {
    super.initState();
    Provider.of<WinchRequestProvider>(context, listen: false)
        .trackWinchDriver();
  }

  Completer<GoogleMapController> _completerGoogleMap = Completer();
  GoogleMapController _googleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  DirectionDetails tripDirectionDetails;

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var initialPos =
        Provider.of<MapsProvider>(context, listen: false).pickUpLocation;

    final CameraPosition _initialPosition = CameraPosition(
      target: LatLng(initialPos.latitude, initialPos.longitude),
      zoom: 15.4746,
    );

    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: [
            // Map
            Container(
              //height: size.height * 0.77,
              height: size.height,
              child: GoogleMap(
                  initialCameraPosition: _initialPosition,
                  mapType: MapType.normal,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  mapToolbarEnabled: true,
                  polylines: polylineSet,
                  markers: markersSet,
                  circles: circlesSet,
                  onMapCreated: (GoogleMapController controller) {
                    _completerGoogleMap.complete(controller);
                    _googleMapController = controller;
                    getPlaceDirection(context);
                  }),
            ),

            AcceptedWinchDriverSheet(),
          ],
        ),
      ),
    );
  }

  Future<void> getPlaceDirection(context) async {
    var initialPos =
        Provider.of<MapsProvider>(context, listen: false).dropOffLocation;
    var finalPos =
        Provider.of<MapsProvider>(context, listen: false).pickUpLocation;

    var winchLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var pickUpLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
            message:
                currentLang == "en" ? "Please wait.." : "انتظر قليلا...."));

    var details = await MapsApiService.obtainPlaceDirectionDetails(
        winchLatLng, pickUpLatLng);

    setState(() {
      tripDirectionDetails = details;
    });

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

    setState(() {
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
    });

    LatLngBounds latLngBounds;

    if (winchLatLng.latitude > pickUpLatLng.latitude &&
        winchLatLng.longitude > pickUpLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: pickUpLatLng, northeast: winchLatLng);
    } else if (winchLatLng.longitude > pickUpLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(winchLatLng.latitude, pickUpLatLng.longitude),
          northeast: LatLng(pickUpLatLng.latitude, winchLatLng.longitude));
    } else if (winchLatLng.latitude > pickUpLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickUpLatLng.latitude, winchLatLng.longitude),
          northeast: LatLng(winchLatLng.latitude, pickUpLatLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: winchLatLng, northeast: pickUpLatLng);
    }

    _googleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker winchLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow:
            InfoWindow(title: initialPos.placeName, snippet: "Winch location"),
        position: winchLatLng,
        markerId: MarkerId("winchId"));

    Marker pickUpLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow:
            InfoWindow(title: finalPos.placeName, snippet: "PickUp location"),
        position: pickUpLatLng,
        markerId: MarkerId("pickUpId"));

    setState(() {
      markersSet.add(winchLocMarker);
      markersSet.add(pickUpLocMarker);
    });

    Circle winchLocCircle = Circle(
      fillColor: Colors.blue,
      center: winchLatLng,
      radius: 12.0,
      strokeWidth: 4,
      strokeColor: Colors.blue,
      circleId: CircleId("winchId"),
    );

    Circle pickUpLocCircle = Circle(
      fillColor: Theme.of(context).hintColor,
      center: pickUpLatLng,
      radius: 12.0,
      strokeWidth: 4,
      strokeColor: Theme.of(context).hintColor,
      circleId: CircleId("pickUpId"),
    );

    setState(() {
      circlesSet.add(winchLocCircle);
      circlesSet.add(pickUpLocCircle);
    });
  }
}
