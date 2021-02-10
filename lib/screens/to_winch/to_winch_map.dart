import 'package:customer_app/DataHandler/appData.dart';
import 'package:customer_app/screens/to_winch/search_screen.dart';
import 'package:customer_app/widgets/progress_Dialog.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:customer_app/widgets/divider.dart';
import 'package:customer_app/services/api_services.dart';
import 'package:provider/provider.dart';


class ToWinchMap extends StatelessWidget {
  static String routeName = '/ToWinchMap';
  Completer<GoogleMapController> _completerGoogleMap = Completer();
  GoogleMapController _googleMapController;

  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  Position currentPosition;
  var geoLocator = Geolocator();

  void locatePosition(context) async
  {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = new CameraPosition(target: latLatPosition, zoom: 15.5);
    _googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String address = await ApiService.searchCoordinateAddress(position, context);
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
        children:[
          //Padding(
            //padding: const EdgeInsets.only(bottom: 190.0),
             Column(
              children: [
                //Padding(
                  //padding: const EdgeInsets.only(bottom: 190.0),
                  //child:
      Padding(
        padding: EdgeInsets.only(top: size.height * 0.03,),
        child: Container(
                      height: size.height * 0.75,
                     child: GoogleMap(
                        initialCameraPosition: _initialPosition,
                        mapType: MapType.normal,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: true,
                        mapToolbarEnabled: true,

                        onMapCreated: (GoogleMapController controller) {
                          _completerGoogleMap.complete(controller);
                          _googleMapController = controller;
                          locatePosition(context);
                        }

                    ),

                    ),
      ),
              //  ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: Container(
                    height: size.height * 0.22,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 16.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7,0.7),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: size.height * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * 0.006),
                          Text("Hi there,", style: Theme.of(context).textTheme.bodyText1),
                          Text("Where to?", style: Theme.of(context).textTheme.headline2),
                          SizedBox(height: size.height * 0.02),

                          GestureDetector(
                            onTap:() async
                            {
                              var res = await Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
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
                                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: size.height * 0.006,),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.search, color: Theme
                                        .of(context)
                                        .hintColor,),
                                    //SizedBox(width: size.width * 0.0001,),
                                    Text("Search Drop off",
                                      style: Theme.of(context).textTheme.bodyText2,
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),

                        /*
                          GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
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
                                padding: const EdgeInsets.all(
                                    12.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_pin,
                                      color: Theme.of(context).hintColor,
                                    ),
                                    SizedBox(width: 10.0,),
                                    Text("My location")

                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 20.0),

                          GestureDetector(
                            onTap:()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
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
                                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: size.height * 0.006,),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.search, color: Theme
                                        .of(context)
                                        .hintColor,),
                                    //SizedBox(width: size.width * 0.0001,),
                                    Text("Search Drop off",
                                      style: Theme.of(context).textTheme.bodyText2,
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 24.0),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 60.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.push_pin, color: Theme
                                    .of(context)
                                    .primaryColorDark,),
                                SizedBox(width: 12.0,),
                                GestureDetector(
                                  child: Text(
                                      "Set A location on the map"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24.0),
                          Row(
                            children: [
                              Icon(Icons.home, color: Theme
                                  .of(context)
                                  .primaryColorDark,),
                              SizedBox(width: 12.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: [
                                  Text(
                                      Provider.of<AppData>(context).pickUpLocation != null
                                          ? Provider.of<AppData>(context).pickUpLocation.placeName
                                          : "Add Home"
                                  ),
                                  SizedBox(height: 4.0,),
                                  Text(
                                    "Your living home address",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyText1,),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10.0),
                          DividerWidget(),
                          SizedBox(height: 18.0),
                          Row(
                            children: [
                              Icon(Icons.work, color: Theme
                                  .of(context)
                                  .primaryColorDark,),
                              SizedBox(width: 12.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: [
                                  Text("Add Work"),
                                  SizedBox(height: 4.0,),
                                  Text("Your office address",
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyText1,),
                                ],
                              )
                            ],
                          ),
                                */
                        ],

                      ),

                      ),
                    ),
                  ),



              ],
            )
            //),

          //locationBottomSheet(),
        ],
      ),
    );

  }

  Future<void> getPlaceDirection(context) async
  {
    var initialPos = Provider.of<AppData>(context, listen: false).pickUpLocation;
    var finalPos = Provider.of<AppData>(context, listen: false).dropOffLocation;

    var pickUpLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var dropOffLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(message: "Please wait..")
    );

    var details = await ApiService.obtainPlaceDirectionDetails(pickUpLatLng, dropOffLatLng);

    Navigator.pop(context);

    print("This is Encoded Points ::");
    print(details.encodedPoints);
  }

  Padding locationBottomSheet(context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: DraggableScrollableSheet(builder: (context, controller){
        return Container(
          child: ListView.builder(
            itemCount: 1,
            controller: controller,
            itemBuilder: (BuildContext context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start,
                  children: [
                    //SizedBox(height: 6.0),
                    Text(
                        "Hi there,",
                        style: Theme.of(context).textTheme.bodyText1
                    ),
                    Text(
                        "Where to?",
                        style: Theme.of(context).textTheme.headline2
                    ),
                    SizedBox(height: 20.0),

                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
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
                          padding: const EdgeInsets.all(
                              12.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Theme.of(context).hintColor,
                              ),
                              SizedBox(width: 10.0,),
                              Text("My location")

                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 20.0),
                    
                    GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .accentColor,
                        borderRadius: BorderRadius
                            .circular(5.0),
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
                        padding: const EdgeInsets.all(
                            12.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search, color: Theme
                                .of(context)
                                .hintColor,),
                            SizedBox(width: 10.0,),
                            Text("Search Drop off")
                          ],
                        ),
                      ),
                    ),
                    ),

                    SizedBox(height: 24.0),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 60.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.push_pin, color: Theme
                              .of(context)
                              .primaryColorDark,),
                          SizedBox(width: 12.0,),
                          GestureDetector(
                            child: Text(
                                "Set A location on the map"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.0),
                    Row(
                      children: [
                        Icon(Icons.home, color: Theme
                            .of(context)
                            .primaryColorDark,),
                        SizedBox(width: 12.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          children: [
                            Text("Add Home"),
                            SizedBox(height: 4.0,),
                            Text(
                              "Your living home address",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1,),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10.0),
                    DividerWidget(),
                    SizedBox(height: 18.0),
                    Row(
                      children: [
                        Icon(Icons.work, color: Theme
                            .of(context)
                            .primaryColorDark,),
                        SizedBox(width: 12.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          children: [
                            Text("Add Work"),
                            SizedBox(height: 4.0,),
                            Text("Your office address",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1,),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              );
              //);
            },
          ),

          decoration: BoxDecoration(

              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
              )
          ),

        );
      },
      ),



    );
  }
}

