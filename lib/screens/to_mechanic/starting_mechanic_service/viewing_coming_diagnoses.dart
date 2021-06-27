import 'package:customer_app/local_db/customer_db/customer_info_db.dart';
import 'package:customer_app/provider/mechanic_request/mechnic_request_provider.dart';
import 'package:customer_app/widgets/divider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewingComingDiagnoses extends StatelessWidget {
  const ViewingComingDiagnoses({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScrollController controller = ScrollController();
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(
          0.85), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
      body: Consumer<MechanicRequestProvider>(
        builder: (context, mechanicRequestProvider, child) => Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.1),
              child: Container(
                height: size.height * 0.9,
                child: SingleChildScrollView(
                  controller: controller,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      buildIItemsNeeded(
                          context, size, mechanicRequestProvider, controller),
                      buildServicesNeeded(
                          context, size, mechanicRequestProvider, controller),
                      buildPaymentSummery(context, mechanicRequestProvider),
                    ],
                  ),
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
                        color: Colors.white.withOpacity(0.2),
                        blurRadius: 15.0,
                        offset: Offset(0.0, 0.75))
                  ],
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          child: Text("Reject".toUpperCase(),
                              style: TextStyle(fontSize: 18)),
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
                            mechanicRequestProvider.rejectUpComingDiagnosis();
                          }),
                      SizedBox(width: size.width * 0.0),
                      TextButton(
                        child: Text("Confirm".toUpperCase(),
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
                          mechanicRequestProvider.approveUpComingDiagnosis();
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

  buildPaymentSummery(
      BuildContext context, MechanicRequestProvider mechanicRequestProvider) {
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
                "Items SubTotal",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                "${mechanicRequestProvider.itemsSubTotal} EGP",
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
                "Services SubTotal",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                "${mechanicRequestProvider.servicesSubTotal} EGP",
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
                "50 EGP",
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
              Text("${mechanicRequestProvider.finalEstimatedFare} EGP")
            ],
          ),
        )
      ],
    );
  }

  buildIItemsNeeded(BuildContext context, Size size,
      MechanicRequestProvider mechanicRequestProvider, controller) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Items Needed",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          controller: controller,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount: mechanicRequestProvider.repairsToBeMadeList_Items.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Align(
                alignment: loadCurrentLangFromDB() == "en"
                    ? Alignment.topRight
                    : Alignment.topLeft,
                child: Text(
                  '${mechanicRequestProvider.repairsToBeMadeList_Items[index].repairitself.itemDesc}',
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
                    '${mechanicRequestProvider.repairsToBeMadeList_Items[index].repairitself.category}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  // mechanicServicesCartProvider.removeFromBreakDownCart(
                  //     mechanicServicesCartProvider
                  //         .breakDownListSelectedItems[index]);
                },
                child: Text(
                    '${mechanicRequestProvider.repairsToBeMadeList_Items[index].repairitself.price} EGP'),
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

  buildServicesNeeded(
      BuildContext context,
      Size size,
      MechanicRequestProvider mechanicRequestProvider,
      ScrollController controller) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Services To be done",
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
              mechanicRequestProvider.repairsToBeMadeList_Services.length,
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
                  '${mechanicRequestProvider.repairsToBeMadeList_Services[index].repairitself.serviceDesc}',
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
                    '${mechanicRequestProvider.repairsToBeMadeList_Services[index].repairitself.category}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              leading: GestureDetector(
                child: Text(
                    '${mechanicRequestProvider.repairsToBeMadeList_Services[index].repairitself.expectedFare} EGP'),
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
}
