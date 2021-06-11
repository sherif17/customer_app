import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/provider/winch_request/winch_request_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ConfirmingMechanicServiceSheet extends StatelessWidget {
  static String routeName = '/ConfirmingMechanicServiceSheet';
  BuildContext ctx;

  ConfirmingMechanicServiceSheet();

  // void _launchDial(String number) async => await canLaunch("tel:$number")
  //     ? await launch("tel:$number")
  //     : throw 'Could not launch tel:$number';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Consumer<MapsProvider>(
        builder: (context, MapsProvider, child) => Stack(
          children: [
            DraggableScrollableSheet(
              initialChildSize: 0.1,
              minChildSize: 0.1,
              maxChildSize: 0.8,
              builder: (BuildContext myContext, controller) {
                const colorizeColors = [
                  Colors.white,
                  Colors.white,
                  Colors.grey
                ];

                const colorizeTextStyle = TextStyle(
                  fontSize: 30,
                  fontFamily: 'Horizon',
                  decoration: TextDecoration.none,
                );

                return SingleChildScrollView(
                  controller: controller,
                  child: Stack(
                    clipBehavior: Clip.none,
                    //alignment: Alignment.topCenter, //Alignment(, -1),
                    //clipBehavior: Clip.antiAliasWithSaveLayer,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.32,
                        decoration: BoxDecoration(
                            color: Color(
                                0xFF4F5266), //Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.015),
                              child: Container(
                                height: 6,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: MediaQuery.of(context).size.height *
                                      0.005),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: GestureDetector(
                                        onTap: () {
                                          // _launchDial(WinchRequestProvider
                                          //         .upcomingRequestResponseModel
                                          //         .phoneNumber ??
                                          //     "0000");
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.06,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08,
                                          decoration: new BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.call,
                                            size: 23,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  //  Text("no"),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    child: Expanded(
                                      flex: 5,
                                      child: AnimatedTextKit(
                                        animatedTexts: [
                                          ColorizeAnimatedText(
                                            "Model",
                                            textStyle: colorizeTextStyle,
                                            colors: colorizeColors,
                                          ),
                                          ColorizeAnimatedText(
                                            'at 2:30',
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'Horizon',
                                              decoration: TextDecoration.none,
                                            ), //colorizeTextStyle,
                                            colors: colorizeColors,
                                          ),
                                        ],
                                        repeatForever: true,
                                        isRepeatingAnimation: true,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.06,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                        decoration: new BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(Icons.chat,
                                            size: 23,
                                            color:
                                                Color(0xFF4F5266) //Colors.grey,
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
                      Positioned(
                        top: MediaQuery.of(context).size.height * -0.03,
                        left: MediaQuery.of(context).size.width * 0.2,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.6,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.75,
              //right: 5,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("FName",
                            style: TextStyle(
                                color: Colors.black54,
                                decoration: TextDecoration.none,
                                fontSize: 18)),
                        Stack(
                          children: [
                            SvgPicture.asset("assets/icons/sport-car.svg",
                                width:
                                    MediaQuery.of(context).size.width * 0.12),
                            Positioned(
                              top: 20,
                              // right: 25,
                              child: SvgPicture.asset(
                                  "assets/icons/profile.svg",
                                  width:
                                      MediaQuery.of(context).size.width * 0.07),
                            ),
                          ],
                        ),
                        Text("CarPlates",
                            style: TextStyle(
                                color: Colors.black54,
                                decoration: TextDecoration.none,
                                fontSize: 20)),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
