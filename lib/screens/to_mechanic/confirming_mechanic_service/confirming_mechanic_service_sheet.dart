import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:customer_app/local_db/customer_db/customer_info_db.dart';
import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/provider/mechanic_request/mechnic_request_provider.dart';
import 'package:customer_app/provider/mechanic_services/mechanic_services_cart.dart';
import 'package:customer_app/provider/winch_request/winch_request_provider.dart';
import 'package:customer_app/widgets/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ConfirmingMechanicServiceSheet extends StatelessWidget {
  static String routeName = '/ConfirmingMechanicServiceSheet';
  BuildContext ctx;

  ConfirmingMechanicServiceSheet();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Consumer4<MapsProvider, MechanicServicesCartProvider,
          CustomerCarProvider, MechanicRequestProvider>(
        builder: (context, mapsProvider, mechanicServicesCartProvider,
                customerCarProvider, mechanicRequestProvider, child) =>
            mechanicRequestProvider.MECHANIC_STATUS_SEARCHING == false
                ? Stack(
                    children: [
                      DraggableScrollableSheet(
                        initialChildSize: 0.32,
                        minChildSize: 0.1,
                        maxChildSize: 0.8,
                        builder: (BuildContext myContext, controller) {
                          const colorizeColors = [
                            Colors.white,
                            Colors.white,
                            Colors.grey
                          ];
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              buildBackContainer(context, customerCarProvider),
                              buildShowingLocationContainer(context,
                                  mechanicRequestProvider, mapsProvider),
                            ],
                          );
                        },
                      ),
                      buildFrontContainer(context, mechanicRequestProvider,
                          mechanicServicesCartProvider)
                    ],
                  )
                : searchForNearestMechanicSheet(context),
      ),
    );
  }

  Positioned buildFrontContainer(
      BuildContext context,
      MechanicRequestProvider mechanicRequestProvider,
      MechanicServicesCartProvider mechanicServicesCartProvider) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.76,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            // border: Border.all(
            //   color: Colors.red,
            // ),
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Your Services",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 25)),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.red,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                          "${mechanicServicesCartProvider.finalFare} \n EGP",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w900,
                              fontSize: 20))),
                ),
              ],
            ),
            TextButton(
                child: mechanicRequestProvider.isLoading == false
                    ? Text("Find Me A Mechanic".toUpperCase(),
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w900,
                            fontSize:
                                20) //Theme.of(context).textTheme.headline2,
                        )
                    : CircularProgressIndicator(),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(15)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blueGrey),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side:
                                BorderSide(width: 1.5, color: Colors.white)))),
                onPressed: () async {
                  // Navigator.pop(context);
                  await mechanicRequestProvider.confirmMechanicRequest();
                }),
          ],
        ),
      ),
    );
  }

  Positioned buildShowingLocationContainer(
      BuildContext context,
      MechanicRequestProvider mechanicRequestProvider,
      MapsProvider mapsProvider) {
    return Positioned(
      top: MediaQuery.of(context).size.height * -0.02,
      left: MediaQuery.of(context).size.width * 0.045,
      child: Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.location_on_outlined),
              ),
              mechanicRequestProvider.isConfirmingMechanicMapReady == true
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          mapsProvider.pickUpLocation.placeName,
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w900,
                              fontSize: 15),
                          maxLines: 1,
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.centerRight,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ScaleAnimatedText('Getting your current Location...',
                              textStyle: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18),
                              duration: Duration(seconds: 1)),
                        ],
                        repeatForever: true,
                        isRepeatingAnimation: true,
                      ),
                    ),
            ],
          )),
    );
  }

  Container buildBackContainer(
      BuildContext context, CustomerCarProvider customerCarProvider) {
    return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
                alignment: Alignment(-0.99, -0.65),
                child: TextButton.icon(
                    icon: Icon(
                      Icons.directions_car_outlined,
                      color: Colors.red,
                      size: 25,
                    ),
                    label: Text(
                      customerCarProvider.selectedCarInfo,
                      style: TextStyle(color: Colors.blueGrey),
                    ))),
            Align(
                alignment: Alignment(0.99, -0.65),
                child: TextButton.icon(
                    icon: Icon(
                      Icons.money,
                      color: Colors.redAccent,
                      size: 25,
                    ),
                    label: Text(
                      "Cash",
                      style: TextStyle(color: Colors.blueGrey),
                    ))),
          ],
        ));
  }
}

