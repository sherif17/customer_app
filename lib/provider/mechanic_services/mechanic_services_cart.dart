import 'package:customer_app/models/mechanic_services/load_break_down_model.dart';
import 'package:flutter/cupertino.dart';

class MechanicServicesCartProvider extends ChangeNotifier {
  List<LoadBreakDownModel> _breakDownSelectedList = [];
  double _totalPrice = 0.0;
  double _subTotal = 0.0;
  double _visitFare = 0.0;

  addToBreakDownCart(LoadBreakDownModel loadBreakDownModel) {
    if (_breakDownSelectedList.contains(loadBreakDownModel) == false) {
      _breakDownSelectedList.add(loadBreakDownModel);
      if (_breakDownSelectedList.length == 1) _visitFare = 50.0;
      print(
          "${loadBreakDownModel.subproblem ?? loadBreakDownModel.problem} added successfully");
    } else
      print(
          "${loadBreakDownModel.subproblem ?? loadBreakDownModel.problem}Item already added");
    notifyListeners();
  }

  removeFromBreakDownCart(LoadBreakDownModel loadBreakDownModel) {
    _breakDownSelectedList.remove(loadBreakDownModel);
    if (_breakDownSelectedList.length == 0) _visitFare = 0.0;
    print(
        "${loadBreakDownModel.subproblem ?? loadBreakDownModel.problem} removed");
    notifyListeners();
  }

  int get cartCounter {
    return _breakDownSelectedList.length;
  }

  double get finalFare {
    return _totalPrice = _subTotal + _visitFare;
  }

  double get visitFare => _visitFare;

  double get subTotal => _subTotal;

  List<LoadBreakDownModel> get breakDownListSelectedItems {
    return _breakDownSelectedList;
  }
}
