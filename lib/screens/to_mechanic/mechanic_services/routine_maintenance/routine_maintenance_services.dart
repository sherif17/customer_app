import 'package:customer_app/local_db/customer_db/cutomer_owned_cars_model.dart';
import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/provider/mechanic_services/mechanic_services_cart.dart';
import 'package:customer_app/provider/mechanic_services/mechanic_services_provider.dart';
import 'package:customer_app/screens/to_mechanic/mechanic_services/cart_summary/view_selected_mechanic_services.dart';
import 'package:customer_app/screens/to_mechanic/mechanic_services/components/circle_painter.dart';
import 'package:customer_app/screens/to_mechanic/mechanic_services/routine_maintenance/mechanic_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class RoutineMaintenanceServices extends StatelessWidget {
  static String routeName = '/RoutineMaintenanceServices';
  const RoutineMaintenanceServices({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer3<CustomerCarProvider, MechanicServiceProvider,
        MechanicServicesCartProvider>(
      builder: (context, customerCarProvider, mechanicServiceProvider,
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
                          "Routine Maintenance Services",
                          style: TextStyle(
                              fontSize: 25,
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
                                  customerCarProvider.selectedCar ??
                                      "Select One Of Your Cars",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                              value: customerCarProvider.selectedCar,
                              onChanged: (String newValue) {
                                customerCarProvider.setSelectedItem(newValue);
                              },
                              items: customerCarProvider.items
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
                        MechanicService(),
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
                      "Subtotal : ${mechanicServicesCartProvider.subTotal} EGP",
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
                if (customerCarProvider.selectedCar != null &&
                    mechanicServicesCartProvider.cartCounter > 0) {
                  Navigator.of(context)
                      .pushNamed(ViewSelectedMechanicServices.routeName);
                } else {
                  if (customerCarProvider.selectedCar == null)
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
