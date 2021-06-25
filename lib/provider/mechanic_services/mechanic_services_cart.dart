import 'package:customer_app/models/mechanic_services/load_break_down_model.dart';
import 'package:flutter/cupertino.dart';

class MechanicServicesCartProvider extends ChangeNotifier {
  List<LoadBreakDownModel> breakDownSelectedList = [];
  double totalPrice = 0.0;
  double subTotal = 0.0;
  double visitFare = 0.0;

  addToBreakDownCart(LoadBreakDownModel loadBreakDownModel) {
    if (breakDownSelectedList.contains(loadBreakDownModel) == false) {
      breakDownSelectedList.add(loadBreakDownModel);
      if (breakDownSelectedList.length == 1) visitFare = 50.0;
      print(
          "${loadBreakDownModel.subproblem ?? loadBreakDownModel.problem} added successfully");
    } else
      print(
          "${loadBreakDownModel.subproblem ?? loadBreakDownModel.problem}Item already added");
    notifyListeners();
  }

  removeFromBreakDownCart(LoadBreakDownModel loadBreakDownModel) {
    breakDownSelectedList.remove(loadBreakDownModel);
    if (breakDownSelectedList.length == 0) visitFare = 0.0;
    print(
        "${loadBreakDownModel.subproblem ?? loadBreakDownModel.problem} removed");
    notifyListeners();
  }

  int get cartCounter {
    return breakDownSelectedList.length;
  }

  double get finalFare {
    return totalPrice = subTotal + visitFare;
  }

  List<LoadBreakDownModel> get breakDownListSelectedItems {
    return breakDownSelectedList;
  }
}
