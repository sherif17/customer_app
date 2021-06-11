import 'package:customer_app/models/mechanic_services/load_break_down_model.dart';
import 'package:flutter/cupertino.dart';

class MechanicServicesCartProvider extends ChangeNotifier {
  List<LoadBreakDownModel> breakDownList = [];
  double totalPrice = 0.0;
  double visitFare = 50.0;

  addToBreakDownCart(LoadBreakDownModel loadBreakDownModel) {
    if (breakDownList.contains(loadBreakDownModel) == false) {
      breakDownList.add(loadBreakDownModel);
      if (breakDownList.length == 1)
        totalPrice += loadBreakDownModel.expectedFare.toDouble() + visitFare;
      else
        totalPrice += loadBreakDownModel.expectedFare.toDouble();
      print("added successfully");
    } else
      print("print Item already added");
    notifyListeners();
  }

  removeFromBreakList(LoadBreakDownModel loadBreakDownModel) {
    totalPrice -= loadBreakDownModel.expectedFare.toDouble();
    breakDownList.remove(loadBreakDownModel);
    notifyListeners();
  }

  int get cartCounter {
    return breakDownList.length;
  }

  double get finalFare {
    return totalPrice;
  }

  List<LoadBreakDownModel> get breakDownListSelectedItems {
    return breakDownList;
  }
}
