import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:customer_app/local_db/customer_db/cutomer_owned_cars_model.dart';
import 'package:customer_app/models/maps/direction_details.dart';
import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/provider/maps_preparation/polyLineProvider.dart';
import 'package:customer_app/provider/winch_request/winch_request_provider.dart';
import 'package:customer_app/screens/dash_board/dash_board.dart';
import 'package:customer_app/screens/winch_service/to_winch_map.dart';
import 'package:customer_app/services/maps_services/maps_services.dart';
import 'package:customer_app/widgets/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../../provider/maps_preparation/mapsProvider.dart';

class StartedWinchServiceSheet extends StatefulWidget {
  const StartedWinchServiceSheet({key}) : super(key: key);

  @override
  _StartedWinchServiceSheetState createState() =>
      _StartedWinchServiceSheetState();
}

String driverFirstName;
String driverLastName;

class _StartedWinchServiceSheetState extends State<StartedWinchServiceSheet> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Box<customerOwnedCarsDB> selectedCar =
        Provider.of<CustomerCarProvider>(context, listen: false)
            .customerOwnedCars;
    driverFirstName = Provider.of<WinchRequestProvider>(context, listen: false)
            .checkRequestStatusResponseModel
            .firstName ??
        "FName";
    driverLastName = Provider.of<WinchRequestProvider>(context, listen: false)
            .checkRequestStatusResponseModel
            .lastName ??
        "LName";
    String carPlates = Provider.of<WinchRequestProvider>(context, listen: false)
            .checkRequestStatusResponseModel
            .winchPlates ??
        "CarPlates";

    LatLng winchPosition = LatLng(
      double.parse(Provider.of<WinchRequestProvider>(context, listen: false)
              .checkRequestStatusResponseModel
              .driverLocationLat ??
          "31.21207"),
      double.parse(Provider.of<WinchRequestProvider>(context, listen: false)
              .checkRequestStatusResponseModel
              .driverLocationLong ??
          "29.90909"),
    );

    String carType = "Chevrolet";

    int estimatedFare =
        Provider.of<MapsProvider>(context, listen: false).estimatedFare;
    String estimatedDuration = Provider.of<MapsProvider>(context, listen: false)
        .tripDirectionDetails
        .durationText;

    String dropOffLocationPlaceName =
        Provider.of<MapsProvider>(context, listen: false)
            .dropOffLocation
            .placeName;
    String pickUpLocationPlaceName =
        Provider.of<MapsProvider>(context, listen: false)
            .pickUpLocation
            .placeName
            .substring(0, 30);

    String estimatedArrivalTime = MapsApiService.calculateArrivalTime(context);

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Consumer4<WinchRequestProvider, PolyLineProvider, MapsProvider,
          CustomerCarProvider>(
        builder: (context, WinchRequestProvider, PolyLineProvider, MapsProvider,
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
                    height: MediaQuery.of(context).size.height * 0.45,
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
                                              "Heading To ${MapsProvider.dropOffLocation.placeName}",
                                            ),
                                            // FadeAnimatedText(
                                            //     "Winch driver in his way to you"),
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
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(
                                                  0.5, // Move to right 10  horizontally
                                                  1.0,
                                                ),
                                              ),
                                            ],
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(2),
                                              topRight: Radius.circular(2),
                                              topLeft: Radius.circular(2),
                                              bottomRight: Radius.circular(2),
                                            ),
                                          ),
                                          child: Expanded(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  "${PolyLineProvider.tripDirectionDetails.durationText} Away",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ),
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
                                      Text(
                                        dropOffLocationPlaceName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
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
                                        selectedCar
                                                .get(CustomerCarProvider
                                                    .selectedCar)
                                                .CarBrand +
                                            " " +
                                            selectedCar
                                                .get(CustomerCarProvider
                                                    .selectedCar)
                                                .Model,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    selectedCar
                                        .get(CustomerCarProvider.selectedCar)
                                        .Plates,
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.normal),
                                  ),
                                )
                              ],
                            ),
                          ),
                          DividerWidget(),
                          GestureDetector(
                            onTap: () async {
                              await WinchRequestProvider
                                  .cancelWinchDriverRequest();
                              if (WinchRequestProvider.isLoading == false) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    ToWinchMap.routeName,
                                    ModalRoute.withName(DashBoard.routeName));
                              }
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.01,
                  ),
                  Container(
                    height: size.height * 0.2,
                    color: Colors.white,
                    child: Column(children: [
                      DividerWidget(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildDriverInfo(size),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    "${driverFirstName + " " + driverLastName}",
                                    style:
                                        Theme.of(context).textTheme.headline2),
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
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
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
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.08),
                          child: Text(carPlates,
                              style: Theme.of(context).textTheme.headline4),
                        ),
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

  Stack buildDriverInfo(Size size) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: SvgPicture.asset(
            "assets/icons/Fire_truck.svg",
            width: size.width * 0.4,
            height: size.height * 0.09,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.056,
                right: size.width * 0.01,
                top: size.height * 0.04),
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
}
