import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer_app/screens/dash_board/home/componnets/car_model.dart';
import 'package:customer_app/screens/dash_board/home/componnets/new_car_selection.dart';
import 'package:customer_app/screens/to_winch/to_winch_map.dart';
import 'package:customer_app/screens/to_winch/winch_map.dart';
import 'package:customer_app/utils/constants.dart';
import 'package:customer_app/utils/customer_app_icons_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:im_stepper/stepper.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

/* @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      carList.map((i) {
        precacheImage(NetworkImage(i.carImage), context);
      });
    });
    super.initState();
  }
*/
class _HomeBodyState extends State<HomeBody> {
  int _currentstep = 0;
  // new stepper
  int activeStep = 0;
  int upperBound = 5;
  int x = 1;
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
            addNewCar(context, size),
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
          child: buildServices(
              size, context, "assets/icons/tow-truck.svg", "Winch", 0),
        ),
        buildServices(
            size, context, "assets/icons/mechanic (1).svg", "Mechanic", 1),
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
  Padding addNewCar(BuildContext context, Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Text("Your Cars", style: Theme.of(context).textTheme.headline2),
          GestureDetector(
            onTap: () {
              buildStepperShowModalBottomSheet(
                  context, size, this.activeStep, this.upperBound);
            },
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.add, color: Colors.redAccent),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  Text(
                    'Add New',
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

class customerCars extends StatefulWidget {
  @override
  _customerCarsState createState() => _customerCarsState();
}

class _customerCarsState extends State<customerCars> {
  int _current = 0;
  //int currentPage = 0;
  String url_1 =
      'https://i.pinimg.com/564x/e2/11/42/e2114295cfee2babeed1edf3e26c8d51.jpg';
  String url_2 =
      'https://i.pinimg.com/564x/a7/df/a2/a7dfa2843fa35b09de01320dfac55c87.jpg';
  String url_3 =
      'https://i.pinimg.com/564x/72/a1/88/72a188d519e791179897eb861f720c2a.jpg';
  String url_4 =
      'https://i.pinimg.com/564x/a1/13/ea/a113ead0c8175ad02df43770ee97199a.jpg';

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    List<CarModel> carList = new List<CarModel>();
    Size size = MediaQuery.of(context).size;
    carList.add(new CarModel(url_1, "kia", "rio", "س ص ع  1234"));
    carList.add(new CarModel(url_2, "BWM", "X6", "س ق ط  5674"));
    carList.add(new CarModel(url_3, "Audi", "A3", "ص ف ي  7921"));
    carList.add(new CarModel(url_2, "Seat", "Leon", "ص ف ي  7921"));
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(carList, (index, url) {
            return AnimatedContainer(
              width: _current == index ? 20 : 10,
              height: 6.0,
              duration: animationDuration,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(3),
                color: _current == index ? Colors.redAccent : Colors.grey,
              ),
            );
          }),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: size.height * 0.2,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 7),
            autoPlayAnimationDuration: Duration(milliseconds: 1200),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            onPageChanged: (index, a) {
              setState(() {
                _current = index;
              });
            },
          ),
          items: carList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        // margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: i.carImage == null
                                ? AssetImage("assets/images/women_truck.jpg")
                                : new NetworkImage(i.carImage),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              BorderRadiusDirectional.all(Radius.circular(10)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: size.height * 0.5,
                          // margin: EdgeInsets.symmetric(horizontal: 5.0),
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: new BoxDecoration(
                            gradient: new LinearGradient(
                              end: Alignment.topCenter,
                              begin: Alignment.bottomCenter,
                              colors: <Color>[
                                const Color(0xFFBD4242),
                                Colors.black12.withOpacity(0.2)
                              ],
                            ),
                            borderRadius: BorderRadiusDirectional.all(
                                Radius.circular(10)),
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                i.carBrand + "-" + i.carModel,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              //SizedBox(height: size.height * 0.01),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    i.carPlate,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(width: size.width * 0.42),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.01),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            carList.remove(i);
                                          });
                                          print(carList.length);
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Icon(Icons.delete,
                                                color: Colors.white)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  AnimatedContainer DotSweeper({int index}) {
    return AnimatedContainer(
      duration: animationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: _current == index ? 20 : 6,
      decoration: BoxDecoration(
          color:
              _current == index ? Theme.of(context).primaryColor : Colors.grey,
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