searchForNearestMechanicSheet(context) {
  // String estimatedArrivalTime = MapsApiService.calculateArrivalTime(context);
  // LatLng pickUpLatLng = LatLng(
  //   Provider.of<MapsProvider>(context, listen: false).pickUpLocation.latitude,
  //   Provider.of<MapsProvider>(context, listen: false).pickUpLocation.longitude,
  // );
  // Provider.of<MapsProvider>(context, listen: false)
  //     .googleMapController
  //     .animateCamera(CameraUpdate.newLatLngZoom(pickUpLatLng, 16.47));
  return Align(
    alignment: Alignment.bottomCenter,
    child: Consumer4<MapsProvider, MechanicRequestProvider, CustomerCarProvider,
        MechanicServicesCartProvider>(
      builder: (ctx, mapsProvider, mechanicRequestProvider, customerCarProvider,
              mechanicServicesCartProvider, child) =>
          DraggableScrollableSheet(
              initialChildSize: 0.23,
              minChildSize: 0.23,
              maxChildSize: 0.9,
              builder: (context, myController) {
                // Box<customerOwnedCarsDB> selectedCar =
                //     CustomerCarProvider.customerOwnedCars;
                return SingleChildScrollView(
                  controller: myController,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.39,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Align(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                                    'Looking for mechanic',
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
                                                  "Scope", // " ${WinchRequestProvider.checkRequestStatusResponseModel.scope != null ? WinchRequestProvider.checkRequestStatusResponseModel.scope.toString() : "5"} Km",
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
                              backgroundColor: Colors.redAccent,
                              color: Colors.white,
                            ),
                            // SizedBox(
                            //     height: MediaQuery.of(context).size.height * 0.15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.09,
                                      child: SvgPicture.asset(
                                        "assets/illustrations/car.svg",
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                    ),
                                    Text(customerCarProvider.selectedCarInfo)
                                    // "Drop_Off by" /* "Drop-off by {estimatedArrivalTime != null ? '$estimatedArrivalTime' : ''}"*/),
                                  ],
                                ),
                                Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.09,
                                      child: SvgPicture.asset(
                                        "assets/illustrations/money.svg",
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                    ),
                                    Text(
                                      mechanicServicesCartProvider.finalFare
                                          .toString(),
                                    )
                                    // "Drop_Off by" /* "Drop-off by {estimatedArrivalTime != null ? '$estimatedArrivalTime' : ''}"*/),
                                  ],
                                ),
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
                                  Expanded(
                                    flex: 6,
                                    child: Row(children: [
                                      Icon(Icons.location_on_outlined),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01),
                                      Expanded(
                                        child: Text(
                                          "${mapsProvider.pickUpLocation.placeName}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
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
                            GestureDetector(
                              onTap: () async {
                                await mechanicRequestProvider
                                    .cancelMechanicRequest();
                                //Navigator.pop(context);
                                // if(WinchRequestProvider.CANCLING_RIDE==true)
                                // {
                                //   print("Searching Cancelled");
                                //   resetApp();
                                //   timer.cancel();
                                // }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Cancel",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.02,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Container(
                        // height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Selected Problems & services",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.withOpacity(0.7),
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  controller:
                                      myController, // assign controller here
                                  itemCount: mechanicServicesCartProvider
                                      .breakDownListSelectedItems.length,
                                  itemBuilder: (_, index) => ListTile(
                                      title: Align(
                                        alignment:
                                            loadCurrentLangFromDB() == "en"
                                                ? Alignment.topRight
                                                : Alignment.topLeft,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Text(
                                            '${mechanicServicesCartProvider.breakDownListSelectedItems[index].subproblem ?? "لم يتم تحديد مشكله فرعيه"}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                        ),
                                      ),
                                      subtitle: Align(
                                        alignment:
                                            loadCurrentLangFromDB() == "en"
                                                ? Alignment.topRight
                                                : Alignment.topLeft,
                                        child: FittedBox(
                                          fit: BoxFit.fill,
                                          child: Text(
                                            '${mechanicServicesCartProvider.breakDownListSelectedItems[index].problem}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      )),

                                  separatorBuilder: (context, index) {
                                    return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02),
                                        child: Divider(
                                          thickness: 1.5,
                                        ));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
    ),
  );
}
