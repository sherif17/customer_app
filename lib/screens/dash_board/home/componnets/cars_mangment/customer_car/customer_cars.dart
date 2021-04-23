import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer_app/local_db/customer_info_db.dart';
import 'package:customer_app/local_db/customer_info_db_model.dart';
import 'package:customer_app/local_db/cutomer_owned_cars_model.dart';
import 'package:customer_app/localization/localization_constants.dart';
import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/services/car_services/car_services.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:customer_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class customerCars extends StatefulWidget {
  customerCars();
  @override
  _customerCarsState createState() => _customerCarsState();
}

class _customerCarsState extends State<customerCars> {
  int currentPage = 0;
  String url_1 =
      'https://i.pinimg.com/564x/e2/11/42/e2114295cfee2babeed1edf3e26c8d51.jpg';

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  initState() {
    super.initState();
    print("hi");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final postMdl = Provider.of<CustomerCarProvider>(context);
    print("no");
    return postMdl.loading
        ? CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent))
        : postMdl.customerOwnedCars.isEmpty
            ? buildNoAddedCarsContainer()
            : Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          map<Widget>(postMdl.customerOwnedCars.values.toList(),
                              (index, url) {
                        return AnimatedContainer(
                          width: postMdl.currentIndex == index ? 20 : 10,
                          height: 6.0,
                          duration: animationDuration,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(3),
                            color: postMdl.currentIndex == index
                                ? Colors.redAccent
                                : Colors.grey,
                          ),
                        );
                      }),
                    ),
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: size.height * 0.2,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay:
                          postMdl.customerOwnedCars.length == 1 ? false : true,
                      autoPlayInterval: Duration(seconds: 7),
                      autoPlayAnimationDuration: Duration(milliseconds: 1200),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      onPageChanged: (index, a) {
                        Provider.of<CustomerCarProvider>(context, listen: false)
                            .getCurrentIndex(index);
                      },
                    ),
                    items: postMdl.customerOwnedCars.values.map((i) {
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
                                      image: new NetworkImage(url_1),
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
                                          i.CarBrand + "-" + i.Model,
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
                                          textBaseline: TextBaseline.alphabetic,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              i.Plates,
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
                                                    postMdl.deleteCustomerCars(
                                                        i.id);
                                                    print(postMdl
                                                        .customerOwnedCars
                                                        .length);
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
}
