import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:customer_app/local_db/customer_info_db.dart';
import 'package:customer_app/local_db/cutomer_owned_cars_model.dart';
import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/provider/winch_request/winch_request_provider.dart';
import 'package:customer_app/screens/dash_board/dash_board.dart';
import 'package:customer_app/screens/winch_service/ongoing_trip/accepted_winch_trip_map.dart';
import 'package:customer_app/screens/winch_service/to_winch_map.dart';
import 'package:customer_app/services/maps_services/maps_services.dart';
import 'package:customer_app/widgets/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';


class RideBottomSheet extends StatefulWidget {
  // RideBottomSheet(this.context); //DirectionDetails tripDirectionDetails;
  @override
  _RideBottomSheetState createState() => _RideBottomSheetState();
}

class _RideBottomSheetState extends State<RideBottomSheet> {
  @override
  resetApp()   {
     Navigator.pushNamedAndRemoveUntil(context,
        ToWinchMap.routeName, ModalRoute.withName(DashBoard.routeName));


  }

  BitmapDescriptor mapMarker;
  MapsProvider appDataObject;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appDataObject = Provider.of<MapsProvider>(context, listen: false);
    print(loadJwtTokenFromDB());
    print(Provider.of<CustomerCarProvider>(context, listen: false)
        .customerOwnedCars
        .getAt(0)
        .id);
    //getCurrentPrefData();
  }

  //String jwtToken = loadJwtTokenFromDB();
  Timer timer;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer3<WinchRequestProvider, MapsProvider, CustomerCarProvider>(
        builder: (context, WinchRequestProvider, MapsProvider,
                CustomerCarProvider, child) =>
            Stack(
              children: [
                WinchRequestProvider.STATUS_SEARCHING == false
                    ? DraggableScrollableSheet(
                        initialChildSize: 0.4,
                        minChildSize: 0.25,
                        maxChildSize: 0.65,
                        builder: (ctx, myController) {
                          return SingleChildScrollView(
                            controller: myController,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  topRight: Radius.circular(16.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: size.height * 0.03),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Container(
                                        height: size.height * 0.009,
                                        width: size.width * 0.4,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: size.width * 0.01,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex:1,
                                            child: Icon(
                                              Icons.my_location,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.02,
                                          ),
                                          Expanded(
                                            flex: 9,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("From:"),
                                                SizedBox(
                                                  height: 4.0,
                                                ),
                                                Text(
                                                  "${MapsProvider.pickUpLocation.placeName}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.02),
                                    DividerWidget(),
                                    SizedBox(height: size.height * 0.02),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: size.width * 0.003,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex :1,
                                            child: Icon(
                                              Icons.location_pin,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 12.0,
                                          ),
                                          Expanded(
                                            flex:9,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("To:"),
                                                SizedBox(
                                                  height: 4.0,
                                                ),
                                                Text(
                                                  "${MapsProvider.dropOffLocation.placeName}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.02),
                                    DividerWidget(),
                                    SizedBox(height: size.height * 0.04),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Text("Total Distance"),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                            MapsProvider.tripDirectionDetails !=
                                                    null
                                                ? Text(
                                                    MapsProvider
                                                        .tripDirectionDetails
                                                        .distanceText,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5,
                                                  )
                                                : CircularProgressIndicator(),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text("Estimated Fare"),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                            Text(
                                              MapsProvider.tripDirectionDetails !=
                                                      null
                                                  ? '${MapsApiService.calculateFares(MapsProvider.tripDirectionDetails, context)} EGP'
                                                  : '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
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
                                              MapsProvider.tripDirectionDetails !=
                                                      null
                                                  ? ' ${MapsProvider.tripDirectionDetails.durationText}'
                                                  : '',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: size.height * 0.04,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0),
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
                                      padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                                      child: TextButton(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "Confirm Service",
                                                style: TextStyle(color: Colors.white,fontSize: 25),
                                              ),
                                              Icon(
                                                Icons.car_repair,
                                                color:
                                                    Theme.of(context).accentColor,
                                                size: 30,
                                              )
                                            ],
                                          ),
                                          style: ButtonStyle(
                                              padding: MaterialStateProperty.all<EdgeInsets>(
                                                  EdgeInsets.all(15)),
                                              foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                              backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.green),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      side:
                                                      BorderSide(color: Colors.green)))),
                                          onPressed: () async {
                                            print("bye bye");
                                            await WinchRequestProvider
                                                .confirmWinchService(
                                                    /*WinchRequestProvider
                                          .confirmWinchServiceRequestModel*/
                                                    );
                                            print("hi hi");
                                            if (WinchRequestProvider.isLoading ==
                                                    false &&
                                                WinchRequestProvider
                                                        .STATUS_SEARCHING ==
                                                    true) {
                                              print("shefo start");
                                              // Navigator.of(context).pop();
                                              //searchForNearestWinchSheet(ctx);
                                              // Navigator.pushNamedAndRemoveUntil(context,WinchToCustomer.routeName, (route) => false);
                                              print(WinchRequestProvider
                                                  .confirmWinchServiceResponseModel
                                                  .error);
                                              print(
                                                  " hi bye ${WinchRequestProvider.confirmWinchServiceResponseModel.status}");
                                              timer = Timer.periodic(
                                                  Duration(seconds: 14),
                                                  (timer) async {
                                                print("timer loop");
                                                await WinchRequestProvider
                                                    .checkStatusForConfirmedWinchService();
                                                if (WinchRequestProvider
                                                        .STATUS_TERMINATED ==
                                                    true) {
                                                  print("process terminated");
                                                  final snackBar = SnackBar(content: Text('Time out !! Failed to get nearest winch driver \nPlease try again'));
                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                  timer.cancel();
                                                  resetApp();

                                                  //searchForNearestWinchSheet(context);
                                                } else if (WinchRequestProvider
                                                        .STATUS_ACCEPTED ==
                                                    true) {
                                                  print("driver found");
                                                  print("timer Stopped");
                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          WinchToCustomer
                                                              .routeName,
                                                          (route) => false);
                                                  timer.cancel();
                                                } else {
                                                  print(DateTime.now());
                                                  print(
                                                      "still searching for nearest driver");
                                                  // Navigator
                                                  //     .pushNamedAndRemoveUntil(
                                                  //     context,
                                                  //     WinchToCustomer
                                                  //         .routeName,
                                                  //         (route) => false);
                                                  // timer.cancel();
                                                }
                                              });
                                            } else
                                              print(WinchRequestProvider
                                                  .confirmWinchServiceResponseModel
                                                  .error);
                                          }),
                                    ),
                                    SizedBox(
                                      height: 24.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
                                      child: TextButton(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                "Cancel",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline2,
                                              ),
                                              SizedBox(width: size.width*0.02),
                                              Icon(
                                                Icons.close,
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                size: 26.0,
                                              )
                                            ],
                                          ),
                                          style: ButtonStyle(
                                              padding:
                                              MaterialStateProperty.all<EdgeInsets>(
                                                  EdgeInsets.all(15)),
                                              foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.red),
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      side: BorderSide(
                                                          width: 1.5, color: Colors.red)))),
                                          onPressed: () {
                                            resetApp();
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : searchForNearestWinchSheet(context),//Container(),
              ],
            ));
  }

  searchForNearestWinchSheet(context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Consumer3<MapsProvider, WinchRequestProvider,CustomerCarProvider>(
        builder: (ctx, MapsProvider, WinchRequestProvider,CustomerCarProvider, child) =>
            DraggableScrollableSheet(
                initialChildSize: 0.27,
                minChildSize: 0.23,
                maxChildSize: 0.5,
                builder: (context, myController) {
                  Box<customerOwnedCarsDB> selectedCar =
                      CustomerCarProvider.customerOwnedCars;
                  return SingleChildScrollView(
                    controller: myController,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.47,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Align(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.007,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.02),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: DefaultTextStyle(
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                            child: AnimatedTextKit(
                                              animatedTexts: [
                                                FadeAnimatedText(
                                                  'Requesting.. please wait..',
                                                ),
                                                FadeAnimatedText(
                                                  'Looking for winch..',
                                                ),

                                              ],
                                              repeatForever: true,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          // width:
                                          //     MediaQuery.of(context).size.width *
                                          //         0.01,
                                          color: Colors.blueAccent,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text("Scope",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .button),
                                              Text(
                                                " ${WinchRequestProvider.checkRequestStatusResponseModel.scope != null ? WinchRequestProvider.checkRequestStatusResponseModel.scope.toString() : "5"} Km",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .button,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          LinearProgressIndicator(
                              backgroundColor: Colors.redAccent),
                          // SizedBox(
                          //     height: MediaQuery.of(context).size.height * 0.15),
                          Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height*0.1,
                                child: SvgPicture.asset(
                                  "assets/icons/tow-truck_2.svg",
                                  width: MediaQuery.of(context).size.width * 0.2,
                                ),
                              ),
                              Text(
                                  "Drop-off by${MapsProvider.tripDirectionDetails != null ? ' ${MapsProvider.tripDirectionDetails.durationText}' : ''}"),
                            ],
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.017),
                          DividerWidget(),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded( flex :6,
                            child: Row(
                                children:[
                                Icon(Icons.location_on_outlined),
                          SizedBox(width:MediaQuery.of(context).size.width*0.01),
                          Text(
                            "${MapsProvider.dropOffLocation.placeName}",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          ]),
                                ),
                              // Expanded(
                              //   flex: 3,
                              //    child:Text(MapsProvider.tripDirectionDetails.durationText,style:TextStyle(color: Colors.blue,fontWeight:FontWeight.normal)),
                              // )
                              ],
                            ),
                          ),
                          DividerWidget(),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex:6,
                                  child: Row(
                                    children:[
                            Icon(Icons.money_outlined),
                          SizedBox(width:MediaQuery.of(context).size.width*0.01),
                          Text(
                            MapsProvider.tripDirectionDetails != null
                                  ? '${MapsApiService.calculateFares(MapsProvider.tripDirectionDetails, context)} EGP'
                                  : '',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                            ]
                                  ),
                                ),
                                Expanded(
                                  flex:1,child:Text("Cash",style: TextStyle(color: Colors.blue,fontWeight:FontWeight.normal),)
                                )
                              ],
                            ),
                          ),
                          DividerWidget(),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:  MediaQuery.of(context).size.width * 0.02,
                                vertical:  MediaQuery.of(context).size.height * 0.01),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 14,
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.car_repair,
                                        color: Colors.redAccent,
                                      ),
                                      SizedBox(
                                        width:  MediaQuery.of(context).size.width * 0.01,
                                      ),
                                      Text(
                                        selectedCar.getAt(0).CarBrand +
                                            " " +
                                            selectedCar.getAt(0).Model,
                                        style:
                                        Theme.of(context).textTheme.headline5,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    selectedCar.getAt(0).Plates,
                                    style: TextStyle(color: Colors.blue,fontWeight:FontWeight.normal),
                                  ),
                                )
                              ],
                            ),
                          ),
                          DividerWidget(),
                          GestureDetector(
                            onTap: () async {
                             await WinchRequestProvider.cancelWinchDriverRequest();
                              if(WinchRequestProvider.CANCLING_RIDE==true)
                                {
                                  print("Searching Cancelled");
                                  resetApp();
                                  timer.cancel();
                                }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Cancel",
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
      ),
    );
  }
}
