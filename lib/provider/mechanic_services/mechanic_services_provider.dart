import 'package:customer_app/local_db/mechanic_services_db/break_down_model.dart';
import 'package:customer_app/services/mechanic_services/mechanic_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class MechanicServiceProvider extends ChangeNotifier {
  List breakDownApiList = [];
  // Box<BreakDownDB> breakDownDB = Hive.box<BreakDownDB>("BreakDownDB");
  MechanicApiServices mechanicApiServices = new MechanicApiServices();
  bool loading;
  getBreakDownListFromBackend() async {
    loading = true;
    breakDownApiList = await mechanicApiServices.loadBreakDownData();
    loading = false;
    breakDownApiList.forEach((element) {
      print(element);
    });
  }
}
