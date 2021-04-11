import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:customer_app/DataHandler/appData.dart';
import 'package:customer_app/localization/localization_constants.dart';
import 'package:customer_app/models/maps/direction_details.dart';
import 'package:customer_app/screens/to_winch/distination_search/search_screen.dart';
import 'package:customer_app/services/maps_services/maps_services.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:customer_app/widgets/divider.dart';
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

class _ToWinchState extends State<ToWinchMap> with TickerProviderStateMixin {
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
  //Size size = MediaQuery.of(context).size;
  Completer<GoogleMapController> _completerGoogleMap = Completer();
  GoogleMapController _googleMapController;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  DirectionDetails tripDirectionDetails;

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  double rideDetailsContainerHeight = 0;
  double requestRideContainerHeight = 0;
  //double searchContainerHeight = size.height * 0.20 ;
  double searchContainerHeight = 180.0 ;

  bool drawerOpen = true;

  void displayRequestRideContainer()
  {
    setState(() {
      requestRideContainerHeight = 180.0;
      rideDetailsContainerHeight = 0;
      bottomPaddingOfMap = 170.0;
      drawerOpen = true;

    });
  }

  resetApp()
  {
    setState(() {
      drawerOpen = true;
      searchContainerHeight = 180.0;
      rideDetailsContainerHeight = 0;
      bottomPaddingOfMap = 170.0;

      polylineSet.clear();
      markersSet.clear();
      circlesSet.clear();
      pLineCoordinates.clear();
    });

    locatePosition(context);
  }

  void displayRideDetailsContainer(context) async
  {
    Size size = MediaQuery.of(context).size;
    await getPlaceDirection(context);
    myBottomSheet(context);
    //rideBottomSheet(context);

/*
    setState(() {
      searchContainerHeight = 0;
      rideDetailsContainerHeight = 180.0;
      bottomPaddingOfMap = 170.0;
      drawerOpen = false;
    });
 */
  }

  void locatePosition(context) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 15.5);
    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address =
        await MapsApiService.searchCoordinateAddress(position, context);
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
      key: scaffoldKey,

      /*
      drawer: Container(
        color: Theme.of(context).accentColor,
        width: size.width * 0.255,
        child: Drawer(
          child: ListView(
            children: [
              //Drawer Header
              Container(
                height: size.height * 0.165,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Theme.of(context).accentColor),
                  child: Row(
                    children: [
                      Image.asset("illustrations/AutoInsurance.svg", height: 65.0, width: 65.0,),
                      SizedBox(width: 16.0,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Profile Name", style: Theme.of(context).textTheme.bodyText1,),
                          SizedBox(height: 6.0,),
                          Text("Visit Profile"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              DividerWidget(),

              SizedBox(height: 12.0,),

              //Drawer Body Controllers

              ListTile(
                leading: Icon(Icons.history),
                title: Text("History", style: Theme.of(context).textTheme.bodyText1),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Visit Profile", style: Theme.of(context).textTheme.bodyText1),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About", style: Theme.of(context).textTheme.bodyText1),
              ),

            ],
          ),
        ),
      ),
      */

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
                        locatePosition(context);
                      }),
                ),
              ),

              /*
              // Drawer Button
              Positioned(
                top: 38.0,
                left:22.0,
                child: GestureDetector(
                  onTap: () {
                    if(drawerOpen) {
                      scaffoldKey.currentState.openDrawer();
                    }
                    else
                      {
                        resetApp();
                      }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      child: Icon((drawerOpen) ? Icons.menu : Icons.close, color: Colors.black,),
                      radius: 20.0,
                    ),
                  ),
                ),
              ),
              */



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
                                //displayRideDetailsContainer(context);
                                await getPlaceDirection(context);
                                myBottomSheet(context);
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      getTranslated(
                                          context, "enter your destination here"),
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
          //myBottomSheet(context),
          //rideBottomSheet(context),
/*
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: AnimatedSize(
                  vsync: this,
                  curve: Curves.bounceIn,
                  duration: new Duration(milliseconds: 160),
                  child: Container(
                    height: rideDetailsContainerHeight,
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
                            color: Theme.of(context).accentColor,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                  children: [
                                    Image.asset("assets/images/women_truck.jpg", height: 70.0, width: 80.0,),
                                    SizedBox(width: 16.0,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Winch", style: Theme.of(context).textTheme.bodyText2,
                                        ),
                                        Text(
                                          ((tripDirectionDetails != null) ? tripDirectionDetails.distanceText : ''),
                                          style: Theme.of(context).textTheme.bodyText1,
                                        ),
                                      ],
                                    ),
                                    Expanded(child: Container()),
                                    Text(
                                      ((tripDirectionDetails != null) ? 'EGP ${MapsApiService.calculateFares(tripDirectionDetails)}' : ''),
                                        style: Theme.of(context).textTheme.bodyText2,
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
                                 displayRequestRideContainer();

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


              ),


 */
/*
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0),topRight: Radius.circular(16.0),),
                    color: Theme.of(context).accentColor,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 0.5,
                        blurRadius: 16.0,
                        color: Colors.black54,
                        offset: Offset(0.7,0.7),
                      ),
                      ],
                  ),

                  height: requestRideContainerHeight,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        SizedBox(height: 12.0,),
                        DefaultTextStyle(
                          style: Theme.of(context).textTheme.headline2,
                          child: AnimatedTextKit(
                            animatedTexts: [
                              WavyAnimatedText('Requesting.. please wait..'),
                              WavyAnimatedText('Looking for winch..'),
                            ],
                            isRepeatingAnimation: true,
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        ),

                        SizedBox(height: 22.0,),

                        Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(26.0),
                            border: Border.all(width: 2.0, color: Colors.black54),
                          ),
                          child: Icon(Icons.close, size: 26.0,),
                        ),

                        SizedBox(height: 10.0,),

                        Container(
                          width: double.infinity,
                          child: Text("Cancel Ride", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1,),
                        ),

                      ],
                    ),
                  ),
                ),
              ),

 */

          //locationBottomSheet(),
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
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: DraggableScrollableSheet(
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
                              Text(
                                "Winch", style: Theme.of(context).textTheme.bodyText2,
                              ),
                              Text(
                                ((tripDirectionDetails != null) ? tripDirectionDetails.distanceText : ''),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          Text(
                            ((tripDirectionDetails != null) ? 'EGP ${MapsApiService.calculateFares(tripDirectionDetails)}' : ''),
                            style: Theme.of(context).textTheme.bodyText2,
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
                        displayRequestRideContainer();
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
          );
        },
      ),
    );
  }


  myBottomSheet(context) {
    Size size = MediaQuery.of(context).size;
    var pickup = Provider.of<AppData>(context, listen: false).pickUpLocation.placeName;
    var dropoff = Provider.of<AppData>(context, listen: false).dropOffLocation.placeName;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext c) {
          return SingleChildScrollView(
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
                              Text("$pickup",
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
                                "$dropoff",
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
                                  "Estimated time", style: Theme.of(context).textTheme.bodyText2,
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
                      child: RaisedButton(
                        onPressed: ()
                        {
                          resetApp();
                        },
                        color: Theme.of(context).accentColor,
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
                          displayRequestRideContainer();
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
              ),
            ),
          );
        });
  }

}
