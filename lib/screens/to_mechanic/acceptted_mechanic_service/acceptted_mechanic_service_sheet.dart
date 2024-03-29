import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/provider/maps_preparation/polyLineProvider.dart';
import 'package:customer_app/provider/mechanic_request/mechnic_request_provider.dart';
import 'package:customer_app/provider/mechanic_services/mechanic_services_cart.dart';
import 'package:customer_app/screens/dash_board/dash_board.dart';
import 'package:customer_app/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AcceptedMechanicServiceSheet extends StatefulWidget {
  const AcceptedMechanicServiceSheet({key}) : super(key: key);

  @override
  _AcceptedMechanicServiceSheetState createState() =>
      _AcceptedMechanicServiceSheetState();
}

String driverFirstName;
String driverLastName;

class _AcceptedMechanicServiceSheetState
    extends State<AcceptedMechanicServiceSheet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // Box<customerOwnedCarsDB> selectedCar =
    //     Provider.of<CustomerCarProvider>(context, listen: false)
    //         .customerOwnedCars;
    driverFirstName =
        Provider.of<MechanicRequestProvider>(context, listen: false)
                .checkMechanicRequestStatusResponseModel
                .firstName ??
            "FName";
    driverLastName =
        Provider.of<MechanicRequestProvider>(context, listen: false)
                .checkMechanicRequestStatusResponseModel
                .lastName ??
            "LName";
    String carPlates =
        // Provider.of<WinchRequestProvider>(context, listen: false)
        // .checkRequestStatusResponseModel
        // .winchPlates ??
        "CarPlates";

    LatLng winchPosition = LatLng(
      double.parse(
          // Provider.of<WinchRequestProvider>(context, listen: false)
          // .checkRequestStatusResponseModel
          // .driverLocationLat ??
          "31.21207"),
      double.parse(
          // Provider.of<WinchRequestProvider>(context, listen: false)
          // .checkRequestStatusResponseModel
          // .driverLocationLong ??
          "29.90909"),
    );

    String carType = "Chevrolet";

    double estimatedFare =

        /// Provider.of<MapsProvider>(context, listen: false).estimatedFare +
        Provider.of<MechanicServicesCartProvider>(context, listen: false)
            .finalFare;

    // String estimatedDuration = Provider.of<MapsProvider>(context, listen: false)
    //     .tripDirectionDetails
    //     .durationText;

    String dropOffLocationPlaceName =
        Provider.of<MechanicRequestProvider>(context, listen: false)
            .mechanicLocation
            .placeName;
    // String pickUpLocationPlaceName =
    //     Provider.of<MapsProvider>(context, listen: false)
    //         .pickUpLocation
    //         .placeName
    //         .substring(0, 30);

    // String estimatedArrivalTime = MapsApiService.calculateArrivalTime(context);

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Consumer3<MechanicRequestProvider, PolyLineProvider,
          CustomerCarProvider>(
        builder: (context, MechanicRequestProvider, PolyLineProvider,
                CustomerCarProvider, child) =>
            DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.4,
          maxChildSize: 0.72,
          builder: (BuildContext myContext, controller) {
            return SingleChildScrollView(
              controller: controller,
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          //vertical: 17.0,
                          //horizontal: 15.0,
                          ),
                      child: Column(
                        children: [
                          Container(
                            height: size.height * 0.1,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.01),
                                  child: Container(
                                    height: size.height * 0.008,
                                    width: size.width * 0.15,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.02),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: AnimatedTextKit(
                                          animatedTexts: [
                                            FadeAnimatedText(
                                              "Meet Mechanic at pickup point",
                                            ),
                                            FadeAnimatedText(
                                                "Mechanic in his way to you"),
                                          ],
                                          repeatForever: true,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: size.height * 0.08,
                                          width: size.width * 0.05,
                                          // color: Colors.blueAccent,
                                          decoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(2),
                                              topRight: Radius.circular(2),
                                              topLeft: Radius.circular(2),
                                              bottomRight: Radius.circular(2),
                                            ),
                                          ),
                                          child: PolyLineProvider
                                                      .tripDirectionDetails
                                                      .durationText !=
                                                  null
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      //"duration",
                                                      PolyLineProvider
                                                          .tripDirectionDetails
                                                          .durationText,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20),
                                                    ),
                                                    Text("Away",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20)),
                                                  ],
                                                )
                                              : CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          DividerWidget(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildDriverInfo(size),
                              // Padding(
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal: size.width * 0.05),
                              //   child: Text(carPlates,
                              //       style:
                              //           Theme.of(context).textTheme.headline2),
                              // )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  driverFirstName + " " + driverLastName + " .",
                                  style: Theme.of(context).textTheme.subtitle2),
                              TextButton.icon(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.star_half,
                                    color: Colors.yellowAccent,
                                  ),
                                  label: Text(
                                    "4.9",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: size.width * 0.03),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      // border: Border.all(color: Colors.grey),
                                      color: Colors.grey[200].withOpacity(0.5),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              25)), // BorderRadius.circular(5.0),
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
                                            "Chat with mechanic here",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                          // Icon(
                                          //   Icons.search,
                                          //   color: Theme.of(context).hintColor,
                                          // ),
                                          //SizedBox(width: size.width * 0.0001,),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: size.height * 0.06,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      //border: Border.all(color: Colors.grey),
                                      color: Colors.grey[200].withOpacity(0.5),
                                      // BorderRadius.circular(5.0),
                                    ),
                                    child: Icon(
                                      Icons.call,
                                      color: Colors.greenAccent,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.01,
                  ),
                  Container(
                    height: size.height * 0.32,
                    color: Colors.white,
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.01,
                            vertical: size.height * 0.025),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 16,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.01,
                                  ),
                                  dropOffLocationPlaceName != null
                                      ? Text(
                                          //"dropOffLocationPlaceName",
                                          dropOffLocationPlaceName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2,
                                        )
                                      : CircularProgressIndicator(
                                          color: Colors.green,
                                        ),
                                ],
                              ),
                            ),
                            // Expanded(
                            //   flex: 2,
                            //   child: Column(
                            //     children: [
                            //       Text(
                            //         "drop off by",
                            //         style: TextStyle(
                            //             color: Colors.blue,
                            //             fontWeight: FontWeight.normal),
                            //       ),
                            //       Text("$estimatedArrivalTime",
                            //           style: TextStyle(
                            //               color: Colors.blue,
                            //               fontWeight: FontWeight.normal))
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      DividerWidget(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.01,
                            vertical: size.height * 0.025),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 14,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.money,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.01,
                                  ),
                                  Text(
                                    estimatedFare.toString() + " EGP",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Cash",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.normal),
                              ),
                            )
                          ],
                        ),
                      ),
                      DividerWidget(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.01,
                            vertical: size.height * 0.025),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 14,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.car_repair,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.01,
                                  ),
                                  Text(
                                    // selectedCar
                                    //         .get(
                                    //             CustomerCarProvider.selectedCar)
                                    //         .CarBrand +
                                    //     " " +
                                    //     selectedCar
                                    //         .get(
                                    //             CustomerCarProvider.selectedCar)
                                    //         .Model,

                                    CustomerCarProvider.selectedCarInfo,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                "مصع",
                                // selectedCar
                                //     .get(CustomerCarProvider.selectedCar)
                                //     .Plates,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.normal),
                              ),
                            )
                          ],
                        ),
                      ),
                      DividerWidget(),
                      MechanicRequestProvider.cancelMechanicRequestIsLoading ==
                              false
                          ? GestureDetector(
                              onTap: () async {
                                await MechanicRequestProvider
                                    .cancelMechanicRequest(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(12),
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
                          : CircularProgressIndicator(
                              color: Colors.red,
                            )
                    ]),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

Stack buildDriverInfo(Size size) {
  return Stack(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: SvgPicture.asset(
          "assets/illustrations/mechanic.svg",
          width: size.width * 0.4,
          height: size.height * 0.09,
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(
              left: size.width * 0.03,
              right: size.width * 0.01,
              top: size.height * 0.035),
          child: AdvancedAvatar(
            name: "${driverFirstName + " " + driverLastName}",
            decoration: BoxDecoration(
              color: Colors.blueAccent.withOpacity(0.90),
              shape: BoxShape.circle,
            ),
            style: TextStyle(color: Colors.white, fontSize: 25),
            statusColor: Colors.greenAccent,
            size: 50,
          ),
        ),
      )
    ],
  );
}
