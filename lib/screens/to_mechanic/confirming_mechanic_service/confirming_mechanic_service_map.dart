import 'dart:async';
import 'package:customer_app/models/mechanic_request/confirm_mechanic_service_model.dart';
import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/provider/mechanic_request/mechnic_request_provider.dart';
import 'package:customer_app/provider/mechanic_services/mechanic_services_cart.dart';
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
    return Consumer4<MapsProvider, MechanicRequestProvider, CustomerCarProvider,
        MechanicServicesCartProvider>(
      builder: (context, mapsProvider, mechanicRequestProvider,
              customerCarProvider, mechanicServicesCartProvider, child) =>
          Scaffold(
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
                  onMapCreated: (GoogleMapController controller) async {
                    _completerGoogleMap.complete(controller);
                    mechanicRequestProvider.isConfirmingMechanicMapReady = true;
                    mapsProvider.googleMapController = controller;
                    await mapsProvider.locatePosition(context);
                    mechanicRequestProvider.confirmMechanicServiceRequestModel
                        .carId = customerCarProvider.selectedCar;
                    mechanicRequestProvider.confirmMechanicServiceRequestModel
                            .intialDiagnosis =
                        mechanicServicesCartProvider.combinedCart;
                    mechanicRequestProvider.confirmMechanicServiceRequestModel
                            .pickupLocationLat =
                        mapsProvider.pickUpLocation.latitude.toString();
                    mechanicRequestProvider.confirmMechanicServiceRequestModel
                            .pickupLocationLong =
                        mapsProvider.pickUpLocation.longitude.toString();
                    mechanicRequestProvider
                        .confirmMechanicServiceRequestModel.estimatedTime = "2";
                    mechanicRequestProvider
                            .confirmMechanicServiceRequestModel.estimatedFare =
                        mechanicServicesCartProvider.finalFare.toString();

                    //     ConfirmMechanicServiceRequestModel(
                    //   carId: customerCarProvider.selectedCar,
                    //   pickupLocationLat:
                    //       mapsProvider.pickUpLocation.latitude.toString(),
                    //   pickupLocationLong:
                    //       mapsProvider.pickUpLocation.longitude.toString(),
                    //   intialDiagnosis: mechanicServicesCartProvider
                    //       .breakDownListSelectedItems
                    //       .elementAt(0)
                    //       .id,
                    // );
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
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Container(
              //     height: size.height * 0.9,
              //     width: MediaQuery.of(context).size.width * 1,
              //     decoration: new BoxDecoration(
              //       gradient: new LinearGradient(
              //         end: Alignment.center,
              //         begin: Alignment.bottomCenter,
              //         colors: <Color>[
              //           Colors.white,
              //           Colors.white.withOpacity(0.0)
              //         ],
              //       ),
              //       borderRadius:
              //           BorderRadiusDirectional.all(Radius.circular(10)),
              //     ),
              //   ),
              // ),
              ConfirmingMechanicServiceSheet(),
            ],
          ),
        ),
      ),
    );
  }
}
