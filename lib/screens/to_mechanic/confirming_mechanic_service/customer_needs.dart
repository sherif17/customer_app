import 'package:customer_app/local_db/customer_db/customer_info_db.dart';
import 'package:customer_app/provider/mechanic_services/mechanic_services_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerNeeds extends StatelessWidget {
  const CustomerNeeds({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScrollController controller = ScrollController();
    return Consumer<MechanicServicesCartProvider>(
      builder: (context, mechanicServicesCartProvider, child) =>
          SingleChildScrollView(
        controller: controller,
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            mechanicServicesCartProvider.breakDownListSelectedItems.length > 0
                ? buildCustomerProblems(
                    context, size, mechanicServicesCartProvider, controller)
                : Container(),
            mechanicServicesCartProvider.mechanicServicesSelectedList.length > 0
                ? buildServicesNeeded(
                    context, size, mechanicServicesCartProvider, controller)
                : Container(),
          ],
        ),
      ),
    );
  }

  buildCustomerProblems(
      BuildContext context,
      Size size,
      MechanicServicesCartProvider mechanicServicesCartProvider,
      ScrollController controller) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Selected Problems",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.7),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
            child: ListView.separated(
              shrinkWrap: true,
              controller: controller,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: mechanicServicesCartProvider
                  .breakDownListSelectedItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Align(
                    alignment: loadCurrentLangFromDB() == "en"
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: Text(
                      '${mechanicServicesCartProvider.breakDownListSelectedItems[index].subproblem ?? mechanicServicesCartProvider.breakDownListSelectedItems[index].problem}',
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
                        '${mechanicServicesCartProvider.breakDownListSelectedItems[index].problem}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                  // leading: GestureDetector(
                  //   onTap: () {
                  //     // mechanicServicesCartProvider.removeFromBreakDownCart(
                  //     //     mechanicServicesCartProvider
                  //     //         .breakDownListSelectedItems[index]);
                  //   },
                  //   child: Text(
                  //       '${mechanicServicesCartProvider.breakDownListSelectedItems[index].}'),
                  // ),
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
        ),
      ],
    );
  }

  buildServicesNeeded(
      BuildContext context,
      Size size,
      MechanicServicesCartProvider mechanicServicesCartProvider,
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.withOpacity(0.7),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                )),
            child: ListView.separated(
              shrinkWrap: true,
              controller: controller,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemCount: mechanicServicesCartProvider
                  .mechanicServicesSelectedList.length,
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
                      '${mechanicServicesCartProvider.mechanicServicesSelectedList[index].serviceDesc}',
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
                        '${mechanicServicesCartProvider.mechanicServicesSelectedList[index].category}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                  leading: GestureDetector(
                    child: Text(
                        '${mechanicServicesCartProvider.mechanicServicesSelectedList[index].expectedFare} EGP'),
                  ),
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
        ),
      ],
    );
  }
}
