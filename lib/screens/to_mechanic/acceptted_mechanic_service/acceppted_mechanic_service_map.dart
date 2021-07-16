import 'dart:async';

import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/provider/maps_preparation/polyLineProvider.dart';
import 'package:customer_app/provider/mechanic_request/mechnic_request_provider.dart';
import 'package:customer_app/screens/to_mechanic/acceptted_mechanic_service/acceptted_mechanic_service_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AcceptedMechanicServiceMap extends StatefulWidget {
  static String routeName = '/AcceptedMechanicServiceMap';
  const AcceptedMechanicServiceMap({key}) : super(key: key);

  @override
  _AcceptedMechanicServiceMapState createState() =>
      _AcceptedMechanicServiceMapState();
}

Completer<GoogleMapController> _completerGoogleMap = Completer();
//GoogleMapController _googleMapController;

GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

class _AcceptedMechanicServiceMapState
    extends State<AcceptedMechanicServiceMap> {
  @override
  void initState() {
    mechanicTracking(context);
    super.initState();
  }

  mechanicTracking(context) async {
    Provider.of<MechanicRequestProvider>(context, listen: false)
        .isNavigatedToAcceptedMap = true;
    await Provider.of<MechanicRequestProvider>(context, listen: false)
        .trackMechanic(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var initialPos =
        Provider.of<MapsProvider>(context, listen: false).pickUpLocation;
    // Provider.of<WinchRequestProvider>(context, listen: false)
    //     .updateWinchLocationAddress(winchPosition);
    final CameraPosition _initialPosition = CameraPosition(
      target: LatLng(initialPos.latitude, initialPos.longitude),
      zoom: 15.4746,
    );
    return Scaffold(
      body: Consumer4<MapsProvider, MechanicRequestProvider,
          CustomerCarProvider, PolyLineProvider>(
        builder: (context, mapsProvider, mechanicRequestProvider,
                customerCarProvider, polyLineProvider, child) =>
            SafeArea(
          //bottom: true,
          child: Stack(
            children: [
              Container(
                height: size.height * 0.77,
                child: GoogleMap(
                    initialCameraPosition: _initialPosition,
                    mapType: MapType.normal,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: true,
                    mapToolbarEnabled: true,
                    polylines: polyLineProvider.polylineSet,
                    markers: polyLineProvider.markersSet,
                    circles: polyLineProvider.circlesSet,
                    onMapCreated: (GoogleMapController controller) async {
                      // print(
                      //     "lord ${WinchRequestProvider.winchLocation.longitude}");
                      _completerGoogleMap.complete(controller);
                      mapsProvider.googleMapController = controller;
                      await polyLineProvider.getPlaceDirection(
                        destinationMapMarker:
                            mechanicRequestProvider.destinationMapMarker,
                        startMapMarker: mechanicRequestProvider.startMapMarker,
                        context: context,
                        finalPosition: mapsProvider.pickUpLocation,
                        googleMapController: mapsProvider.googleMapController,
                        initialPosition:
                            mechanicRequestProvider.mechanicLocation,
                      );
                      mechanicRequestProvider.isUpcomingRequestDataReady = true;
                    }),
              ),
              mechanicRequestProvider.isUpcomingRequestDataReady == true
                  ? AcceptedMechanicServiceSheet()
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
