import 'dart:async';
import 'package:customer_app/DataHandler/appData.dart';
import 'package:customer_app/models/maps/direction_details.dart';
import 'package:customer_app/screens/dash_board/profile/profile_body.dart';
import 'package:customer_app/services/maps_services/maps_services.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:customer_app/widgets/divider.dart';
import 'package:customer_app/widgets/progress_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:customer_app/models/maps/address.dart';
import '../to_winch_map.dart';

class RequestScreen extends StatefulWidget {
  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  String currentLang;
  String fname;

  @override
  void initState() {
    super.initState();
    getCurrentPrefData();
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

  resetApp()
  async {
    setState(() {
      polylineSet.clear();
      markersSet.clear();
      circlesSet.clear();
      pLineCoordinates.clear();
    });
    var res = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ToWinchMap()));

    //locatePosition(context);
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var initialPos =
        Provider.of<AppData>(context, listen: false).pickUpLocation;


    final CameraPosition _initialPosition = CameraPosition(
      target: LatLng(initialPos.latitude, initialPos.longitude),
      zoom: 15.4746,
    );


    return Scaffold(
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
        height: size.height - ( size.height * 0.04),
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
            }
      ),

    ),

    ),

      rideBottomSheet(context),


    ],
      ),


    );


  }

  Future<void> getPlaceDirection(context) async {
    var initialPos =
        Provider.of<AppData>(context, listen: false).pickUpLocation;
    var finalPos = Provider.of<AppData>(context, listen: false).dropOffLocation;

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

  Padding rideBottomSheet(context) {
    Size size = MediaQuery.of(context).size;
    var pickUp =
        Provider.of<AppData>(context, listen: false).pickUpLocation.placeName;
    var dropOff = Provider.of<AppData>(context, listen: false).dropOffLocation.placeName;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.22,
        maxChildSize: 1.0,
        builder: (context, controller) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0),),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 16.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7,0.7),
                ),
              ],
            ),
            child: ListView.builder(
                itemCount: 1,
                controller: controller,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 17.0),
                    child: Column(
                      children: [

                        Padding(
                          padding: EdgeInsets.only(
                            left: size.width * 0.07,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.my_location ,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("From:"),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Text("$pickUp",
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        DividerWidget(),
                        SizedBox(height: 18.0),
                        Padding(
                          padding: EdgeInsets.only(
                            left: size.width * 0.07,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("To:"),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    "$dropOff",
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        DividerWidget(),
                        SizedBox(height: 8.0),
                        Text(
                          ((tripDirectionDetails != null) ? tripDirectionDetails.distanceText : ''),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(height: 12.0,),
                        Container(
                          width: double.infinity,
                          color: Theme.of(context).accentColor,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              children: [
                                //SizedBox(width: size.width* 0.12,),
                                Expanded(child: Container()),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Estimated duration", style: Theme.of(context).textTheme.bodyText2,
                                    ),
                                    Text(
                                      ((tripDirectionDetails != null) ? ' ${tripDirectionDetails.durationText}' : ''),
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                                Expanded(child: Container()),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Estimated fare", style: Theme.of(context).textTheme.bodyText2,
                                    ),
                                    Text(
                                      ((tripDirectionDetails != null) ? 'EGP ${MapsApiService.calculateFares(tripDirectionDetails)}' : ''),
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ],
                                ),
                                Expanded(child: Container()),


                              ],
                            ),
                          ),

                        ),
                        SizedBox(height: 20.0,),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              //Icon(FontAwesomeIcons.moneyCheckAlt, size: 18.0, color: Colors.black54,)
                              Icon(Icons.money, size: 18.0, color: Colors.black54,),
                              SizedBox(width: 16.0,),
                              Text("Cash"),
                              SizedBox(width: 6.0,),
                              Icon(Icons.keyboard_arrow_down, size: 16.0, color: Colors.black54,),
                            ],
                          ),
                        ),

                        SizedBox(height: 24.0,),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: OutlinedButton(
                            onPressed: ()
                            {
                              resetApp();
                            },
                            //color: Theme.of(context).accentColor,
                            child: Padding(
                              padding: EdgeInsets.all(17.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Cancel", style: Theme.of(context).textTheme.headline2,),
                                  Icon(Icons.close, color: Theme.of(context).primaryColorDark, size: 26.0,)
                                ],
                              ),
                            ),
                          ),
                        ),


                        SizedBox(height: 24.0,),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: RaisedButton(
                            onPressed: ()
                            {
                              //requestingSheet(context);
                              //displayRequestRideContainer();
                            },
                            color: Theme.of(context).primaryColor,
                            child: Padding(
                              padding: EdgeInsets.all(17.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Confirm Service", style: Theme.of(context).textTheme.button,),
                                  Icon(Icons.car_repair, color: Theme.of(context).accentColor, size: 26.0,)
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
              );
        },
            ),
          );
        },
      ),
    );
  }


}