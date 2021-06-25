import 'dart:ui';

import 'package:customer_app/provider/mechanic_services/mechanic_services_cart.dart';
import 'package:customer_app/provider/mechanic_services/mechanic_services_provider.dart';
import 'package:customer_app/screens/to_mechanic/mechanic_services/components/circle_painter.dart';
import 'package:customer_app/screens/to_mechanic/mechanic_services/view_selected_mechanic_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../../../local_db/customer_db/cutomer_owned_cars_model.dart';
import '../../../../provider/customer_cars/customer_car_provider.dart';
import '../../../../provider/customer_cars/customer_car_provider.dart';
import '../../helpme.dart';
import '../../problems.dart';

class BreakDownServices extends StatefulWidget {
  static String routeName = '/BreakDownServices';
  @override
  _BreakDownServicesState createState() => _BreakDownServicesState();
}

class _BreakDownServicesState extends State<BreakDownServices>
    with SingleTickerProviderStateMixin {
  //["Exterior", "Interior", "Engine", "Chasis", "Help me"];
  @override
  void initState() {
    super.initState();
    final mechanicServiceProviderObj =
        Provider.of<MechanicServiceProvider>(context, listen: false);
    //mechanicServiceProviderObj.getBreakDownListFromBackend();
    // mechanicServiceProviderObj.getBreakDownByCategory();
    // //mechanicServiceProviderObj.getItems();
    // mechanicServiceProviderObj
    //     .onTapList(mechanicServiceProviderObj.selectedIndex);
    mechanicServiceProviderObj.tabController = TabController(
      initialIndex: Provider.of<MechanicServiceProvider>(context, listen: false)
          .selectedIndex,
      length: mechanicServiceProviderObj.convertedListOfCategoryKeys.length,
      vsync: this,
    );

    mechanicServiceProviderObj.tabController.addListener(() {
      mechanicServiceProviderObj.scrollController
          .move(mechanicServiceProviderObj.tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.15;
    // List categoriesList =
    //     Provider.of<MechanicServiceProvider>(context).mapOne.keys.toList();
    return Consumer3<CustomerCarProvider, MechanicServiceProvider,
        MechanicServicesCartProvider>(
      builder: (context, CustomerCarProvider, mechanicServiceProvider,
              mechanicServicesCartProvider, child) =>
          Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: size.height,
                width: size.width,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.015,
                          horizontal: size.width * 0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Break Downs",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.01),
                      child: Row(
                        children: [
                          Icon(
                            Icons.directions_car_rounded,
                            color: Colors.white,
                            size: size.height * 0.035,
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              dropdownColor: Colors.grey.withOpacity(0.5),
                              style: TextStyle(color: Colors.black),
                              iconEnabledColor: Colors.white,
                              hint: Text(
                                  CustomerCarProvider.selectedCar ??
                                      "Select One Of Your Cars",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              value: CustomerCarProvider.selectedCar,
                              onChanged: (String newValue) {
                                CustomerCarProvider.setSelectedItem(newValue);
                              },
                              items: CustomerCarProvider.items
                                  .map<DropdownMenuItem<String>>(
                                      (customerOwnedCarsDB value) {
                                return DropdownMenuItem<String>(
                                  value: value.id,
                                  child: Text(
                                    value.CarBrand +
                                        " " +
                                        value.Model +
                                        "-" +
                                        value.Year,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: new BoxDecoration(
                  color: Colors.redAccent,
                  image: new DecorationImage(
                      alignment: Alignment.topCenter,
                      colorFilter: new ColorFilter.mode(
                          Colors.black.withOpacity(0.3), BlendMode.dstATop),
                      image: AssetImage(
                          "assets/images/Car Inspection, Online Used Car Inspection Services in India.png")),
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.15,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       top: MediaQuery.of(context).size.height * 0.015),
                        //   child: Container(
                        //     height: 5,
                        //     width: size.width * 0.5,
                        //     decoration: BoxDecoration(
                        //       color: Colors.grey.withOpacity(0.2),
                        //       borderRadius: BorderRadius.circular(5),
                        //     ),
                        //   ),
                        // ),
                        TabBar(
                          onTap: (index) {
                            mechanicServiceProvider.selectedIndex = index;
                            mechanicServiceProvider.onTapList(index);
                            return mechanicServiceProvider.getCurrentTab(index);
                          },
                          controller: mechanicServiceProvider.tabController,
                          isScrollable: true,

                          indicatorColor:
                              Colors.white, //Color.fromRGBO(0, 202, 157, 1),
                          labelColor: Colors.white,
                          labelStyle: TextStyle(fontSize: 17),
                          unselectedLabelColor: Colors.black54,
                          tabs: List<Widget>.generate(
                              mechanicServiceProvider
                                  .convertedListOfCategoryKeys
                                  .length, (int index) {
                            return Tab(
                              // text: list_name[index],
                              child: Container(
                                //height: size.height * 0.5,
                                width: size.width * 0.2,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: index ==
                                          mechanicServiceProvider.selectedIndex
                                      ? Colors.redAccent.withOpacity(0.8)
                                      : Colors.grey.withOpacity(0.15),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(""),
                                    Text(
                                      mechanicServiceProvider
                                          .convertedListOfCategoryKeys[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                        Container(
                          height: size.height * 0.65,
                          child: new Swiper(
                            onIndexChanged: (index) {
                              mechanicServiceProvider.getCurrentIndex(index);
                              mechanicServiceProvider.tabController
                                  .animateTo(index);
                            },
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return problems();
                              // mechanicServiceProvider.selectedIndex ==
                              //       index
                              //? helpme()
                            },
                            itemCount: mechanicServiceProvider
                                .convertedListOfCategoryKeys.length,
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: size.height * 0.05,
                        height: size.height * 0.05,
                        child: CustomPaint(
                            painter:
                                CirclePainter(), //fromRadius(size.height * 0.1),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                  mechanicServicesCartProvider.cartCounter
                                      .toString(),
                                  style: TextStyle(color: Colors.white)),
                            )),
                      ),
                      SizedBox(width: size.width * 0.02),
                      Text("View Selected",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors
                                  .white) //Theme.of(context).textTheme.headline2,
                          ),
                    ],
                  ),
                  //SizedBox(width: size.width*0.02),
                  Text(
                      "Visit Fare : ${mechanicServicesCartProvider.visitFare} EGP",
                      style: TextStyle(fontSize: 16, color: Colors.white))
                ],
              ),
              style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.redAccent),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.redAccent.withOpacity(0.9)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(width: 1.5, color: Colors.white)))),
              onPressed: () {
                if (CustomerCarProvider.selectedCar != null &&
                    mechanicServicesCartProvider.cartCounter > 0) {
                  Navigator.of(context)
                      .pushNamed(ViewSelectedMechanicServices.routeName);
                } else {
                  if (CustomerCarProvider.selectedCar == null)
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Please choose one of your cars !')));
                  if (mechanicServicesCartProvider.cartCounter == 0)
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('You should select one problem !')));
                }
              }),
        ),
      ),
    );
  }
}
// @override
// Widget build(BuildContext context) {
//   final Size size = MediaQuery.of(context).size;
//   final double categoryHeight = size.height * 0.15;
//   return DefaultTabController(
//     length: list_name.length,
//     child: Scaffold(
//       body: Container(
//         child: Column(
//           children: [
//             Expanded(
//               flex: 3,
//               child: Container(
//                 height: categoryHeight,
//                 child: Column(
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: <Widget>[
//                         Padding(
//                           padding: EdgeInsets.only(
//                               left: size.width * 0.1, top: size.height * 0.1),
//                           child: Text(
//                             "What is the wrong with you car ?",
//                             style:
//                             TextStyle(color: Colors.blue, fontSize: 20),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     TextFormField(
//                       keyboardType: TextInputType.text,
//                       style: TextStyle(fontSize: 20, color: Colors.blue),
//                       decoration: InputDecoration(
//                           hintText: "Enter Car-Type Model",
//                           hintStyle:
//                           TextStyle(fontSize: 20.0, color: Colors.blue)),
//                     ),
//                     Container(
//                         padding: EdgeInsets.only(
//                           top: size.height * 0.02,
//                         ),
//                         height: categoryHeight,
//                         child: DefaultTabController(
//                           length: list_name.length,
//                           child: Container(
//                             width: 510,
//                             height: 300,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Colors.blue,
//                                 width: 4,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.blue,
//                                   offset: const Offset(
//                                     5.0,
//                                     5.0,
//                                   ), //Offset
//                                   blurRadius: 10.0,
//                                   spreadRadius: 2.0,
//                                 ), //BoxShadow
//                                 BoxShadow(
//                                   color: Colors.white,
//                                   offset: const Offset(0.0, 0.0),
//                                   blurRadius: 0.0,
//                                   spreadRadius: 0.0,
//                                 ), //BoxShadow
//                               ],
//                             ),
// //                             constraints: BoxConstraints(maxHeight: 35.0),
//                             child: Material(
//                               child: TabBar(
//                                 onTap: (index) =>
//                                     _scrollController.move(index),
//                                 controller: tabController,
//                                 isScrollable: true,
//                                 indicatorColor:
//                                 Color.fromRGBO(0, 202, 157, 1),
//                                 labelColor: Colors.black,
//                                 labelStyle: TextStyle(fontSize: 17),
//                                 unselectedLabelColor: Colors.black,
//                                 tabs: List<Widget>.generate(list_name.length,
//                                         (int index) {
//                                       return new Tab(text: list_name[index]);
//                                     }),
//                               ),
//                             ),
//                           ),
//                         )),
//                     SizedBox(
//                       height: categoryHeight,
//                     ),
//                     Expanded(
//                       child: new Swiper(
//                         onIndexChanged: (index) {
//                           setState(() {
//                             selectedIndex = index;
//                             tabController.animateTo(index);
//                             currentindex2 = index;
//                             print(index);
//                           });
//                         },
//                         onTap: (index) {
//                           setState(() {
//                             selectedIndex = index;
//                             tabController.animateTo(index);
//                             currentindex2 = index;
//                             print(index);
//                           });
//                         },
//                         duration: 2,
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder: (BuildContext context, int index) {
//                           return new Swiper(
//                             duration: 2,
//                             controller: _scrollController,
//                             scrollDirection: Axis.vertical,
//                             itemBuilder: (BuildContext context, int index) {
//                               return VisibilityDetector(
//                                 key: Key(index.toString()),
//                                 child: Container(
//                                   child: selectedIndex == 4
//                                       ? helpme()
//                                       : problems(),
//                                 ),
//                                 onVisibilityChanged: (VisibilityInfo info) {
//                                   if (info.visibleFraction == 1)
//                                     setState(() {
//                                       selectedIndex = index;
//                                       tabController.animateTo(index);
//                                       currentindex2 = index;
//                                       print(index);
//                                     });
//                                 },
//                               );
//                             },
//                             itemCount: list_name.length,
//                           );
//                         },
//                         itemCount: list_name.length,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
// }
