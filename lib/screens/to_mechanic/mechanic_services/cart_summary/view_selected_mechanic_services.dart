import 'package:customer_app/local_db/customer_db/customer_info_db.dart';
import 'package:customer_app/local_db/customer_db/cutomer_owned_cars_model.dart';
import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/provider/mechanic_services/mechanic_services_cart.dart';
import 'package:customer_app/provider/mechanic_services/mechanic_services_provider.dart';
import 'package:customer_app/screens/dash_board/dash_board.dart';
import 'package:customer_app/screens/to_mechanic/confirming_mechanic_service/confirming_mechanic_service_map.dart';
import 'package:customer_app/widgets/divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ViewSelectedMechanicServices extends StatelessWidget {
  static String routeName = '/ViewSelectedMechanicServices';
  const ViewSelectedMechanicServices({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScrollController controller = ScrollController();
    final carProviderObj = Provider.of<CustomerCarProvider>(context);
    Box<customerOwnedCarsDB> selectedCar = carProviderObj.customerOwnedCars;
    String selectedCarInfo =
        selectedCar.get(carProviderObj.selectedCar).CarBrand +
            " " +
            selectedCar.get(carProviderObj.selectedCar).Model +
            " - " +
            selectedCar.get(carProviderObj.selectedCar).Year;
    return Consumer2<MechanicServiceProvider, MechanicServicesCartProvider>(
      builder: (context, mechanicServiceProvider, mechanicServicesCartProvider,
              child) =>
          Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: [
              Text(
                "Selected Services",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                selectedCarInfo,
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
          ),
          elevation: 0,
          backwardsCompatibility: true,
        ),
        body: Stack(
          children: [
            Container(
              height: size.height * 0.75,
              child: SingleChildScrollView(
                controller: controller,
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    buildBreakDownSummery(context, size,
                        mechanicServicesCartProvider, controller),
                    buildRoutineMaintenanceSummary(context, size,
                        mechanicServicesCartProvider, controller),
                    buildPaymentSummery(context, mechanicServicesCartProvider),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 15.0,
                        offset: Offset(0.0, 0.75))
                  ],
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          child: Text("Add More Services".toUpperCase(),
                              style: TextStyle(fontSize: 17)),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(15)),
                              foregroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          width: 0.7, color: Colors.red)))),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      SizedBox(width: size.width * 0.0),
                      TextButton(
                        child: Text("let's Confirm".toUpperCase(),
                            style: TextStyle(fontSize: 18)),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.all(15)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: Colors.green)))),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              ConfirmingMechanicServiceMap.routeName,
                              (route) => false);
                        },
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildRoutineMaintenanceSummary(BuildContext context, Size size,
      MechanicServicesCartProvider mechanicServicesCartProvider, controller) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Routine Maintenance",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          controller: controller,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount:
              mechanicServicesCartProvider.breakDownListSelectedItems.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              // onTap: () {
              //   buildAddToCartBottomSheet(
              //       context,
              //       size,
              //       index,
              //       mechanicServiceProvider,
              //       currentLang,
              //       mechanicServicesCartProvider);
              // },
              title: Align(
                alignment: loadCurrentLangFromDB() == "en"
                    ? Alignment.topRight
                    : Alignment.topLeft,
                child: Text(
                  '${mechanicServicesCartProvider.breakDownListSelectedItems[index].problem}',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              subtitle: Align(
                alignment: loadCurrentLangFromDB() == "en"
                    ? Alignment.topRight
                    : Alignment.topLeft,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    '${mechanicServicesCartProvider.breakDownListSelectedItems[index].subproblem}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  mechanicServicesCartProvider.removeFromBreakDownCart(
                      mechanicServicesCartProvider
                          .breakDownListSelectedItems[index]);
                },
                child: Icon(
                  Icons.remove_circle_outline_rounded,
                  color: Colors.redAccent,
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
      ],
    );
  }

  Column buildBreakDownSummery(BuildContext context, Size size,
      MechanicServicesCartProvider mechanicServicesCartProvider, controller) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "BreakDowns",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          controller: controller,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount:
              mechanicServicesCartProvider.breakDownListSelectedItems.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              // onTap: () {
              //   buildAddToCartBottomSheet(
              //       context,
              //       size,
              //       index,
              //       mechanicServiceProvider,
              //       currentLang,
              //       mechanicServicesCartProvider);
              // },
              title: Align(
                alignment: loadCurrentLangFromDB() == "en"
                    ? Alignment.topRight
                    : Alignment.topLeft,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    '${mechanicServicesCartProvider.breakDownListSelectedItems[index].subproblem ?? "لم يتم تحديد مشكله فرعيه"}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
              subtitle: Align(
                alignment: loadCurrentLangFromDB() == "en"
                    ? Alignment.topRight
                    : Alignment.topLeft,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    '${mechanicServicesCartProvider.breakDownListSelectedItems[index].problem}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  mechanicServicesCartProvider.removeFromBreakDownCart(
                      mechanicServicesCartProvider
                          .breakDownListSelectedItems[index]);
                },
                child: Icon(
                  Icons.remove_circle_outline_rounded,
                  color: Colors.redAccent,
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
      ],
    );
  }

  Column buildPaymentSummery(BuildContext context,
      MechanicServicesCartProvider mechanicServicesCartProvider) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Payment Summary",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sub Total",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                "${mechanicServicesCartProvider.subTotal} EGP",
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Visit Fare",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                "${mechanicServicesCartProvider.visitFare} EGP",
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DividerWidget(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Estimated Fare"),
              Text("${mechanicServicesCartProvider.finalFare} EGP")
            ],
          ),
        )
      ],
    );
  }
}
