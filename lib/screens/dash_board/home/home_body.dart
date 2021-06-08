import 'dart:ui';
import 'package:customer_app/local_db/customer_db/customer_info_db.dart';
import 'package:customer_app/localization/localization_constants.dart';
import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/screens/dash_board/home/componnets/cars_mangment/add_new_car/add_new_car_stepper.dart';
import 'package:customer_app/screens/dash_board/home/componnets/cars_mangment/customer_car/customer_cars.dart';
import 'package:customer_app/screens/to_mechanic/mechanic_services/choosing_mechanic_services.dart';
import 'package:customer_app/screens/winch_service/winch_map.dart';
import 'package:customer_app/services/car_services/car_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  //int _currentstep = 0;
  // new stepper
  int activeStep = 0;
  int upperBound = 5;
  int x = 1;
  CarApiService api = new CarApiService();
  String currentLang = loadCurrentLangFromDB();
  @override
  void initState() {
    super.initState();
    Provider.of<CustomerCarProvider>(context, listen: false)
        .getCustomerCarsFromBackend(loadJwtTokenFromDB());
    // print(
    //     "car id: ${Provider.of<CustomerCarProvider>(context, listen: false).customerOwnedCars.getAt(0).key}");
    print("jwt token: ${loadJwtTokenFromDB()}");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            //choosingServices(),
            SizedBox(height: size.height * 0.01),
            choosingBetweenServices(context, size),
            SizedBox(height: size.height * 0.02),
            //addNewCar(context),
            addNewCar(context, size, currentLang),
            SizedBox(height: size.height * 0.001),
            customerCars(),
          ],
        ),
      ),
    );
  }

  Row choosingBetweenServices(BuildContext context, Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              WinchMap.routeName,
            );
          },
          child: buildServices(size, context, "assets/icons/tow-truck.svg",
              getTranslated(context, "Winch"), 0),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              ChoosingMechanicServices.routeName,
            );
          },
          child: buildServices(size, context, "assets/icons/mechanic (1).svg",
              getTranslated(context, "Mechanic"), 1),
        ),
      ],
    );
  }

  Stack buildServices(Size size, BuildContext context, img, text, x) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(7),
          height: size.height * 0.28,
          width: size.width * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Theme.of(context).primaryColorLight),
        ),
        Positioned(
          top: size.height * 0.01,
          left: size.width * 0.02,
          child: Container(
            margin: EdgeInsets.all(20),
            height: size.height * 0.15,
            width: size.width * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Theme.of(context).primaryColorDark),
          ),
        ),
        Positioned(
          top: x == 1 ? size.height * 0.05 : size.height * 0.05,
          left: x == 1 ? size.width * 0.05 : size.height * 0.045,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                x == 1 ? img : img,
                height: size.height * 0.12,
                // color: Colors.white,
              ),
              SizedBox(
                height: x == 1 ? size.height * 0.04 : size.height * 0.04,
              ),
              Text(
                x == 1 ? text : text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900),
              )
            ],
          ),
        ),
      ],
    );
  }

/*
  Stack buildServices(Size size, BuildContext context, img, text, x) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(20),
          height: size.height * 0.2,
          width: size.width * 0.3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Theme.of(context).primaryColorLight),
        ),
        Positioned(
          top: size.height * 0.015,
          left: size.width * 0.026,
          child: Container(
            margin: EdgeInsets.all(20),
            height: size.height * 0.1,
            width: size.width * 0.25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Theme.of(context).primaryColorDark),
          ),
        ),
        Positioned(
          top: x == 1 ? size.height * 0.05 : size.height * 0.045,
          left: x == 1 ? size.width * 0.085 : size.height * 0.065,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                x == 1 ? img : img,
                height: size.height * 0.08,
                // color: Colors.white,
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              Text(
                x == 1 ? text : text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              )
            ],
          ),
        ),
      ],
    );
  }
*/
  Map<String, List<dynamic>> response = {};
  Padding addNewCar(BuildContext context, Size size, currentLang) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(getTranslated(context, "Your Cars"),
              style: Theme.of(context).textTheme.headline2),
          GestureDetector(
            onTap: () async {
              var list = await api.loadCarsData();
              for (var j in list) {
                if (response.containsKey(j.carBrand)) {
                  response
                      .putIfAbsent(j.carBrand, () => null)
                      .add([j.carBrand, j.model, j.startYear, j.endYear]);
                } else
                  response.addAll({
                    j.carBrand: [j.carBrand, j.model, j.startYear, j.endYear]
                  });
              }
              buildStepperShowModalBottomSheet(context, size, this.activeStep,
                  this.upperBound, list, response, currentLang);
              print(currentLang);
              response.forEach((key, value) {
                print('$key: ${value}');
              });
              print("end");
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.add, color: Colors.redAccent),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  Text(
                    getTranslated(context, "Add New"),
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

Widget choosingServices() {
  return Padding(
    padding: const EdgeInsets.only(top: 20.0, left: 15.0),
    child: Padding(
      padding: EdgeInsets.only(right: 10),
      child: Container(
        width: 400.0,
        height: 210.0,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            color: Colors.red.withOpacity(0.8),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 20.0,
                right: 15.0,
              ),
              child: Text(
                "Services We offer",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 40.0,
                            ),
                          ),
                          Text(
                            "Winch",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 32.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 180.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(),
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 30.0,
                            ),
                          ),
                          Text(
                            "mechanic &\nrepair service",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 17.0,
                            ),
                          ),
                        ],
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
  );
}
