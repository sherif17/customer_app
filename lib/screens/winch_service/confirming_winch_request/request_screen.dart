import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:customer_app/local_db/customer_info_db.dart';
import 'package:customer_app/models/maps/direction_details.dart';
import 'package:customer_app/models/winch_request/confirm_winch_service_model.dart';
import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/provider/winch_request/winch_request_provider.dart';
import 'package:customer_app/screens/dash_board/dash_board.dart';
import 'package:customer_app/screens/winch_service/ongoing_trip/winch_to_customer_map.dart';
import 'package:customer_app/screens/winch_service/to_winch_map.dart';
import 'package:customer_app/services/maps_services/maps_services.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:customer_app/widgets/divider.dart';
import 'package:customer_app/widgets/progress_Dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'confirming_ride _sheet.dart';

class RequestScreen extends StatefulWidget {
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  String currentLang = loadCurrentLangFromDB();
  String fname = loadFirstNameFromDB();
  String jwtToken = loadJwtTokenFromDB();

  resetApp() async {
    var res = await Navigator.pushNamedAndRemoveUntil(context,
        ToWinchMap.routeName, ModalRoute.withName(DashBoard.routeName));
  }

  Timer timer;
  @override
  void initState() {
    super.initState();
    //setCustomMarker();
    //getCurrentPrefData();
  }

  void getCurrentPrefData() {
    getPrefCurrentLang().then((value) {
      setState(() {
        currentLang = value;
      });
    });
    getPrefFirstName().then((value) {
      setState(() {
        fname = value;
      });
    });
    getPrefJwtToken().then((value) {
      jwtToken = value;
    });
  }

  @override
  Completer<GoogleMapController> _completerGoogleMap = Completer();
  GoogleMapController _googleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  DirectionDetails tripDirectionDetails;

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

/*
  BitmapDescriptor mapMarker;

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/icons/google-maps-car-icon.jpg');
  }

 */

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var initialPos =
        Provider.of<MapsProvider>(context, listen: false).pickUpLocation;

    final CameraPosition _initialPosition = CameraPosition(
      target: LatLng(initialPos.latitude, initialPos.longitude),
      zoom: 15.4746,
    );
    return SafeArea(
      child: Consumer3<MapsProvider, WinchRequestProvider, CustomerCarProvider>(
        builder: (context, MapsProvider, WinchRequestProvider,
                CustomerCarProvider, child) =>
            Scaffold(
          key: scaffoldKey,
          body: Stack(
            children: [
              // Map
              GoogleMap(
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
                  onMapCreated: (GoogleMapController controller) async {
                    _completerGoogleMap.complete(controller);
                    _googleMapController = controller;
                    await getPlaceDirection(context);
                    // DirectionDetails tripDetails = MapsProvider.tripDirectionDetails;
                    var pickUpLocation = MapsProvider.pickUpLocation;
                    var dropOffLocation = MapsProvider.dropOffLocation;
                    var pickUp = pickUpLocation.placeName;
                    var pickUpLong = pickUpLocation.longitude.toString();
                    var pickUpLat = pickUpLocation.latitude.toString();
                    var dropOff = dropOffLocation.placeName;
                    var dropOffLong = dropOffLocation.longitude.toString();
                    var dropOffLat = dropOffLocation.latitude.toString();

                    // WinchRequestProvider.confirmWinchServiceRequestModel.dropOffLocationLat=dropOffLat;
                    // WinchRequestProvider.confirmWinchServiceRequestModel.dropOffLocationLong=dropOffLong;
                    // WinchRequestProvider.confirmWinchServiceRequestModel.pickupLocationLat=pickUpLat;
                    // WinchRequestProvider.confirmWinchServiceRequestModel.pickupLocationLong=pickUpLong;
                    // WinchRequestProvider.confirmWinchServiceRequestModel.carId=CustomerCarProvider.customerOwnedCars.keyAt(0);
                    // WinchRequestProvider.confirmWinchServiceRequestModel.estimatedDistance= MapsProvider.tripDirectionDetails.distanceText;
                    // WinchRequestProvider.confirmWinchServiceRequestModel.estimatedFare= MapsProvider.estimatedFare.toString();
                    // WinchRequestProvider.confirmWinchServiceRequestModel.estimatedTime=MapsProvider.tripDirectionDetails.durationText;
                    WinchRequestProvider.confirmWinchServiceRequestModel =
                        new ConfirmWinchServiceRequestModel(
                      dropOffLocationLat: dropOffLat,
                      dropOffLocationLong: dropOffLong,
                      pickupLocationLat: pickUpLat,
                      pickupLocationLong: pickUpLong,
                      carId: CustomerCarProvider.customerOwnedCars.keyAt(0),
                      estimatedDistance:
                          MapsProvider.tripDirectionDetails.distanceText,
                      estimatedFare: MapsApiService.calculateFares(
                              MapsProvider.tripDirectionDetails, context)
                          .toString(), //MapsProvider.estimatedFare.toString(),
                      estimatedTime:
                          MapsProvider.tripDirectionDetails.durationText,
                    );
                    print(WinchRequestProvider.confirmWinchServiceRequestModel
                        .toJson());
                  }),

              RideBottomSheet(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getPlaceDirection(context) async {
    var initialPos =
        Provider.of<MapsProvider>(context, listen: false).pickUpLocation;
    var finalPos =
        Provider.of<MapsProvider>(context, listen: false).dropOffLocation;

    var pickUpLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var dropOffLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
            message:
                currentLang == "en" ? "Please wait.." : "انتظر قليلا...."));

    var details = await MapsApiService.obtainPlaceDirectionDetails(
        pickUpLatLng, dropOffLatLng);

    setState(() {
      tripDirectionDetails = details;
    });

    Provider.of<MapsProvider>(context, listen: false)
        .updateTripDirectionDetails(details);

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

    if (pickUpLatLng.latitude > dropOffLatLng.latitude &&
        pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
    } else if (pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude),
          northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude));
    } else if (pickUpLatLng.latitude > dropOffLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude),
          northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }

    _googleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow:
            InfoWindow(title: initialPos.placeName, snippet: "My location"),
        position: pickUpLatLng,
        markerId: MarkerId("pickUpId"));

    Marker dropOffLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        //icon: mapMarker,
        infoWindow:
            InfoWindow(title: finalPos.placeName, snippet: "DropOff location"),
        position: dropOffLatLng,
        markerId: MarkerId("dropOffId"));

    setState(() {
      markersSet.add(pickUpLocMarker);
      markersSet.add(dropOffLocMarker);
    });

    Circle pickUpLocCircle = Circle(
      fillColor: Colors.blue,
      center: pickUpLatLng,
      radius: 12.0,
      strokeWidth: 4,
      strokeColor: Colors.blue,
      circleId: CircleId("pickUpId"),
    );

    Circle dropOffLocCircle = Circle(
      fillColor: Theme.of(context).hintColor,
      center: dropOffLatLng,
      radius: 12.0,
      strokeWidth: 4,
      strokeColor: Theme.of(context).hintColor,
      circleId: CircleId("dropOffId"),
    );

    setState(() {
      circlesSet.add(pickUpLocCircle);
      circlesSet.add(dropOffLocCircle);
    });
  }
}
