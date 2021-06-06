import 'dart:async';
import 'package:customer_app/local_db/customer_db/customer_info_db.dart';
import 'package:customer_app/models/maps/address.dart';
import 'package:customer_app/models/maps/direction_details.dart';
import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/provider/maps_preparation/polyLineProvider.dart';
import 'package:customer_app/provider/winch_request/winch_request_provider.dart';
import 'package:flutter/material.dart';
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
    setCustomMarker();
  }

  Completer<GoogleMapController> _completerGoogleMap = Completer();
  //GoogleMapController _googleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  DirectionDetails tripDirectionDetails;


  Timer timer;
  double lat, lng;
  LatLng latLng;
  BitmapDescriptor startMapMarker;
  BitmapDescriptor destinationMapMarker;
  BitmapDescriptor secondMapStartMarker;
  BitmapDescriptor secondMapDestinationMarker;
  //Address winchPosition = Address(latitude: 31.236110220827165 , longitude: 29.948748010875686, descriptor: "winch location", placeName: "Allah a3lm");
  Address winchPosition = Address(latitude: 31.20684069999999 , longitude: 29.9237711, descriptor: "winch location", placeName: "Winch current Location");
  //LatLng winchPosition = LatLng(31.20684069999999, 29.9237711);


  void setCustomMarker() async {
    startMapMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(0.1,0.1)), 'assets/icons/empty_winch.png');
    destinationMapMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/icons/Car.png');

    secondMapStartMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/icons/google-maps-car-icon.png');
    secondMapDestinationMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(0.1,0.1)), 'assets/icons/winch_with_car.png');

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

    return Consumer4<MapsProvider, WinchRequestProvider, CustomerCarProvider, PolyLineProvider>(
      builder: (context, MapsProvider, WinchRequestProvider,
          CustomerCarProvider, PolyLineProvider, child) =>
        Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: Stack(
            children: [
              // Map
              Container(
                height: size.height * 0.77,
                //height: size.height,
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

                      await PolyLineProvider.getPlaceDirection(context, WinchRequestProvider.winchLocation, MapsProvider.pickUpLocation, MapsProvider.googleMapController, startMapMarker, destinationMapMarker);

                      int i = 5;
                      timer = Timer.periodic(
                          Duration(seconds: 5),
                              (timer) async {

                            print("timer loop");

                            print(i);
                            if (i == 5)
                            {
                              latLng = LatLng(WinchRequestProvider.winchLocation.latitude, WinchRequestProvider.winchLocation.longitude);

                             PolyLineProvider.updateMarkerPos(context, latLng, startMapMarker, MapsProvider.pickUpLocation);

                              print("hi");
                              i = i - 1;
                            }
                            else if (i == 4)
                              {
                                // lat = 31.206949;
                                // lng = 29.928185;
                                // latLng = LatLng(lat, lng);

                                latLng = LatLng(WinchRequestProvider.winchLocation.latitude, WinchRequestProvider.winchLocation.longitude);

                                PolyLineProvider.updateMarkerPos(context, latLng, startMapMarker, MapsProvider.pickUpLocation);


                                i = i - 1;
                              }
                            else if (i == 3)
                              {
                                //
                                // lat = 31.210219;
                                // lng = 29.936829;
                                // latLng = LatLng(lat, lng);


                                latLng = LatLng(WinchRequestProvider.winchLocation.latitude, WinchRequestProvider.winchLocation.longitude);
                                PolyLineProvider.updateMarkerPos(context, latLng, startMapMarker, MapsProvider.pickUpLocation);

                                i = i - 1;
                              }
                            else if (i == 2)
                              {
                                // lat = 31.217418;
                                // lng = 29.946520;
                                // latLng = LatLng(lat, lng);

                                latLng = LatLng(WinchRequestProvider.winchLocation.latitude, WinchRequestProvider.winchLocation.longitude);

                                PolyLineProvider.updateMarkerPos(context, latLng, startMapMarker, MapsProvider.pickUpLocation);

                                i = i - 1;
                              }
                            else if (i == 1)
                              {

                                lat = 31.224193;
                                lng = 29.949566;
                                latLng = LatLng(lat, lng);

                                PolyLineProvider.updateMarkerPos(context, latLng, startMapMarker, MapsProvider.pickUpLocation);

                                i = i - 1;

                              }
                            else if (i == 0)
                              {

                                PolyLineProvider.resetPolyLine();

                                await PolyLineProvider.getPlaceDirection(context, MapsProvider.pickUpLocation, MapsProvider.dropOffLocation, MapsProvider.googleMapController, secondMapStartMarker, secondMapDestinationMarker);

                                timer.cancel();
                              }

                          });

                      //PolyLineProvider.getPlaceDirection(context, MapsProvider.dropOffLocation, MapsProvider.pickUpLocation, MapsProvider.googleMapController);
                    }),
              ),

              AcceptedWinchDriverSheet(),
            ],
          ),
        ),
      ),
    );
  }

}
