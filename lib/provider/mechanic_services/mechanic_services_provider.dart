import 'package:customer_app/local_db/mechanic_services_db/break_down_model.dart';
import 'package:customer_app/services/mechanic_services/mechanic_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MechanicServiceProvider extends ChangeNotifier {
  List breakDownApiList = [];
  // Box<BreakDownDB> breakDownDB = Hive.box<BreakDownDB>("BreakDownDB");
  MechanicApiServices mechanicApiServices = new MechanicApiServices();
  bool loading;

  int selectedIndex = 0;
  SwiperController scrollController = new SwiperController();
  TabController tabController;

  getCurrentIndex(index) {
    selectedIndex = index;
    print("current swiped index ${index + 1}");
    notifyListeners();
  }

  getCurrentTab(index) {
    scrollController.move(index);
    print("current Tabbed index ${index + 1}");
    notifyListeners();
  }

  getBreakDownListFromBackend() async {
    loading = true;
    breakDownApiList = await mechanicApiServices.loadBreakDownData();
    loading = false;
    breakDownApiList.forEach((element) {
      print(element);
    });
  }
}
