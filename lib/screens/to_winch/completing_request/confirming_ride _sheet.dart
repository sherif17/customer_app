import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:customer_app/DataHandler/appData.dart';
import 'package:customer_app/local_db/customer_info_db.dart';
import 'package:customer_app/models/maps/direction_details.dart';
import 'package:customer_app/models/maps/winch_request/winch_request_model.dart';
import 'package:customer_app/provider/winch_request/winch_request_provider.dart';
import 'package:customer_app/screens/dash_board/dash_board.dart';
import 'package:customer_app/screens/to_winch/ongoing_trip/accepted_winch_driver_sheet.dart';
import 'package:customer_app/services/maps_services/maps_services.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:customer_app/widgets/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../to_winch_map.dart';

class RideBottomSheet extends StatefulWidget {
  RideBottomSheet(BuildContext context);

  //DirectionDetails tripDirectionDetails;
  @override
  _RideBottomSheetState createState() => _RideBottomSheetState();
}

class _RideBottomSheetState extends State<RideBottomSheet> {
  @override
  resetApp() async {
    var res = await Navigator.pushNamedAndRemoveUntil(context,
        ToWinchMap.routeName, ModalRoute.withName(DashBoard.routeName));
  }

  AppData appDataObject;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appDataObject = Provider.of<AppData>(context, listen: false);
    //getCurrentPrefData();
  }

  String jwtToken = loadJwtTokenFromDB();
  void getCurrentPrefData() {
    getPrefJwtToken().then((value) {
      jwtToken = value;
    });
  }

  Timer timer;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer2<WinchRequestProvider, AppData>(
      builder: (context, WinchRequestProvider, AppData, child) =>
          DraggableScrollableSheet(
        initialChildSize: 0.35,
        minChildSize: 0.25,
        maxChildSize: 0.65,
        builder: (BuildContext myContext, myController) {
          var pickUpLocation = AppData.pickUpLocation;
          var dropOffLocation = AppData.dropOffLocation;
          var pickUp = pickUpLocation.placeName;
          var pickUp_Long = pickUpLocation.longitude.toString();
          var pickUp_Lat = pickUpLocation.latitude.toString();
          var dropOff = dropOffLocation.placeName;
          var dropOff_Long = dropOffLocation.longitude.toString();
          var dropOff_Lat = dropOffLocation.latitude.toString();

          WinchRequestModel winchRequestModel = new WinchRequestModel(
              dropOffLocationLat: dropOff_Lat,
              dropOffLocationLong: dropOff_Long,
              pickupLocationLat: pickUp_Lat,
              pickupLocationLong: pickUp_Long);

          DirectionDetails tripDetails = AppData.tripDirectionDetails;
          return SingleChildScrollView(
            controller: myController,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black,
                //     blurRadius: 16.0,
                //     spreadRadius: 0.5,
                //     offset: Offset(0.7, 0.7),
                //   ),
                // ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        height: size.height * 0.009,
                        width: size.width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.01,
                      ),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Row(
                          children: [
                            Icon(
                              Icons.my_location,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("From:"),
                                SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  "$pickUp",
                                  style: Theme.of(context).textTheme.bodyText1,
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    DividerWidget(),
                    SizedBox(height: size.height * 0.02),
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.01,
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
                                maxLines: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    DividerWidget(),
                    SizedBox(height: size.height * 0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text("Total Distance"),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                              tripDetails != null
                                  ? tripDetails.distanceText
                                  : '',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Estimated Fare"),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                              tripDetails != null
                                  ? '${MapsApiService.calculateFares(tripDetails, context)} L.E'
                                  : '',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text("Estimated Duration"),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Text(
                              tripDetails != null
                                  ? ' ${tripDetails.durationText}'
                                  : '',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          //Icon(FontAwesomeIcons.moneyCheckAlt, size: 18.0, color: Colors.black54,)
                          Icon(
                            Icons.money,
                            size: 18.0,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 16.0,
                          ),
                          Text("Cash"),
                          SizedBox(
                            width: 6.0,
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 16.0,
                            color: Colors.black54,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: RaisedButton(
                        onPressed: () async {
                          await WinchRequestProvider.confirmWinchService(
                              winchRequestModel, jwtToken);
                          if (WinchRequestProvider.isLoading == false &&
                              WinchRequestProvider.STATUS_SEARCHING == true) {
                            Navigator.of(myContext).pop();
                            searchForNearestWinchSheet(context);
                            print(
                                WinchRequestProvider.winchResponseModel.error);
                            print(
                                WinchRequestProvider.winchResponseModel.status);
                            timer = Timer.periodic(Duration(seconds: 14),
                                (timer) async {
                              await WinchRequestProvider
                                  .checkConfirmedWinchServiceStatus(jwtToken);
                              if (WinchRequestProvider.STATUS_TERMINATED ==
                                  true) {
                                // Navigator.pushNamedAndRemoveUntil(
                                //     context,
                                //     AcceptedWinchDriverSheet.routeName,
                                //     (route) => false);
                                print("process terminated");
                                timer.cancel();
                                //searchForNearestWinchSheet(context);
                              } else if (WinchRequestProvider.STATUS_ACCEPTED ==
                                  true) {
                                print("client found");
                                print("timer Stopped");
                                timer.cancel();
                              } else {
                                print("still searching for nearest driver");
                              }
                            });
                          } else
                            print(
                                WinchRequestProvider.winchResponseModel.error);
                        },
                        color: Colors.green,
                        child: Padding(
                          padding: EdgeInsets.all(17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Confirm Service",
                                style: Theme.of(context).textTheme.button,
                              ),
                              Icon(
                                Icons.car_repair,
                                color: Theme.of(context).accentColor,
                                size: 26.0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: OutlinedButton(
                        onPressed: () {
                          resetApp();
                        },
                        //color: Theme.of(context).accentColor,
                        child: Padding(
                          padding: EdgeInsets.all(17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cancel",
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              Icon(
                                Icons.close,
                                color: Theme.of(context).primaryColorDark,
                                size: 26.0,
                              )
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
        },
      ),
    );
  }

  searchForNearestWinchSheet(context) {
    if (Provider.of<WinchRequestProvider>(context, listen: false)
            .STATUS_TERMINATED ==
        true) {
      print("poped");
      Navigator.pop(context);
    }
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (BuildContext c) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(16.0),
                //   topRight: Radius.circular(16.0),
                // ),
                color: Theme.of(context).accentColor,
                // boxShadow: [
                //   BoxShadow(
                //     spreadRadius: 0.5,
                //     blurRadius: 16.0,
                //     color: Colors.black54,
                //     offset: Offset(0.7, 0.7),
                //   ),
                // ],
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LinearProgressIndicator(backgroundColor: Colors.redAccent),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.headline2,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText('Requesting.. please wait..'),
                          WavyAnimatedText('Looking for winch..'),
                        ],
                        repeatForever: true,
                        //onTap: () { print("Tap Event"); },
                      ),
                    ),

/*


DefaultTextStyle(
                      style: Theme.of(context).textTheme.headline2,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText('Requesting.. please wait..'),
                          WavyAnimatedText('Looking for winch..'),
                        ],
                        isRepeatingAnimation: true,
                        repeatForever: true,
                        //onTap: () { print("Tap Event"); },
                      ),
                    ),


                    SizedBox(height: 22.0,),

                    GestureDetector(
                      onTap: (){
                        resetApp();
                      },
                      child: Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(26.0),
                          border: Border.all(width: 2.0, color: Colors.black54),
                        ),
                        child: Icon(Icons.close, size: 26.0,),
                     ),
                    ),

                    SizedBox(height: 10.0,),

                    Container(
                      width: double.infinity,
                      child: Text("Cancel Ride", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1,),
                    ),
*/
                  ],
                ),
              ),
            ),
          );
        });
  }
}
