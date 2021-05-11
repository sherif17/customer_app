import 'package:customer_app/DataHandler/appData.dart';
import 'package:customer_app/localization/localization_constants.dart';
import 'distination_search/search_screen.dart';
import 'package:customer_app/services/maps_services/maps_services.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:customer_app/widgets/progress_Dialog.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:customer_app/services/api_services.dart';
import 'package:provider/provider.dart';

class ToWinchMap extends StatefulWidget {
  @override
  _ToWinchState createState() => _ToWinchState();
}

class _ToWinchState extends State<ToWinchMap> {
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

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Position currentPosition;
  var geoLocator = Geolocator();

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  void locatePosition(context) async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = new CameraPosition(target: latLatPosition, zoom: 15.5);
    _googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await MapsApiService.searchCoordinateAddress(position, context);
    print("This is your address:: " + address);
  }

  bool buttonState = true;

  final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(31.2001, 29.9187),
    zoom: 15.4746,
  );
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          //Padding(
          //padding: const EdgeInsets.only(bottom: 190.0),
          Column(
            children: [
              //Padding(
              //padding: const EdgeInsets.only(bottom: 190.0),
              //child:
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.03,
                ),
                child: Container(
                  height: size.height * 0.77,
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
                        locatePosition(context);
                      }),
                ),
              ),
              //  ),
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Container(
                  height: size.height * 0.20,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
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
                        horizontal: size.width * 0.02, vertical: size.height * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.006),
                        Text(getTranslated(context, "where you want to go") + fname,
                            style: Theme.of(context).textTheme.headline2),
                        SizedBox(height: size.height * 0.02),
                        GestureDetector(
                          onTap: () async {
                            var res = await Navigator.push(
                                context, MaterialPageRoute(builder: (context) => SearchScreen()));
                            if (res == "obtainDirection") {
                              await getPlaceDirection(context);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: size.width * 0.08),
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
                                    getTranslated(context, "enter your destination here"),
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
// car cash and request
/*
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 17.0),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          color: Theme.of(context).hintColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                                children: [
                                  Image.asset("assets/images/women_truck.jpg", height: 70.0, width: 80.0,),
                                  SizedBox(width: 16.0,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Car", style: Theme.of(context).textTheme.bodyText2,),
                                      Text("10Km", style: Theme.of(context).textTheme.bodyText1,),

                                    ],
                                  ),

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
                            child: RaisedButton(
                             onPressed: ()
                             {
                               print("clicked");

                             },
                             color: Theme.of(context).primaryColor,
                             child: Padding(
                               padding: EdgeInsets.all(17.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Text("Request", style: Theme.of(context).textTheme.button,),
                                   Icon(Icons.car_repair, color: Theme.of(context).accentColor, size: 26.0,)
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

 */
            ],
          )
          //),

          //locationBottomSheet(),
        ],
      ),
    );
  }

  Future<void> getPlaceDirection(context) async {
    var initialPos = Provider.of<AppData>(context, listen: false).pickUpLocation;
    var finalPos = Provider.of<AppData>(context, listen: false).dropOffLocation;

    var pickUpLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var dropOffLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    showDialog(
        context: context,
        builder: (BuildContext context) =>
            ProgressDialog(message: currentLang == "en" ? "Please wait.." : "انتظر قليلا...."));

    var details = await MapsApiService.obtainPlaceDirectionDetails(pickUpLatLng, dropOffLatLng);

    Navigator.pop(context);

    print("This is Encoded Points ::");
    print(details.encodedPoints);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolylinePointsResult =
        polylinePoints.decodePolyline(details.encodedPoints);

    pLineCoordinates.clear();

    if (decodedPolylinePointsResult.isNotEmpty) {
      decodedPolylinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
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
      latLngBounds = LatLngBounds(southwest: dropOffLatLng, northeast: pickUpLatLng);
    } else if (pickUpLatLng.longitude > dropOffLatLng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude),
          northeast: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude));
    } else if (pickUpLatLng.latitude > dropOffLatLng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(dropOffLatLng.latitude, pickUpLatLng.longitude),
          northeast: LatLng(pickUpLatLng.latitude, dropOffLatLng.longitude));
    } else {
      latLngBounds = LatLngBounds(southwest: pickUpLatLng, northeast: dropOffLatLng);
    }

    _googleMapController.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70));

    Marker pickUpLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: InfoWindow(title: initialPos.placeName, snippet: "My location"),
        position: pickUpLatLng,
        markerId: MarkerId("pickUpId"));

    Marker dropOffLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: InfoWindow(title: finalPos.placeName, snippet: "DropOff location"),
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
