import 'package:customer_app/local_db/customer_info_db.dart';
import 'package:customer_app/localization/localization_constants.dart';
import 'package:customer_app/models/maps/direction_details.dart';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/screens/to_winch/distination_search/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'completing_request/request_screen.dart';

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
  double searchContainerHeight = 180.0;

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(31.2001, 29.9187),
    zoom: 15.4746,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<MapsProvider>(
      builder: (context, val, child)=> Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: [
            // Map
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.04,
                bottom: 180.0,
              ),
              child: Container(
                //height: size.height * 0.77,
                height: size.height - (size.height * 0.04),
                child: GoogleMap(
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
                    }),
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: AnimatedSize(
                vsync: this,
                curve: Curves.bounceIn,
                duration: new Duration(milliseconds: 160),
                child: Container(
                  //height: size.height * 0.20,
                  height: searchContainerHeight,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.0),
                        topRight: Radius.circular(18.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 16.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ],
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
                        SizedBox(height: size.height * 0.02),
                        GestureDetector(
                          onTap: () async {
                            var res = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchScreen()));
                            if (res == "obtainDirection") {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RequestScreen()));
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.08),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(5.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 6.0,
                                  spreadRadius: 0.5,
                                  offset: Offset(0.7, 0.7),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.02,
                                vertical: size.height * 0.006,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    getTranslated(
                                        context, "enter your destination here"),
                                    style: Theme.of(context).textTheme.bodyText2,
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
    );
  }
}
