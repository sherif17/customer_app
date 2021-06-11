import 'package:customer_app/local_db/customer_db/customer_info_db.dart';
import 'package:customer_app/provider/mechanic_services/mechanic_services_cart.dart';
import 'package:customer_app/provider/mechanic_services/mechanic_services_provider.dart';
import 'package:customer_app/screens/to_mechanic/mechanic_services/components/circle_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

class problems extends StatefulWidget {
  @override
  _problemsState createState() => _problemsState();
}

class _problemsState extends State<problems> {
  @override
  ScrollController controller = ScrollController();
  double topContainer = 0;
  String currentLang = loadCurrentLangFromDB();

  // List<Widget> itemsData = [];
  // final List<String> names = <String>[
  //   'Problem 1',
  //   'Problem 2',
  //   'Problem 3',
  //   'Problem 4',
  //   'Problem 5',
  //   'Problem 6',
  //   'Problem 7',
  //   'Problem 8',
  //   'Problem 9',
  //   'Problem 10',
  // ];
  // final List<String> msgCount = <String>[
  //   'limited: a',
  //   'limited: a',
  //   'limited: a',
  //   'limited: a',
  //   'limited: a',
  //   'limited: a',
  //   'limited: a',
  //   'limited: a',
  //   'limited: a',
  //   'limited: a',
  // ];
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.1;
    return Consumer2<MechanicServiceProvider, MechanicServicesCartProvider>(
      builder: (context, mechanicServiceProvider, mechanicServicesCartProvider,
              child) =>
          ListView.separated(
        shrinkWrap: true,
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: mechanicServiceProvider.breakDownApiList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              buildAddToCartBottomSheet(
                  context,
                  size,
                  index,
                  mechanicServiceProvider,
                  currentLang,
                  mechanicServicesCartProvider);
            },
            title: Align(
              alignment:
                  currentLang == "en" ? Alignment.topRight : Alignment.topLeft,
              child: Text(
                '${mechanicServiceProvider.breakDownApiList[index].problem}',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            subtitle: Align(
              alignment:
                  currentLang == "en" ? Alignment.topRight : Alignment.topLeft,
              child: Text(
                '${mechanicServiceProvider.breakDownApiList[index].subproblem}',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
              child: Divider(
                thickness: 1.5,
              ));
        },
      ),
    );
  }

  buildAddToCartBottomSheet(
      BuildContext context,
      Size size,
      index,
      MechanicServiceProvider mechanicServiceProvider,
      currentLang,
      MechanicServicesCartProvider mechanicServicesCartProvider) {
    return showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        height: size.height * 0.45,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(size.height * 0.01),
                    child: Icon(
                      Icons.cancel,
                      size: size.width * 0.1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
                )),
            Align(
              alignment:
                  currentLang == "en" ? Alignment.topRight : Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${mechanicServiceProvider.breakDownApiList[index].problem}",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Fare",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "To be determined later,after a quick check done by mechanic",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("Add To Selected Services",
                              style: TextStyle(
                                  color: Colors
                                      .white) //Theme.of(context).textTheme.headline2,
                              ),
                        ],
                      ),
                      //SizedBox(width: size.width*0.02),
                      Text(
                          "Visit Fare :${mechanicServicesCartProvider.visitFare} EGP",
                          style: TextStyle(color: Colors.white))
                    ],
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.redAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side:
                                  BorderSide(width: 1.5, color: Colors.red)))),
                  onPressed: () {
                    mechanicServicesCartProvider.addToBreakDownCart(
                        mechanicServiceProvider.breakDownApiList[index]);
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
