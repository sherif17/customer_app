import 'package:customer_app/local_db/customer_db/customer_info_db.dart';
import 'package:customer_app/models/mechanic_services/load_break_down_model.dart';
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
  @override
  void initState() {
    super.initState();
    final mechanicServiceProviderObj =
        Provider.of<MechanicServiceProvider>(context, listen: false);
    //mechanicServiceProviderObj.getServicesByProblems();
  }

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.1;
    return Consumer2<MechanicServiceProvider, MechanicServicesCartProvider>(
      builder: (context, mechanicServiceProvider, mechanicServicesCartProvider,
          child) {
        return ListView.separated(
          shrinkWrap: true,
          controller: controller,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount: mechanicServiceProvider
              .convertedListOfCategoryValues[
                  mechanicServiceProvider.selectedIndex]
              .keys
              .length,
          itemBuilder: (BuildContext context, int index) {
            //print(mechanicServiceProvider.onItemTapList.length);
            return ListTile(
              onTap: () {
                print(
                    "Number of subProblems ${mechanicServiceProvider.convertedListOfCategoryValues[mechanicServiceProvider.selectedIndex].values.elementAt(index).length}");
                buildAddToCartBottomSheet(
                    context,
                    size,
                    index,
                    mechanicServiceProvider,
                    currentLang,
                    mechanicServicesCartProvider,
                    mechanicServiceProvider.convertedListOfCategoryValues);
              },
              title: Align(
                alignment: currentLang == "en"
                    ? Alignment.topRight
                    : Alignment.topLeft,
                child: Text(
                  //'${mechanicServiceProvider.onItemTapList[mechanicServiceProvider.selectedIndex][index].problem}',
                  '${mechanicServiceProvider.convertedListOfCategoryValues[mechanicServiceProvider.selectedIndex].keys.toList()[index]}',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              subtitle: Align(
                alignment: currentLang == "en"
                    ? Alignment.topRight
                    : Alignment.topLeft,
                child: Text(
                  //'${breakDownValuesList[index].values.map((e) => e.elementAt(index).category)}',
                  // '${mechanicServiceProvider.onItemTapList[mechanicServiceProvider.selectedIndex][index].subproblem}',
                  '${mechanicServiceProvider.convertedListOfCategoryValues[mechanicServiceProvider.selectedIndex].values.elementAt(index)[0].subproblem}',
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
        );
      },
    );
  }

  buildAddToCartBottomSheet(
      BuildContext context,
      Size size,
      index,
      MechanicServiceProvider mechanicServiceProvider,
      currentLang,
      MechanicServicesCartProvider mechanicServicesCartProvider,
      List<Map<dynamic, List<LoadBreakDownModel>>>
          convertedListOfCategoryValues) {
    return showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        int index_2 = 0;
        return Container(
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
          child: mechanicServiceProvider
                      .convertedListOfCategoryValues[
                          mechanicServiceProvider.selectedIndex]
                      .values
                      .elementAt(index)[index_2]
                      .subproblem !=
                  null
              ? Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.width * 0.05),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.02),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            )),
                        child: ListView.separated(
                          shrinkWrap: true,
                          controller: controller,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemCount: mechanicServiceProvider
                              .convertedListOfCategoryValues[
                                  mechanicServiceProvider.selectedIndex]
                              .values
                              .elementAt(index)
                              .length,
                          itemBuilder: (BuildContext context, index_2) {
                            //print(mechanicServiceProvider.onItemTapList.length);
                            return ListTile(
                              trailing: Checkbox(value: true),
                              onTap: () {},
                              title: Align(
                                alignment: currentLang == "en"
                                    ? Alignment.topRight
                                    : Alignment.topLeft,
                                child: Text(
                                  //'${mechanicServiceProvider.onItemTapList[mechanicServiceProvider.selectedIndex][index].problem}',
                                  '${mechanicServiceProvider.convertedListOfCategoryValues[mechanicServiceProvider.selectedIndex].values.elementAt(index)[index_2].subproblem}',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.02),
                                child: Divider(
                                  thickness: 1.5,
                                ));
                          },
                        ),
                      ),
                    )
                  ],
                )
              : Column(
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
                      alignment: currentLang == "en"
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          // "${breakDownValuesList[index].values.map((e) => e.elementAt(index).subproblem)}",
                          '${convertedListOfCategoryValues[mechanicServiceProvider.selectedIndex].values.elementAt(index)[index_2].problem}',
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
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.redAccent),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          width: 1.5, color: Colors.red)))),
                          onPressed: () {
                            mechanicServicesCartProvider.addToBreakDownCart(
                                mechanicServiceProvider
                                    .breakDownApiList[index]);
                            Navigator.pop(context);
                          }),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
