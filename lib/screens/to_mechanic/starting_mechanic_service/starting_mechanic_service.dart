import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/provider/mechanic_request/mechnic_request_provider.dart';
import 'package:customer_app/screens/to_mechanic/starting_mechanic_service/cheking_componants/ripple_animation.dart';
import 'package:customer_app/screens/to_mechanic/starting_mechanic_service/service_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class StartingMechanicService extends StatefulWidget {
  static String routeName = '/StartingMechanicService';
  const StartingMechanicService({key}) : super(key: key);

  @override
  _StartingMechanicServiceState createState() =>
      _StartingMechanicServiceState();
}

class _StartingMechanicServiceState extends State<StartingMechanicService> {
  // TabController _tabController;
  // @override
  // void initState() {
  // _tabController = TabController(length: 2, vsync: this);
  // super.initState();
  // }
  //
  // @override
  // void dispose() {
  // super.dispose();
  // _tabController.dispose();
  // }
  @override
  void initState() {
    super.initState();
    serviceFinished(context);
  }

  serviceFinished(context) async {
    Provider.of<MechanicRequestProvider>(context, listen: false)
        .isNavigatedToStartingService = true;
    await Provider.of<MechanicRequestProvider>(context, listen: false)
        .waitingForEndingMechanicService(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer2<MechanicRequestProvider, CustomerCarProvider>(
      builder: (context, mechanicRequestProvider, customerCarProvider, child) =>
          Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     "Working On Customer Car",
        //     style: Theme.of(context).textTheme.headline6,
        //   ),
        // ),
        body: SafeArea(
          child: Container(
            decoration: new BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              image: new DecorationImage(
                  fit: BoxFit.fill,
                  alignment: Alignment.topCenter,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.1), BlendMode.dstATop),
                  image: AssetImage(
                      "assets/images/istockphoto-1226504936-1024x1024.jpg")),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    RipplesAnimation(),
                    ServiceTimer(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "Starting Mechanic Service",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      )),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: size.height * 0.2,
                    width: size.width * 0.9,
                    child: DefaultTextStyle(
                      style: const TextStyle(
                          fontSize: 30,
                          fontFamily: 'Canterbury',
                          color: Color(0xFF4F5266),
                          fontWeight: FontWeight.bold),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: AnimatedTextKit(
                          isRepeatingAnimation: true,
                          animatedTexts: [
                            ScaleAnimatedText(
                                "Mechanic working on ${customerCarProvider.selectedCarInfo ?? "car info"} Now",
                                duration: Duration(seconds: 4)),
                            ScaleAnimatedText('Take a coffee break for while',
                                duration: Duration(seconds: 4)),
                            ScaleAnimatedText('When mechanic finish his work',
                                duration: Duration(seconds: 4)),
                            ScaleAnimatedText(
                                'We will notify you to pay the fare',
                                duration: Duration(seconds: 4))
                          ],
                          repeatForever: true,
                        ),
                      ),
                    ),
                  ),
                ),
                // Stack(
                //   children: [
                //     DraggableScrollableSheet(
                //       initialChildSize: 0.25,
                //       minChildSize: 0.25,
                //       maxChildSize: 1,
                //       builder: (BuildContext myContext, controller) {
                //         const colorizeColors = [
                //           Color(0xFF4F5266),
                //           //Colors.white,
                //           Colors.grey
                //         ];
                //
                //         const colorizeTextStyle = TextStyle(
                //           fontSize: 20,
                //           fontFamily: 'Horizon',
                //           decoration: TextDecoration.none,
                //         );
                //         return SingleChildScrollView(
                //           controller: controller,
                //           child: Container(
                //             height: MediaQuery.of(context).size.height,
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.only(
                //                 topLeft: Radius.circular(15),
                //                 topRight: Radius.circular(15),
                //               ),
                //               boxShadow: <BoxShadow>[
                //                 BoxShadow(
                //                     color: Colors.grey,
                //                     blurRadius: 15.0,
                //                     offset: Offset(0.0, 0.75))
                //               ],
                //             ),
                //             child: Column(
                //                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                 children: [
                //                   Padding(
                //                       padding: EdgeInsets.only(
                //                           top:
                //                               MediaQuery.of(context).size.height *
                //                                   0.015),
                //                       child: Container(
                //                         height: 6,
                //                         width: 90,
                //                         decoration: BoxDecoration(
                //                           color: Colors.grey.withOpacity(0.6),
                //                           borderRadius: BorderRadius.circular(5),
                //                         ),
                //                       )),
                //                   Padding(
                //                     padding: const EdgeInsets.all(8.0),
                //                     child: Row(
                //                       mainAxisAlignment: MainAxisAlignment.center,
                //                       children: [
                //                         FittedBox(
                //                           fit: BoxFit.fill,
                //                           child: AnimatedTextKit(
                //                             animatedTexts: [
                //                               ColorizeAnimatedText(
                //                                 "Please Start Working On Customer Car",
                //                                 //  "${mechanicRequestProvider.getNearestClientResponseModel.CarBrand + " " + mechanicRequestProvider.getNearestClientResponseModel.CarModel}",
                //                                 /*"${WinchRequestProvider.upcomingRequestResponseModel.carBrand ?? "Car Brand"}-${WinchRequestProvider.upcomingRequestResponseModel.carModel ?? "Model"}",*/
                //                                 textStyle: colorizeTextStyle,
                //                                 colors: colorizeColors,
                //                               ),
                //                               ColorizeAnimatedText(
                //                                 "Slide UpTo Revise Customer Requirement",
                //                                 //'Meet ${WinchRequestProvider.upcomingRequestResponseModel.firstName ?? "FName"} at 2:30',
                //                                 textStyle: TextStyle(
                //                                   fontSize: 20,
                //                                   fontFamily: 'Horizon',
                //                                   decoration: TextDecoration.none,
                //                                 ), //colorizeTextStyle,
                //                                 colors: colorizeColors,
                //                               ),
                //                             ],
                //                             repeatForever: true,
                //                             isRepeatingAnimation: true,
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                   Padding(
                //                     padding: const EdgeInsets.all(8.0),
                //                     child: DividerWidget(),
                //                   ),
                //                   SizedBox(height: 30.0),
                //                   Padding(
                //                     padding: const EdgeInsets.all(8.0),
                //                     child: Container(
                //                       height: 45,
                //                       decoration: BoxDecoration(
                //                         color: Colors.grey[200],
                //                         borderRadius: BorderRadius.circular(
                //                           5,
                //                         ),
                //                       ),
                //                       child: TabBar(
                //                         controller: _tabController,
                //                         indicator: BoxDecoration(
                //                           borderRadius: BorderRadius.circular(
                //                             5,
                //                           ),
                //                           color: Color(
                //                               0xFF4F5266), //Theme.of(context).primaryColor,
                //                         ),
                //                         labelColor: Theme.of(context).accentColor,
                //                         unselectedLabelColor: Colors.black,
                //                         tabs: [
                //                           // actions tab
                //                           Tab(
                //                             text: 'Approved Fixes',
                //                           ),
                //
                //                           // details tab
                //                           Tab(
                //                             text: 'Car Details',
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                   ),
                //                   // tab bar view here
                //                   Expanded(
                //                       child: TabBarView(
                //                     controller: _tabController,
                //                     children: [
                //                       // Actions tab bar view widget
                //                       Center(
                //                         child: Container(
                //                           child: ApprovedFixes(),
                //                         ),
                //                       ),
                //
                //                       // Details tab bar view widget
                //                       Center(
                //                         child: Container(
                //                           child: CarDetails(),
                //                         ),
                //                       ),
                //                     ],
                //                   )),
                //                 ]),
                //           ),
                //         );
                //       },
                //     ),
                //     Positioned(
                //       top: MediaQuery.of(context).size.height * 0.75,
                //       child: Container(
                //         height: MediaQuery.of(context).size.height * 0.15,
                //         width: MediaQuery.of(context).size.width,
                //         decoration: BoxDecoration(
                //             color: Color(
                //                 0xFF4F5266), //Colors.blueGrey, //Theme.of(context).primaryColorLight,
                //             borderRadius: BorderRadius.only(
                //               topLeft: Radius.circular(10),
                //               topRight: Radius.circular(10),
                //             )),
                //         child: // Center(child: Container(child: SliderButton(action: () {}))
                //             //Text("no")
                //             Center(
                //           child: SliderButton(
                //             //dismissible: false,
                //             action: () async {
                //               await mechanicRequestProvider
                //                   .endCurrentMechanicService(context);
                //
                //               ///Do something here
                //               print("slided");
                //               //Navigator.of(context).pop();
                //             },
                //             label: Text(
                //               "Slide When You Finish Service",
                //               style: TextStyle(
                //                   color: Color(0xff4a4a4a),
                //                   fontWeight: FontWeight.w500,
                //                   decoration: TextDecoration.none,
                //                   fontSize: 17),
                //             ),
                //             // child: Container(
                //             //   // color: Colors.green,
                //             //   height: 60,
                //             //   decoration: BoxDecoration(
                //             //       // border: Border.all(
                //             //       //   color: Colors.red,
                //             //       // ),
                //             //       boxShadow: <BoxShadow>[
                //             //         BoxShadow(
                //             //             color: Colors.deepPurple.withOpacity(0.2),
                //             //             blurRadius: 15.0,
                //             //             offset: Offset(0.0, 0.5))
                //             //       ],
                //             //       color: Colors
                //             //           .green, //Color(0xFF4F5266), //Colors.blueGrey, //Theme.of(context).primaryColorLight,
                //             //       borderRadius: BorderRadius.all(
                //             //         Radius.circular(10),
                //             //       )),
                //             //   child: Padding(
                //             //     padding: const EdgeInsets.all(8.0),
                //             //     child: CircularCountDownTimer(
                //             //       width: 40,
                //             //       height: 40,
                //             //       duration: 59,
                //             //       fillColor: Colors.grey,
                //             //       ringColor: Theme.of(context).primaryColorLight,
                //             //       //  isReverseAnimation: true,
                //             //       isReverse: true,
                //             //       backgroundColor: Theme.of(context).accentColor,
                //             //       onComplete: () {
                //             //         // Navigator.pop(context);
                //             //       },
                //             //       isTimerTextShown: true,
                //             //     ),
                //             //   ),
                //             // ),
                //             icon: Icon(
                //               Icons.arrow_right_alt_rounded,
                //               color: Colors.white,
                //               size: 60,
                //             ),
                //             width: MediaQuery.of(context).size.width * 0.8,
                //             radius: 20,
                //             buttonColor: Colors.green
                //                 .withOpacity(0.9), //Color(0xffd60000),
                //             backgroundColor: Colors.white, //Color(0xff534bae),
                //             highlightedColor: Colors.greenAccent,
                //             baseColor: Colors.green,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
