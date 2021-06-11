import 'dart:async';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/screens/to_mechanic/confirming_mechanic_service/confirming_mechanic_service_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ConfirmingMechanicServiceMap extends StatefulWidget {
  static String routeName = '/ConfirmingMechanicServiceMap';
  const ConfirmingMechanicServiceMap({key}) : super(key: key);

  @override
  _ConfirmingMechanicServiceMapState createState() =>
      _ConfirmingMechanicServiceMapState();
}

class _ConfirmingMechanicServiceMapState
    extends State<ConfirmingMechanicServiceMap> {
  Completer<GoogleMapController> _completerGoogleMap = Completer();

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Position currentPosition;

  var geoLocator = Geolocator();

  double bottomPaddingOfMap = 0;

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(31.2001, 29.9187),
    zoom: 15.4746,
  );

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<MapsProvider>(
      builder: (context, val, child) => Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: Stack(
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
                  //polylines: polylineSet,
                  //markers: markersSet,
                  //circles: circlesSet,
                  onMapCreated: (GoogleMapController controller) {
                    _completerGoogleMap.complete(controller);
                    val.googleMapController = controller;
                    val.locatePosition(context);
                    // Provider.of<WinchRequestProvider>(context, listen: false)
                    //     .resetAllFlags();
                    // print(
                    //     "shearching Status :${Provider.of<WinchRequestProvider>(context, listen: false).STATUS_SEARCHING}");
                  }),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      end: Alignment.center,
                      begin: Alignment.topCenter,
                      colors: <Color>[
                        Colors.white,
                        Colors.white.withOpacity(0)
                      ],
                    ),
                    borderRadius:
                        BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: size.height * 0.9,
                  width: MediaQuery.of(context).size.width * 0.09,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      end: Alignment.center,
                      begin: Alignment.centerLeft,
                      colors: <Color>[
                        Colors.white,
                        Colors.white.withOpacity(0.0)
                      ],
                    ),
                    borderRadius:
                        BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: size.height * 0.9,
                  width: MediaQuery.of(context).size.width * 0.08,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      end: Alignment.center,
                      begin: Alignment.centerRight,
                      colors: <Color>[
                        Colors.white,
                        Colors.white.withOpacity(0.0)
                      ],
                    ),
                    borderRadius:
                        BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: size.height * 0.9,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                      end: Alignment.center,
                      begin: Alignment.bottomCenter,
                      colors: <Color>[
                        Colors.white,
                        Colors.white.withOpacity(0.0)
                      ],
                    ),
                    borderRadius:
                        BorderRadiusDirectional.all(Radius.circular(10)),
                  ),
                ),
              ),
              ConfirmingMechanicServiceSheet(),
            ],
          ),
        ),
      ),
    );
  }
}
