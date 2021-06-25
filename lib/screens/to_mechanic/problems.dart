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
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    //'${mechanicServiceProvider.onItemTapList[mechanicServiceProvider.selectedIndex][index].problem}',
                    '${mechanicServiceProvider.convertedListOfCategoryValues[mechanicServiceProvider.selectedIndex].keys.toList()[index]}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              subtitle: Align(
                alignment: currentLang == "en"
                    ? Alignment.topRight
                    : Alignment.topLeft,
                child: Text(
                  mechanicServiceProvider
                          .convertedListOfCategoryValues[
                              mechanicServiceProvider.selectedIndex]
                          .values
                          .elementAt(index)
                          .every((element) => element.subproblem != null)
                      ? 'يحتوي علي عدد ${mechanicServiceProvider.convertedListOfCategoryValues[mechanicServiceProvider.selectedIndex].values.elementAt(index).length} مشاكل فرعيه '
                      : mechanicServiceProvider
                                  .convertedListOfCategoryValues[
                                      mechanicServiceProvider.selectedIndex]
                                  .values
                                  .elementAt(index)
                                  .where(
                                      (element) => element.subproblem != null)
                                  .length >
                              0
                          ? 'يحتوي علي عدد ${mechanicServiceProvider.convertedListOfCategoryValues[mechanicServiceProvider.selectedIndex].values.elementAt(index).where((element) => element.subproblem != null).length} مشاكل فرعيه '
                          : "لا يحتوي علي مشاكل فرعيه",
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
      problemIndex,
      MechanicServiceProvider mechanicServiceProvider,
      currentLang,
      MechanicServicesCartProvider mechanicServicesCartProvider,
      List<Map<dynamic, List<LoadBreakDownModel>>>
          convertedListOfCategoryValues) {
    return showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        int subProblemIndex = 0;
        return StatefulBuilder(builder: (BuildContext context,
            StateSetter setState /*You can rename this!*/) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height:
                    mechanicServiceProvider.checkIfProblemHaveSubProblemOrNot(
                                problemIndex: problemIndex) ==
                            true
                        ? size.height * 0.9
                        : size.height * 0.45,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child:
                    mechanicServiceProvider.checkIfProblemHaveSubProblemOrNot(
                                problemIndex: problemIndex) ==
                            true
                        ? buildHaveSubProblemsContainer(
                            context,
                            convertedListOfCategoryValues,
                            mechanicServiceProvider,
                            problemIndex,
                            subProblemIndex,
                            currentLang,
                            setState,
                            size)
                        : buildDHaveNoSubProblemsContainer(
                            context,
                            size,
                            currentLang,
                            convertedListOfCategoryValues,
                            mechanicServiceProvider,
                            problemIndex,
                            subProblemIndex,
                            mechanicServicesCartProvider),
              ),
              mechanicServiceProvider.checkIfProblemHaveSubProblemOrNot(
                          problemIndex: problemIndex) ==
                      true
                  ? Container(
                      width: size.width,
                      height: size.height * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 15.0,
                              offset: Offset(0.1, 0.0))
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextButton(
                            child: Text("Add to selected breakdowns",
                                style: TextStyle(fontSize: 20)),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(15)),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blueGrey),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Colors.green),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                    )
                  : Container(),
            ],
          );
        });
      },
    );
  }

  Column buildDHaveNoSubProblemsContainer(
      BuildContext context,
      Size size,
      currentLang,
      List<Map<dynamic, List<LoadBreakDownModel>>>
          convertedListOfCategoryValues,
      MechanicServiceProvider mechanicServiceProvider,
      problemIndex,
      int subProblemIndex,
      MechanicServicesCartProvider mechanicServicesCartProvider) {
    return Column(
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
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(
                '${convertedListOfCategoryValues[mechanicServiceProvider.selectedIndex].values.elementAt(problemIndex)[problemIndex].problem}',
                style: Theme.of(context).textTheme.headline3,
              ),
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
              "To be determined later,after a quick check done by mechanic\n",
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  // Text(
                  //     "Visit Fare :${mechanicServicesCartProvider.visitFare} EGP",
                  //     style: TextStyle(color: Colors.white))
                ],
              ),
              style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueGrey),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueGrey),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(width: 1.5, color: Colors.white)))),
              onPressed: () {
                mechanicServicesCartProvider.addToBreakDownCart(
                    convertedListOfCategoryValues[
                            mechanicServiceProvider.selectedIndex]
                        .values
                        .elementAt(problemIndex)[problemIndex]);
                Navigator.pop(context);
              }),
        ),
      ],
    );
  }

  Container buildHaveSubProblemsContainer(
      BuildContext context,
      List<Map<dynamic, List<LoadBreakDownModel>>>
          convertedListOfCategoryValues,
      MechanicServiceProvider mechanicServiceProvider,
      problemIndex,
      int subProblemIndex,
      currentLang,
      StateSetter setState,
      Size size) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //     height: MediaQuery.of(context).size.width * 0.05),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_drop_down_circle_rounded,
                        size: 45,
                        color: Colors.grey.withOpacity(0.4),
                      ))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                      convertedListOfCategoryValues[
                              mechanicServiceProvider.selectedIndex]
                          .values
                          .elementAt(problemIndex)[subProblemIndex]
                          .problem,
                      style: Theme.of(context).textTheme.headline2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                      " برجاء اختيار المشكلات التي تواجهك مع ${convertedListOfCategoryValues[mechanicServiceProvider.selectedIndex].values.elementAt(problemIndex)[subProblemIndex].problem}",
                      style: Theme.of(context).textTheme.subtitle2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.7),
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  controller: controller,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemCount: mechanicServiceProvider
                      .convertedListOfCategoryValues[
                          mechanicServiceProvider.selectedIndex]
                      .values
                      .elementAt(problemIndex)
                      .length,
                  itemBuilder: (BuildContext context, subProblemIndex) {
                    //print(mechanicServiceProvider.onItemTapList.length);
                    return CheckboxListTile(
                      value:
                          mechanicServiceProvider.getSubProblemSelectionState(
                              problemIndex: problemIndex,
                              subProblemIndex: subProblemIndex),
                      checkColor: Colors.white,
                      activeColor: Colors.blueGrey,
                      selectedTileColor: Colors.greenAccent,
                      title: Align(
                        alignment: currentLang == "en"
                            ? Alignment.topRight
                            : Alignment.topLeft,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            //'${mechanicServiceProvider.onItemTapList[mechanicServiceProvider.selectedIndex][index].problem}',
                            '${mechanicServiceProvider.convertedListOfCategoryValues[mechanicServiceProvider.selectedIndex].values.elementAt(problemIndex)[subProblemIndex].subproblem ?? "لا اعرف - سيتم اختيار المشكله بوجه عام-"}',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ),
                      onChanged: (bool val) {
                        mechanicServiceProvider
                            .onChangeSubProblemSelectionState(
                                val: val,
                                problemIndex: problemIndex,
                                subProblemIndex: subProblemIndex,
                                context: context);
                        setState(() {});
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.02),
                        child: Divider(
                          thickness: 1.5,
                        ));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
