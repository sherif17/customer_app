import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'helpme.dart';
import 'problems.dart';

class tabs extends StatefulWidget {

  @override
  _tabsState createState() => _tabsState();
}

class _tabsState extends State<tabs> with SingleTickerProviderStateMixin {
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
    return DefaultTabController(
      length: list_name.length,
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: categoryHeight,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.1, top: size.height * 0.1),
                            child: Text(
                              "What is the wrong with you car ?",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 20, color: Colors.blue),
                        decoration: InputDecoration(
                            hintText: "Enter Car-Type Model",
                            hintStyle:
                                TextStyle(fontSize: 20.0, color: Colors.blue)),
                      ),
                      Container(
                          padding: EdgeInsets.only(
                            top: size.height * 0.02,
                          ),
                          height: categoryHeight,
                          child: DefaultTabController(
                            length: list_name.length,
                            child: Container(
                              width: 510,
                              height: 300,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 4,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue,
                                    offset: const Offset(
                                      5.0,
                                      5.0,
                                    ), //Offset
                                    blurRadius: 10.0,
                                    spreadRadius: 2.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                ],
                              ),
                              constraints: BoxConstraints(maxHeight: 35.0),
                              child: Material(
                                child: TabBar(
                                  onTap: (index) =>
                                      _scrollController.move(index),
                                  controller: tabController,
                                  isScrollable: true,
                                  indicatorColor:
                                      Color.fromRGBO(0, 202, 157, 1),
                                  labelColor: Colors.black,
                                  labelStyle: TextStyle(fontSize: 17),
                                  unselectedLabelColor: Colors.black,
                                  tabs: List<Widget>.generate(list_name.length,
                                      (int index) {
                                    return new Tab(text: list_name[index]);
                                  }),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: categoryHeight,
                      ),
                      Expanded(
                        child: new Swiper(
                          onIndexChanged: (index) {
                            setState(() {
                              selectedIndex = index;
                              tabController.animateTo(index);
                              currentindex2 = index;
                              print(index);
                            });
                          },
                          onTap: (index) {
                            setState(() {
                              selectedIndex = index;
                              tabController.animateTo(index);
                              currentindex2 = index;
                              print(index);
                            });
                          },
                          duration: 2,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return new Swiper(
                              duration: 2,
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                return VisibilityDetector(
                                  key: Key(index.toString()),
                                  child: Container(
                                    child: selectedIndex == 4
                                        ? helpme()
                                        : problems(),
                                  ),
                                  onVisibilityChanged: (VisibilityInfo info) {
                                    if (info.visibleFraction == 1)
                                      setState(() {
                                        selectedIndex = index;
                                        tabController.animateTo(index);
                                        currentindex2 = index;
                                        print(index);
                                      });
                                  },
                                );
                              },
                              itemCount: list_name.length,
                            );
                          },
                          itemCount: list_name.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