myBottomSheet(context){
  showModalBottomSheet(context: context, builder: (BuildContext c){
    return SingleChildScrollView(
      child: Container(
        //color: Theme.of(context).accentColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 6.0),
            Text("Hi there,", style: Theme.of(context).textTheme.bodyText1),
            Text("Where to?", style: Theme.of(context).textTheme.headline2),
            SizedBox(height: 20.0),

            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
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
                  padding: const EdgeInsets.all(
                      12.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Theme.of(context).hintColor,
                      ),
                      SizedBox(width: 10.0,),
                      Text("My location")

                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.0),

            GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                color: Theme
                    .of(context)
                    .accentColor,
                borderRadius: BorderRadius
                    .circular(5.0),
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
                padding: const EdgeInsets.all(
                    12.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.search, color: Theme
                        .of(context)
                        .hintColor,),
                    SizedBox(width: 10.0,),
                    Text("Search Drop off")
                  ],
                ),
              ),
            ),
            ),

            SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.only(
                  left: 60.0),
              child: Row(
                children: [
                  Icon(
                    Icons.push_pin, color: Theme
                      .of(context)
                      .primaryColorDark,),
                  SizedBox(width: 12.0,),
                  GestureDetector(
                    child: Text(
                        "Set A location on the map"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            Row(
              children: [
                Icon(Icons.home, color: Theme
                    .of(context)
                    .primaryColorDark,),
                SizedBox(width: 12.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start,
                  children: [
                    Text(
                      Provider.of<AppData>(context).pickUpLocation != null
                          ? Provider.of<AppData>(context).pickUpLocation
                          : "Add Home"
                    ),
                    SizedBox(height: 4.0,),
                    Text(
                      "Your living home address",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1,),
                  ],
                )
              ],
            ),
            SizedBox(height: 10.0),
            DividerWidget(),
            SizedBox(height: 18.0),
            Row(
              children: [
                Icon(Icons.work, color: Theme
                    .of(context)
                    .primaryColorDark,),
                SizedBox(width: 12.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start,
                  children: [
                    Text("Add Work"),
                    SizedBox(height: 4.0,),
                    Text("Your office address",
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1,),
                  ],
                )
              ],
            ),

          ],

        ),

        decoration: BoxDecoration(

            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
            )
        ),
      ),
    );
  }
  );
}



