import 'dart:async';
import 'package:customer_app/local_db/customer_db/customer_info_db.dart';
import 'package:customer_app/models/maps/direction_details.dart';
import 'package:customer_app/models/winch_request/confirm_winch_service_model.dart';
import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/provider/maps_preparation/polyLineProvider.dart';
import 'package:customer_app/provider/winch_request/winch_request_provider.dart';
import 'package:customer_app/screens/dash_board/dash_board.dart';
import 'package:customer_app/screens/winch_service/to_winch_map.dart';
import 'package:customer_app/services/maps_services/maps_services.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    setCustomMarker();
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

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  DirectionDetails tripDirectionDetails;

  BitmapDescriptor startMapMarker;
  BitmapDescriptor destinationMapMarker;

  void setCustomMarker() async {
    startMapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/icons/Car.png');
    destinationMapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/icons/google-maps-car-icon.png');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var initialPos =
        Provider.of<MapsProvider>(context, listen: false).pickUpLocation;

    final CameraPosition _initialPosition = CameraPosition(
      target: LatLng(initialPos.latitude, initialPos.longitude),
      zoom: 15.4746,
    );
    return Consumer4<MapsProvider, WinchRequestProvider, CustomerCarProvider,
        PolyLineProvider>(
      builder: (context, MapsProvider, WinchRequestProvider,
              customerCarProvider, PolyLineProvider, child) =>
          Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: Stack(
            children: [
              // Map
              Container(
                height: size.height * 0.75,
                child: GoogleMap(
                    initialCameraPosition: _initialPosition,
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    mapToolbarEnabled: true,
                    polylines: PolyLineProvider.polylineSet,
                    markers: PolyLineProvider.markersSet,
                    circles: PolyLineProvider.circlesSet,
                    onMapCreated: (GoogleMapController controller) async {
                      _completerGoogleMap.complete(controller);
                      MapsProvider.googleMapController = controller;
                      controller = MapsProvider.googleMapController;
                      await PolyLineProvider.getPlaceDirection(
                        context: context,
                        initialPosition: MapsProvider.pickUpLocation,
                        finalPosition: MapsProvider.dropOffLocation,
                        googleMapController: MapsProvider.googleMapController,
                        startMapMarker: startMapMarker,
                        destinationMapMarker: destinationMapMarker,
                      );
                      // DirectionDetails tripDetails = MapsProvider.tripDirectionDetails;
                      MapsProvider.tripDirectionDetails =
                          PolyLineProvider.tripDirectionDetails;
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
                        // carId: Provider.of<CustomerCarProvider>(context,
                        //         listen: true)
                        //     .selectedItem,
                        estimatedDistance:
                            MapsProvider.tripDirectionDetails.distanceText,
                        estimatedFare: MapsApiService.calculateFares(
                                MapsProvider.tripDirectionDetails, context)
                            .toString(),
                        //MapsProvider.estimatedFare.toString(),
                        estimatedTime:
                            MapsProvider.tripDirectionDetails.durationText,
                      );
                      print(WinchRequestProvider.confirmWinchServiceRequestModel
                          .toJson());
                    }),
              ),

              RideBottomSheet(),
            ],
          ),
        ),
      ),
    );
  }
}
