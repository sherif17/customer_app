import 'dart:ui';

import 'package:customer_app/provider/mechanic_services/mechanic_services_provider.dart';
import 'package:customer_app/screens/to_mechanic/mechanic_services/break_down/break_down_services.dart';
import 'package:customer_app/screens/to_mechanic/mechanic_services/routine_maintenance/routine_maintenance_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../local_db/customer_db/cutomer_owned_cars_model.dart';
import '../../../../provider/customer_cars/customer_car_provider.dart';
import '../../../dash_board/chatbot/chat.dart';

class ChoosingMechanicServicesBody extends StatelessWidget {
  const ChoosingMechanicServicesBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final mechanicServiceProviderObj =
        Provider.of<MechanicServiceProvider>(context, listen: false);
    //mechanicServiceProviderObj.getBreakDownListFromBackend();
    // mechanicServiceProviderObj.getBreakDownByCategory();
    mechanicServiceProviderObj.getItems();
    mechanicServiceProviderObj.getBreakDownByCategory();
    ScrollController controller = ScrollController();
    return Consumer<CustomerCarProvider>(
      builder: (context, CustomerCarProvider, child) => SafeArea(
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.05,
                    horizontal: size.width * 0.02),
                child: Text(
                  'Services',
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              decoration: new BoxDecoration(
                color: Colors.redAccent,
                image: new DecorationImage(
                    alignment: Alignment.topCenter,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.4), BlendMode.dstATop),
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
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.015),
                          child: Container(
                            height: 5,
                            width: size.width * 0.5,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text(
                              "Select One Of Your Cars",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 20),
                            ),
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
                                      fontWeight: FontWeight.w600),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          children: <Widget>[
                            BuildServicesTypeContainer(
                                imgSrc: "assets/illustrations/breaking.svg",
                                index: 1,
                                title: "Break downs"),
                            BuildServicesTypeContainer(
                              imgSrc: "assets/illustrations/car-service.svg",
                              index: 2,
                              title: "Maintenance",
                            ),
                            BuildServicesTypeContainer(
                              imgSrc: "assets/illustrations/lifebuoy.svg",
                              index: 3,
                              title: "Need Help",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Popular services",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            )),
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: 10,
                          // physics: AlwaysScrollableScrollPhysics(),
                          controller: controller,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                'popular service ${index + 1}',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.05),
                                child: Divider(
                                  thickness: 1.5,
                                ));
                          },
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class BuildServicesTypeContainer extends StatelessWidget {
  String imgSrc;
  int index;
  String title;
  BuildServicesTypeContainer({Key key, this.imgSrc, this.index, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          index == 1
              ? Navigator.pushNamed(context, BreakDownServices.routeName)
              : index == 2
                  ? Navigator.pushNamed(
                      context, RoutineMaintenanceServices.routeName)
                  : Navigator.pushNamed(context, ChatBot.routeName);
        },
        child: PhysicalModel(
            color: Colors.white,
            elevation: 3,
            shadowColor: Colors.grey,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(imgSrc, height: index == 1 ? 100 : 85),
                  Text(title)
                ],
              ),
            )),
      ),
    );
  }
}
