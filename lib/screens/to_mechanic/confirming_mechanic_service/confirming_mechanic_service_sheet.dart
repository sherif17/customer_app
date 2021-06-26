import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:customer_app/local_db/customer_db/customer_info_db.dart';
import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/provider/mechanic_request/mechnic_request_provider.dart';
import 'package:customer_app/provider/mechanic_services/mechanic_services_cart.dart';
import 'package:customer_app/provider/winch_request/winch_request_provider.dart';
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
            Stack(
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
                    buildShowingLocationContainer(
                        context, mechanicRequestProvider, mapsProvider),
                  ],
                );
              },
            ),
            buildFrontContainer(context)
          ],
        ),
      ),
    );
  }

  Positioned buildFrontContainer(BuildContext context) {
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
                      child: Text("150 \n EGP",
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w900,
                              fontSize: 20))),
                ),
              ],
            ),
            TextButton(
                child: Text("Find Me A Mechanic".toUpperCase(),
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w900,
                        fontSize: 20) //Theme.of(context).textTheme.headline2,
                    ),
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
                onPressed: () {
                  // Navigator.pop(context);
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
