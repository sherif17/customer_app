import 'dart:async';
import 'package:customer_app/models/maps/winch_request/request_status_model.dart';
import 'package:customer_app/models/maps/winch_request/winch_request_model.dart';
import 'package:customer_app/services/maps_services/winch_services/winch_request_services.dart';
import 'package:flutter/foundation.dart';

class WinchRequestProvider with ChangeNotifier {
  WinchResponseModel winchResponseModel = WinchResponseModel();
  RequestStatusResponseModel requestStatusResponseModel =
      RequestStatusResponseModel();
  WinchRequestApi api = new WinchRequestApi();

  bool isLoading = false;
  bool STATUS_TERMINATED = false;
  bool STATUS_SEARCHING = false;
  bool STATUS_ACCEPTED = false;
  bool STATUS_COMPLETED = false;
  bool STATUS_HAVE_ACTIVE_RIDE = false;

  confirmWinchService(winchRequestModel, token) async {
    isLoading = true;
    winchResponseModel = await api.findWinchDriver(winchRequestModel, token);
    isLoading = false;
    if (winchResponseModel.status == "SEARCHING") STATUS_SEARCHING = true;
    if (winchResponseModel.status == "COMPLETED") STATUS_COMPLETED = true;
    notifyListeners();
  }

  checkConfirmedWinchServiceStatus(token) async {
    isLoading = true;
    requestStatusResponseModel = await api.checkRequestStatus(token);
    isLoading = false;
    if (requestStatusResponseModel.status == "TERMINATED") {
      STATUS_TERMINATED = true;
      STATUS_SEARCHING = false;
      notifyListeners();
    }
    if (requestStatusResponseModel.status == "ACCEPTED") {
      STATUS_ACCEPTED = true;
      STATUS_SEARCHING = false;
      notifyListeners();
    }
    if (requestStatusResponseModel.status == "SEARCHING") {
      STATUS_SEARCHING = true;
      requestStatusResponseModel.error ==
              "This customer has already an active ride."
          ? STATUS_HAVE_ACTIVE_RIDE = true
          : print(requestStatusResponseModel.error);
      notifyListeners();
    }
    notifyListeners();
  }
}
