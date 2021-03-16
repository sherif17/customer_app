import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer_app/localization/localization_constants.dart';
import 'package:customer_app/screens/dash_board/home/componnets/cars_mangment/customer_car/car_model.dart';
import 'package:customer_app/screens/login_screens/otp/componants/progress_bar.dart';
import 'package:customer_app/services/car_services/car_services.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:customer_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customerCars extends StatefulWidget {
  customerCars();
  @override
  _customerCarsState createState() => _customerCarsState();
}

class _customerCarsState extends State<customerCars> {
  int _current = 0;
  int currentPage = 0;
  String url_1 =
      'https://i.pinimg.com/564x/e2/11/42/e2114295cfee2babeed1edf3e26c8d51.jpg';
  // String url_2 =
  //     'https://i.pinimg.com/564x/a7/df/a2/a7dfa2843fa35b09de01320dfac55c87.jpg';
  // String url_3 =
  //     'https://i.pinimg.com/564x/72/a1/88/72a188d519e791179897eb861f720c2a.jpg';
  // String url_4 =
  //     'https://i.pinimg.com/564x/a1/13/ea/a113ead0c8175ad02df43770ee97199a.jpg';
  List userCarList = [];
  String jwt;
  CarApiService api = new CarApiService();
  List<CarModel> carList = new List<CarModel>();
  bool isApiCallProcess = false;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    //print("start");
    return result;
  }

  initState() {
    super.initState();
    print("hi");
    getPrefJwtToken().then((value) {
      jwt = value;
      getUserCarList(jwt);
      print("jwt: $jwt");
    });
    // print(userCarList);
  }

  getUserCarList(token) async {
    userCarList = await api.loadUserCars(token);
    setState(() {
      for (var x in userCarList) {
        //print(x.id);
        carList.add(new CarModel(url_1, x.carBrand, x.model, x.plates));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("no");
    print(carList.toString());

    /* if (carList.isEmpty) {
      if (userCarList.isEmpty) // return buildNoAddedCarsContainer();
        return CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent));
      else
        return buildNoAddedCarsContainer();
    } else if (userCarList.isEmpty || carList.isEmpty) {
      return Text(" no"); //buildNoAddedCarsContainer();
    } else
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
              autoPlay: carList.length == 1 ? false : true,
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
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
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
                            borderRadius: BorderRadiusDirectional.all(
                                Radius.circular(10)),
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
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
      );*/
    return userCarList.isEmpty && carList.isEmpty
        ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent))
        : carList.isEmpty || userCarList.isEmpty
            ? buildNoAddedCarsContainer()
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(carList, (index, url) {
                      return AnimatedContainer(
                        width: _current == index ? 20 : 10,
                        height: 6.0,
                        duration: animationDuration,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(3),
                          color: _current == index
                              ? Colors.redAccent
                              : Colors.grey,
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
                      autoPlay: carList.length == 1 ? false : true,
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
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05),
                            child: Stack(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  // margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                                  decoration: new BoxDecoration(
                                    image: new DecorationImage(
                                      image: i.carImage == null
                                          ? AssetImage(
                                              "assets/images/women_truck.jpg")
                                          : new NetworkImage(i.carImage),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadiusDirectional.all(
                                        Radius.circular(10)),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: size.height * 0.5,
                                    // margin: EdgeInsets.symmetric(horizontal: 5.0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              i.carPlate,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.normal),
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
                                                SizedBox(
                                                    width: size.width * 0.01),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      carList.remove(i);
                                                    });
                                                    print(carList.length);
                                                  },
                                                  child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5),
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

  buildNoAddedCarsContainer() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.2,
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
        // margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        decoration: new BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.add_circle_outline_rounded,
              size: 60,
            ),
            Text(getTranslated(context, "No Added Cars"),
                style: TextStyle(fontSize: 25, color: Colors.grey)),
            Text(
              getTranslated(context,
                  "Please add at least one ,to be able to use our services"),
              style: TextStyle(fontSize: 13),
            ),
          ],
        ));
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
