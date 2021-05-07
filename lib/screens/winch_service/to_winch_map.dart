import 'dart:ui';

import 'package:customer_app/local_db/customer_info_db.dart';
import 'package:customer_app/localization/localization_constants.dart';
import 'package:customer_app/models/maps/direction_details.dart';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/screens/winch_service/confirming_winch_request/request_screen.dart';
import 'package:customer_app/screens/winch_service/distination_search/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:customer_app/provider/winch_request/winch_request_provider.dart';

class ToWinchMap extends StatefulWidget {
  static String routeName = '/toWinchMap';
  @override
  _ToWinchState createState() => _ToWinchState();
}

class _ToWinchState extends State<ToWinchMap> with TickerProviderStateMixin {
  String currentLang = loadCurrentLangFromDB();
  String fname = loadFirstNameFromDB();

  @override
  void initState() {
    super.initState();
    // getCurrentPrefData();
  }

  @override
  Completer<GoogleMapController> _completerGoogleMap = Completer();

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  DirectionDetails tripDirectionDetails;

  Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;
  //double searchContainerHeight = 180.0;

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(31.2001, 29.9187),
    zoom: 15.4746,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<MapsProvider>(
      builder: (context, val, child) => SafeArea(
        child: Scaffold(
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
                  //polylines: polylineSet,
                  //markers: markersSet,
                  //circles: circlesSet,
                  onMapCreated: (GoogleMapController controller) {
                    _completerGoogleMap.complete(controller);
                    val.googleMapController = controller;
                    val.locatePosition(context);
                    Provider.of<WinchRequestProvider>(context, listen: false)
                        .resetAllFlags();
                    print(
                        "shearching Status :${Provider.of<WinchRequestProvider>(context, listen: false).STATUS_SEARCHING}");
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
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedSize(
                  vsync: this,
                  curve: Curves.bounceIn,
                  duration: new Duration(milliseconds: 160),
                  child: Container(
                    height: size.height * 0.19,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.02,
                          vertical: size.height * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.006),
                          Text(
                              getTranslated(context, "where you want to go") +
                                  fname,
                              style: Theme.of(context).textTheme.headline2),
                          SizedBox(height: size.height * 0.01),
                          GestureDetector(
                            onTap: () async {
                              var res = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchScreen()));
                              if (res == "obtainDirection") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RequestScreen()));
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(color: Colors.grey),
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.all(Radius.circular(
                                    25)), // BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.02,
                                  vertical: size.height * 0.006,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      getTranslated(context,
                                          "enter your destination here"),
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                    Icon(
                                      Icons.search,
                                      color: Theme.of(context).hintColor,
                                    ),
                                    //SizedBox(width: size.width * 0.0001,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
