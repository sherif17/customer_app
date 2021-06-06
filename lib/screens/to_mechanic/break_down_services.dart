import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../local_db/customer_db/cutomer_owned_cars_model.dart';
import '../../provider/customer_cars/customer_car_provider.dart';
import '../../provider/customer_cars/customer_car_provider.dart';
import 'helpme.dart';
import 'problems.dart';

class BreakDownServices extends StatefulWidget {
  static String routeName = '/BreakDownServices';
  @override
  _BreakDownServicesState createState() => _BreakDownServicesState();
}

class _BreakDownServicesState extends State<BreakDownServices>
    with SingleTickerProviderStateMixin {
  List list_name = ["Exterior", "Interior", "Engine", "Chasis", "Help me"];

  SwiperController _scrollController = new SwiperController();

  TabController tabController;
  List<Widget> itemsData = [];

  int currentindex2 = 0; // for swiper index initial

  int selectedIndex = 0; // for tab

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      initialIndex: selectedIndex,
      length: list_name.length,
      vsync: this,
    );

    tabController.addListener(() {
      setState(() {
        print(tabController.index);
        _scrollController.move(tabController.index);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.15;
    return Scaffold(
        body: Consumer<CustomerCarProvider>(
      builder: (context, CustomerCarProvider, child) => Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.05, horizontal: size.width * 0.02),
              child: Text(
                "what's wrong with your car ?",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            decoration: new BoxDecoration(
              color: Colors.redAccent,
              image: new DecorationImage(
                  alignment: Alignment.topCenter,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.dstATop),
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
                            CustomerCarProvider.selectedItem ??
                                "Select One Of Your Cars",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 20)),
                        value: CustomerCarProvider.selectedItem,
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
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
// @override
// Widget build(BuildContext context) {
//   final Size size = MediaQuery.of(context).size;
//   final double categoryHeight = size.height * 0.15;
//   return DefaultTabController(
//     length: list_name.length,
//     child: Scaffold(
//       body: Container(
//         child: Column(
//           children: [
//             Expanded(
//               flex: 3,
//               child: Container(
//                 height: categoryHeight,
//                 child: Column(
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: <Widget>[
//                         Padding(
//                           padding: EdgeInsets.only(
//                               left: size.width * 0.1, top: size.height * 0.1),
//                           child: Text(
//                             "What is the wrong with you car ?",
//                             style:
//                             TextStyle(color: Colors.blue, fontSize: 20),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     TextFormField(
//                       keyboardType: TextInputType.text,
//                       style: TextStyle(fontSize: 20, color: Colors.blue),
//                       decoration: InputDecoration(
//                           hintText: "Enter Car-Type Model",
//                           hintStyle:
//                           TextStyle(fontSize: 20.0, color: Colors.blue)),
//                     ),
//                     Container(
//                         padding: EdgeInsets.only(
//                           top: size.height * 0.02,
//                         ),
//                         height: categoryHeight,
//                         child: DefaultTabController(
//                           length: list_name.length,
//                           child: Container(
//                             width: 510,
//                             height: 300,
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Colors.blue,
//                                 width: 4,
//                               ),
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.blue,
//                                   offset: const Offset(
//                                     5.0,
//                                     5.0,
//                                   ), //Offset
//                                   blurRadius: 10.0,
//                                   spreadRadius: 2.0,
//                                 ), //BoxShadow
//                                 BoxShadow(
//                                   color: Colors.white,
//                                   offset: const Offset(0.0, 0.0),
//                                   blurRadius: 0.0,
//                                   spreadRadius: 0.0,
//                                 ), //BoxShadow
//                               ],
//                             ),
//                             constraints: BoxConstraints(maxHeight: 35.0),
//                             child: Material(
//                               child: TabBar(
//                                 onTap: (index) =>
//                                     _scrollController.move(index),
//                                 controller: tabController,
//                                 isScrollable: true,
//                                 indicatorColor:
//                                 Color.fromRGBO(0, 202, 157, 1),
//                                 labelColor: Colors.black,
//                                 labelStyle: TextStyle(fontSize: 17),
//                                 unselectedLabelColor: Colors.black,
//                                 tabs: List<Widget>.generate(list_name.length,
//                                         (int index) {
//                                       return new Tab(text: list_name[index]);
//                                     }),
//                               ),
//                             ),
//                           ),
//                         )),
//                     SizedBox(
//                       height: categoryHeight,
//                     ),
//                     Expanded(
//                       child: new Swiper(
//                         onIndexChanged: (index) {
//                           setState(() {
//                             selectedIndex = index;
//                             tabController.animateTo(index);
//                             currentindex2 = index;
//                             print(index);
//                           });
//                         },
//                         onTap: (index) {
//                           setState(() {
//                             selectedIndex = index;
//                             tabController.animateTo(index);
//                             currentindex2 = index;
//                             print(index);
//                           });
//                         },
//                         duration: 2,
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder: (BuildContext context, int index) {
//                           return new Swiper(
//                             duration: 2,
//                             controller: _scrollController,
//                             scrollDirection: Axis.vertical,
//                             itemBuilder: (BuildContext context, int index) {
//                               return VisibilityDetector(
//                                 key: Key(index.toString()),
//                                 child: Container(
//                                   child: selectedIndex == 4
//                                       ? helpme()
//                                       : problems(),
//                                 ),
//                                 onVisibilityChanged: (VisibilityInfo info) {
//                                   if (info.visibleFraction == 1)
//                                     setState(() {
//                                       selectedIndex = index;
//                                       tabController.animateTo(index);
//                                       currentindex2 = index;
//                                       print(index);
//                                     });
//                                 },
//                               );
//                             },
//                             itemCount: list_name.length,
//                           );
//                         },
//                         itemCount: list_name.length,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
// }
