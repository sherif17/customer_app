import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:customer_app/DataHandler/appData.dart';
import 'package:customer_app/local_db/customer_info_db.dart';
import 'package:customer_app/models/maps/direction_details.dart';
import 'package:customer_app/models/maps/winch_request/winch_request_model.dart';
import 'package:customer_app/provider/winch_request/winch_request_provider.dart';
import 'package:customer_app/screens/dash_board/dash_board.dart';
import 'package:customer_app/services/maps_services/maps_services.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:customer_app/widgets/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../to_winch_map.dart';

class RideBottomSheet extends StatefulWidget {
  DirectionDetails tripDirectionDetails;
  @override
  _RideBottomSheetState createState() => _RideBottomSheetState();

  RideBottomSheet({token, tripDirectionDetails});
}

class _RideBottomSheetState extends State<RideBottomSheet> {
  @override
  String jwtToken = loadJwtTokenFromDB();
  resetApp() async {
    var res = await Navigator.pushNamedAndRemoveUntil(context,
        ToWinchMap.routeName, ModalRoute.withName(DashBoard.routeName));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getCurrentPrefData();
  }

  void getCurrentPrefData() {
    getPrefJwtToken().then((value) {
      jwtToken = value;
    });
  }

  Timer timery;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var pickUpLocation =
        Provider.of<AppData>(context, listen: false).pickUpLocation;
    var dropOffLocation =
        Provider.of<AppData>(context, listen: false).dropOffLocation;
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
    return Consumer<WinchRequestProvider>(
      builder: (context, val, child) => DraggableScrollableSheet(
        initialChildSize: 0.4,
        minChildSize: 0.22,
        maxChildSize: 1.0,
        builder: (BuildContext myContext, controller) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 16.0,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                ),
              ],
            ),
            child: ListView.builder(
              itemCount: 1,
              controller: controller,
              itemBuilder: (BuildContext myContext, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 17.0),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: 6,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: size.width * 0.07,
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
                                width: 12.0,
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
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              )
                            ],
                          ),
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
                                  maxLines: 10,
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
                        ((widget.tripDirectionDetails != null)
                            ? widget.tripDirectionDetails.distanceText
                            : ''),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
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
                                    "Estimated duration",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Text(
                                    ((widget.tripDirectionDetails != null)
                                        ? ' ${widget.tripDirectionDetails.durationText}'
                                        : ''),
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Estimated fare",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  Text(
                                    ((widget.tripDirectionDetails != null)
                                        ? 'EGP ${MapsApiService.calculateFares(widget.tripDirectionDetails)}'
                                        : ''),
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                              Expanded(child: Container()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
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
                        height: 24.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: RaisedButton(
                          onPressed: () async {
                            await val.confirmWinchService(
                                winchRequestModel, jwtToken);
                            if (val.isLoading == false &&
                                val.STATUS_SEARCHING == true) {
                              Navigator.of(myContext).pop();
                              requestingSheet(context);
                              print(val.winchResponseModel.error);
                              print(val.winchResponseModel.status);
                              timery = Timer.periodic(Duration(seconds: 14),
                                  (timery) async {
                                await val
                                    .checkConfirmedWinchServiceStatus(jwtToken);
                                if (val.requestStatusResponseModel.status ==
                                    "TERMINATED") {
                                  val.STATUS_TERMINATED = true;
                                  val.STATUS_SEARCHING = false;
                                  print("process terminated");
                                  print("timer cancelld");
                                  timery.cancel();
                                } else if (val
                                        .requestStatusResponseModel.status ==
                                    "ACCEPTED") {
                                  val.STATUS_ACCEPTED = true;
                                  val.STATUS_SEARCHING = false;
                                  print("client found");
                                  timery.cancel();
                                } else {
                                  print("still searching for nearest driver");
                                }
                              });
                            } else
                              print("problem 00");
                          },
                          color: Theme.of(context).primaryColor,
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
                );
              },
            ),
          );
        },
      ),
    );
  }

  requestingSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext c) {
          return SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                color: Theme.of(context).accentColor,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 0.5,
                    blurRadius: 16.0,
                    color: Colors.black54,
                    offset: Offset(0.7, 0.7),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 12.0,
                    ),
                    DefaultTextStyle(
                      style: Theme.of(context).textTheme.headline2,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText('Requesting.. please wait..'),
                          WavyAnimatedText('Looking for winch..'),
                        ],
                        isRepeatingAnimation: true,
                        //onTap: () { print("Tap Event"); },
                      ),
                    ),
                    SizedBox(
                      height: 22.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        timery.cancel();
                        print("timer is cancelled");
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
                        child: Icon(
                          Icons.close,
                          size: 26.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Cancel Ride",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1,
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
