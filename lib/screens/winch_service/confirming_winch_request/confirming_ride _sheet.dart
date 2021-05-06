import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:customer_app/local_db/customer_info_db.dart';
import 'package:customer_app/models/maps/direction_details.dart';
import 'package:customer_app/models/winch_request/confirm_winch_service_model.dart';
import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/provider/winch_request/winch_request_provider.dart';
import 'package:customer_app/screens/dash_board/dash_board.dart';
import 'package:customer_app/screens/winch_service/ongoing_trip/winch_to_customer_map.dart';
import 'package:customer_app/screens/winch_service/to_winch_map.dart';
import 'package:customer_app/services/maps_services/maps_services.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:customer_app/widgets/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideBottomSheet extends StatefulWidget {
  // RideBottomSheet(this.context); //DirectionDetails tripDirectionDetails;
  @override
  _RideBottomSheetState createState() => _RideBottomSheetState();
}

class _RideBottomSheetState extends State<RideBottomSheet> {
  @override
  resetApp() async {
    var res = await Navigator.pushNamedAndRemoveUntil(context,
        ToWinchMap.routeName, ModalRoute.withName(DashBoard.routeName));
  }

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
    return Consumer3<WinchRequestProvider, MapsProvider, CustomerCarProvider>(
      builder: (context, WinchRequestProvider, MapsProvider,
              CustomerCarProvider, child) =>
          DraggableScrollableSheet(
        initialChildSize: 0.35, //WinchRequestProvider.sheetHeight,
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
                                  "${MapsProvider.pickUpLocation.placeName}",
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
                        left: size.width * 0.003,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                "${MapsProvider.dropOffLocation.placeName}",
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
                            MapsProvider.tripDirectionDetails != null
                                ? Text(
                                    MapsProvider
                                        .tripDirectionDetails.distanceText,
                                    style:
                                        Theme.of(context).textTheme.headline5,
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
                              MapsProvider.tripDirectionDetails != null
                                  ? '${MapsApiService.calculateFares(MapsProvider.tripDirectionDetails, context)} L.E'
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
                              MapsProvider.tripDirectionDetails != null
                                  ? ' ${MapsProvider.tripDirectionDetails.durationText}'
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
                              /*WinchRequestProvider
                                    .confirmWinchServiceRequestModel*/
                              );
                          if (WinchRequestProvider.isLoading == false &&
                              WinchRequestProvider.STATUS_SEARCHING == true) {
                            //Navigator.of(context).pop();
                            searchForNearestWinchSheet(ctx);
                            // Navigator.pushNamedAndRemoveUntil(context,WinchToCustomer.routeName, (route) => false);
                            print(WinchRequestProvider
                                .confirmWinchServiceResponseModel.error);
                            print(WinchRequestProvider
                                .confirmWinchServiceResponseModel.status);
                            timer = Timer.periodic(Duration(seconds: 14),
                                (timer) async {
                              await WinchRequestProvider
                                  .checkStatusForConfirmedWinchService();
                              if (WinchRequestProvider.STATUS_TERMINATED ==
                                  true) {
                                print("process terminated");
                                timer.cancel();
                                // resetApp();
                                //searchForNearestWinchSheet(context);
                              } else if (WinchRequestProvider.STATUS_ACCEPTED ==
                                  true) {
                                print("driver found");
                                print("timer Stopped");
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    WinchToCustomer.routeName,
                                    (route) => false);
                                timer.cancel();
                              } else {
                                print(DateTime.now());
                                print("still searching for nearest driver");
                              }
                            });
                          } else
                            print(WinchRequestProvider
                                .confirmWinchServiceResponseModel.error);
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

// import 'dart:async';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:customer_app/local_db/customer_info_db.dart';
// import 'package:customer_app/models/maps/direction_details.dart';
// import 'package:customer_app/models/winch_request/confirm_winch_service_model.dart';
// import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
// import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
// import 'package:customer_app/provider/winch_request/winch_request_provider.dart';
// import 'package:customer_app/screens/dash_board/dash_board.dart';
// import 'package:customer_app/screens/winch_service/ongoing_trip/winch_to_customer_map.dart';
// import 'package:customer_app/screens/winch_service/to_winch_map.dart';
// import 'package:customer_app/services/maps_services/maps_services.dart';
// import 'package:customer_app/shared_prefrences/customer_user_model.dart';
// import 'package:customer_app/widgets/divider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class RideBottomSheet extends StatefulWidget {
// //  RideBottomSheet(this.context); //DirectionDetails tripDirectionDetails;
//   @override
//   _RideBottomSheetState createState() => _RideBottomSheetState();
// }
//
// class _RideBottomSheetState extends State<RideBottomSheet> {
//   @override
//   resetApp() async {
//     var res = await Navigator.pushNamedAndRemoveUntil(context,
//         ToWinchMap.routeName, ModalRoute.withName(DashBoard.routeName));
//   }
//
//   BuildContext ctx;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     //getCurrentPrefData();
//   }
//
//   String jwtToken = loadJwtTokenFromDB();
//   Timer timer;
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Consumer3<WinchRequestProvider, MapsProvider, CustomerCarProvider>(
//       builder: (context, WinchRequestProvider, MapsProvider,
//           CustomerCarProvider, child) {
//         var pickUpLocation = MapsProvider.pickUpLocation;
//         var dropOffLocation = MapsProvider.dropOffLocation;
//         var pickUp = pickUpLocation.placeName;
//         var pickUpLong = pickUpLocation.longitude.toString();
//         var pickUpLat = pickUpLocation.latitude.toString();
//         var dropOff = dropOffLocation.placeName;
//         var dropOffLong = dropOffLocation.longitude.toString();
//         var dropOffLat = dropOffLocation.latitude.toString();
//
//         ConfirmWinchServiceRequestModel winchRequestModel =
//             new ConfirmWinchServiceRequestModel(
//           dropOffLocationLat: dropOffLat,
//           dropOffLocationLong: dropOffLong,
//           pickupLocationLat: pickUpLat,
//           pickupLocationLong: pickUpLong,
//           carId: CustomerCarProvider.customerOwnedCars.keyAt(0),
//           estimatedDistance:
//               MapsProvider.tripDirectionDetails.distanceText ?? "",
//           estimatedFare: MapsProvider.estimatedFare.toString(),
//           estimatedTime: MapsProvider.tripDirectionDetails.durationText,
//         );
//
//         DirectionDetails tripDetails = MapsProvider.tripDirectionDetails;
//         return DraggableScrollableSheet(
//           initialChildSize: 0.35,
//           minChildSize: 0.25,
//           maxChildSize: 0.65,
//           builder: (BuildContext myContext, myController) {
//             return SingleChildScrollView(
//               controller: myController,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).accentColor,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(16.0),
//                     topRight: Radius.circular(16.0),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
//                   child: Column(
//                     children: [
//                       Center(
//                         child: Container(
//                           height: size.height * 0.009,
//                           width: size.width * 0.4,
//                           decoration: BoxDecoration(
//                             color: Colors.grey.withOpacity(0.5),
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height * 0.03,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                           left: size.width * 0.01,
//                         ),
//                         child: FittedBox(
//                           fit: BoxFit.fitWidth,
//                           child: Row(
//                             children: [
//                               Icon(
//                                 Icons.my_location,
//                                 color: Theme.of(context).primaryColorDark,
//                               ),
//                               SizedBox(
//                                 width: size.width * 0.02,
//                               ),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("From:"),
//                                   SizedBox(
//                                     height: 4.0,
//                                   ),
//                                   Text(
//                                     "$pickUp",
//                                     style:
//                                         Theme.of(context).textTheme.bodyText1,
//                                     maxLines: 10,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.02),
//                       DividerWidget(),
//                       SizedBox(height: size.height * 0.02),
//                       Padding(
//                         padding: EdgeInsets.only(
//                           left: size.width * 0.01,
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.location_pin,
//                               color: Theme.of(context).primaryColorDark,
//                             ),
//                             SizedBox(
//                               width: 12.0,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text("To:"),
//                                 SizedBox(
//                                   height: 4.0,
//                                 ),
//                                 Text(
//                                   "$dropOff",
//                                   style: Theme.of(context).textTheme.bodyText1,
//                                   maxLines: 10,
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: size.height * 0.02),
//                       DividerWidget(),
//                       SizedBox(height: size.height * 0.04),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Column(
//                             children: [
//                               Text("Total Distance"),
//                               SizedBox(
//                                 height: size.height * 0.01,
//                               ),
//                               Text(
//                                 tripDetails != null
//                                     ? tripDetails.distanceText
//                                     : '',
//                                 style: Theme.of(context).textTheme.headline5,
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Text("Estimated Fare"),
//                               SizedBox(
//                                 height: size.height * 0.01,
//                               ),
//                               Text(
//                                 tripDetails != null
//                                     ? '${MapsApiService.calculateFares(tripDetails, context)} L.E'
//                                     : '',
//                                 style: Theme.of(context).textTheme.headline5,
//                               ),
//                             ],
//                           ),
//                           Column(
//                             children: [
//                               Text("Estimated Duration"),
//                               SizedBox(
//                                 height: size.height * 0.01,
//                               ),
//                               Text(
//                                 tripDetails != null
//                                     ? ' ${tripDetails.durationText}'
//                                     : '',
//                                 style: Theme.of(context).textTheme.headline5,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: size.height * 0.04,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 20.0),
//                         child: Row(
//                           children: [
//                             //Icon(FontAwesomeIcons.moneyCheckAlt, size: 18.0, color: Colors.black54,)
//                             Icon(
//                               Icons.money,
//                               size: 18.0,
//                               color: Colors.black54,
//                             ),
//                             SizedBox(
//                               width: 16.0,
//                             ),
//                             Text("Cash"),
//                             SizedBox(
//                               width: 6.0,
//                             ),
//                             Icon(
//                               Icons.keyboard_arrow_down,
//                               size: 16.0,
//                               color: Colors.black54,
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: size.height * 0.05,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 16.0),
//                         child: RaisedButton(
//                           onPressed: () async {
//                             await WinchRequestProvider.confirmWinchService(
//                                 winchRequestModel);
//                             if (WinchRequestProvider.isLoading == false &&
//                                 WinchRequestProvider.STATUS_SEARCHING == true) {
//                               Navigator.of(myContext).pop();
//                               // Navigator.of(context).pushNamedAndRemoveUntil(
//                               //     ToWinchMap.routeName, (route) => false);
//                               searchForNearestWinchSheet();
//                               timer = Timer.periodic(Duration(seconds: 10),
//                                   (timer) async {
//                                 await WinchRequestProvider
//                                     .checkStatusForConfirmedWinchService();
//                                 if (WinchRequestProvider.STATUS_TERMINATED ==
//                                     true) {
//                                   // resetApp();
//                                   print("process terminated");
//                                   searchForNearestWinchSheet();
//                                   // Navigator.pushNamedAndRemoveUntil(
//                                   //     context,
//                                   //     ToWinchMap.routeName,
//                                   //     ModalRoute.withName(DashBoard.routeName));
//                                   timer.cancel();
//                                   //searchForNearestWinchSheet(context);
//                                 } else if (WinchRequestProvider
//                                         .STATUS_ACCEPTED ==
//                                     true) {
//                                   print("client found");
//                                   Navigator.pushNamedAndRemoveUntil(
//                                       myContext,
//                                       WinchToCustomer.routeName,
//                                       (route) => false);
//                                   print("timer Stopped");
//                                   timer.cancel();
//                                 } else {
//                                   print(DateTime.now());
//                                   print("still searching for nearest driver");
//                                   // Navigator.of(context).pop();
//                                   // Navigator.pushNamedAndRemoveUntil(myContext,
//                                   //     ToWinchMap.routeName, (route) => false);
//                                   // Navigator.of(context).pushNamedAndRemoveUntil(
//                                   //     ToWinchMap.routeName, (route) => false);
//                                 }
//                               });
//                             } else
//                               print(WinchRequestProvider
//                                   .confirmWinchServiceResponseModel.error);
//                           },
//                           color: Colors.green,
//                           child: Padding(
//                             padding: EdgeInsets.all(17.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Confirm Service",
//                                   style: Theme.of(context).textTheme.button,
//                                 ),
//                                 Icon(
//                                   Icons.car_repair,
//                                   color: Theme.of(context).accentColor,
//                                   size: 26.0,
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 24.0,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 16.0),
//                         child: OutlinedButton(
//                           onPressed: () {
//                             resetApp();
//                           },
//                           //color: Theme.of(context).accentColor,
//                           child: Padding(
//                             padding: EdgeInsets.all(17.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "Cancel",
//                                   style: Theme.of(context).textTheme.headline2,
//                                 ),
//                                 Icon(
//                                   Icons.close,
//                                   color: Theme.of(context).primaryColorDark,
//                                   size: 26.0,
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   searchForNearestWinchSheet() {
//     showModalBottomSheet(
//         context: context,
//         isDismissible: false,
//         enableDrag: false,
//         backgroundColor: Colors.transparent,
//         builder: (c) {
//           if (Provider.of<WinchRequestProvider>(context, listen: true)
//                   .STATUS_TERMINATED ==
//               true) {
//             Navigator.of(c).pop();
//           }
//           return SingleChildScrollView(
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.3,
//               decoration: BoxDecoration(
//                 color: Theme.of(context).accentColor,
//               ),
//               child: Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     LinearProgressIndicator(backgroundColor: Colors.redAccent),
//                     SizedBox(height: MediaQuery.of(context).size.height * 0.15),
//                     DefaultTextStyle(
//                       style: Theme.of(context).textTheme.headline2,
//                       child: AnimatedTextKit(
//                         animatedTexts: [
//                           WavyAnimatedText('Requesting.. please wait..'),
//                           WavyAnimatedText('Looking for winch..'),
//                         ],
//                         repeatForever: true,
//                         //onTap: () { print("Tap Event"); },
//                       ),
//                     ),
//
// /*
//
//
// DefaultTextStyle(
//                       style: Theme.of(context).textTheme.headline2,
//                       child: AnimatedTextKit(
//                         animatedTexts: [
//                           WavyAnimatedText('Requesting.. please wait..'),
//                           WavyAnimatedText('Looking for winch..'),
//                         ],
//                         isRepeatingAnimation: true,
//                         repeatForever: true,
//                         //onTap: () { print("Tap Event"); },
//                       ),
//                     ),
//
//
//                     SizedBox(height: 22.0,),
//
//                     GestureDetector(
//                       onTap: (){
//                         resetApp();
//                       },
//                       child: Container(
//                         height: 60.0,
//                         width: 60.0,
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).accentColor,
//                           borderRadius: BorderRadius.circular(26.0),
//                           border: Border.all(width: 2.0, color: Colors.black54),
//                         ),
//                         child: Icon(Icons.close, size: 26.0,),
//                      ),
//                     ),
//
//                     SizedBox(height: 10.0,),
//
//                     Container(
//                       width: double.infinity,
//                       child: Text("Cancel Ride", textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1,),
//                     ),
// */
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }
