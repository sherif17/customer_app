import 'package:customer_app/models/mechanic_request/confirm_mechanic_service_model.dart';
import 'package:customer_app/models/mechanic_services/load_break_down_model.dart';
import 'package:customer_app/models/mechanic_services/load_routine_maintanence_model.dart';
import 'package:flutter/cupertino.dart';

class MechanicServicesCartProvider extends ChangeNotifier {
  List<LoadBreakDownModel> _breakDownSelectedList = [];
  List<LoadRoutineMaintenanceModel> _mechanicServicesSelectedList = [];
  List<IntialDiagnosis> combinedCart = [];
  double _totalPrice = 0.0;
  double _subTotal = 0.0;
  double _visitFare = 0.0;

  addToBreakDownCart(LoadBreakDownModel loadBreakDownModel) {
    if (_breakDownSelectedList.contains(loadBreakDownModel) == false) {
      _breakDownSelectedList.add(loadBreakDownModel);
      print(
          "${loadBreakDownModel.subproblem ?? loadBreakDownModel.problem} added successfully");
    } else
      print(
          "${loadBreakDownModel.subproblem ?? loadBreakDownModel.problem}Item already added");
    notifyListeners();
  }

  removeFromBreakDownCart(LoadBreakDownModel loadBreakDownModel) {
    _breakDownSelectedList.remove(loadBreakDownModel);
    print(
        "${loadBreakDownModel.subproblem ?? loadBreakDownModel.problem} removed");
    notifyListeners();
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  addToMechanicServicesCart(
      LoadRoutineMaintenanceModel loadMechanicServicesResponseModel) {
    if (_mechanicServicesSelectedList
            .contains(loadMechanicServicesResponseModel) ==
        false) {
      _mechanicServicesSelectedList.add(loadMechanicServicesResponseModel);
      _subTotal += loadMechanicServicesResponseModel.expectedFare;
      print(
          "${loadMechanicServicesResponseModel.serviceDesc ?? loadMechanicServicesResponseModel.category} added successfully");
    } else
      print(
          "${loadMechanicServicesResponseModel.serviceDesc ?? loadMechanicServicesResponseModel.category}Item already added");
    notifyListeners();
  }

  removeFromMechanicServicesCart(
      LoadRoutineMaintenanceModel loadMechanicServicesResponseModel) {
    _mechanicServicesSelectedList.remove(loadMechanicServicesResponseModel);
    _subTotal -= loadMechanicServicesResponseModel.expectedFare;
    print(
        "${loadMechanicServicesResponseModel.serviceDesc ?? loadMechanicServicesResponseModel.category} removed");
    notifyListeners();
  }

  int get cartCounter {
    if (_breakDownSelectedList.length + _mechanicServicesSelectedList.length ==
        1) _visitFare = 50.0;
    if (_breakDownSelectedList.length + _mechanicServicesSelectedList.length ==
        0) _visitFare = 00.0;
    return _breakDownSelectedList.length + _mechanicServicesSelectedList.length;
  }

  double get finalFare {
    return _totalPrice = _subTotal + _visitFare;
  }

  double get visitFare => _visitFare;

  double get subTotal => _subTotal;

  List<LoadBreakDownModel> get breakDownListSelectedItems {
    return _breakDownSelectedList;
  }

  List<LoadRoutineMaintenanceModel> get mechanicServicesSelectedList {
    return _mechanicServicesSelectedList;
  }

  combineTwoCartsWithEachOther() {
    for (var j in _breakDownSelectedList) {
      combinedCart.add(IntialDiagnosis(id: j.id, category: "problem"));
      j.isChecked=false;
    }
    for (var j in _mechanicServicesSelectedList) {
      combinedCart.add(IntialDiagnosis(id: j.id, category: "service"));
      j.isChecked=false;
    }
    return combinedCart;
  }
}
