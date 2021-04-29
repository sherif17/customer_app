import 'dart:async';

import 'package:customer_app/local_db/customer_info_db.dart';
import 'package:customer_app/models/winch_request/cancel_winch_service_model.dart';
import 'package:customer_app/models/winch_request/check_request_status_model.dart';
import 'package:customer_app/models/winch_request/confirm_winch_service_model.dart';
import 'package:customer_app/models/winch_request/rate_winch_driver_model.dart';
import 'package:customer_app/services/winch_services/winch_request_services.dart';

import 'package:flutter/foundation.dart';

class WinchRequestProvider with ChangeNotifier {
  ConfirmWinchServiceResponseModel confirmWinchServiceResponseModel = ConfirmWinchServiceResponseModel();
  CheckRequestStatusResponseModel checkRequestStatusResponseModel =
      CheckRequestStatusResponseModel();
  RatingForWinchDriverResponseModel ratingForWinchDriverResponseModel =
      RatingForWinchDriverResponseModel();
  CancellingWinchServiceResponseModel cancellingWinchServiceResponseModel =
      CancellingWinchServiceResponseModel();

  WinchRequestApi api = new WinchRequestApi();

  bool isLoading = false;
  bool STATUS_TERMINATED = false;
  bool STATUS_SEARCHING = false;
  bool STATUS_ACCEPTED = false;
  bool STATUS_COMPLETED = false;
  bool STATUS_HAVE_ACTIVE_RIDE = false;

  confirmWinchService(winchRequestModel, token) async {
    isLoading = true;
    confirmWinchServiceResponseModel = await api.findWinchDriver(winchRequestModel, token);
    isLoading = false;
    if (confirmWinchServiceResponseModel.status == "SEARCHING") STATUS_SEARCHING = true;
    if (confirmWinchServiceResponseModel.status == "COMPLETED") STATUS_COMPLETED = true;
    notifyListeners();
  }

  checkStatusForConfirmedWinchService(token) async {
    isLoading = true;
    checkRequestStatusResponseModel = await api.checkRequestStatus(token);
    isLoading = false;
    if (checkRequestStatusResponseModel.status == "TERMINATED") {
      STATUS_TERMINATED = true;
      STATUS_SEARCHING = false;
      notifyListeners();
    }
    if (checkRequestStatusResponseModel.status == "ACCEPTED") {
      STATUS_ACCEPTED = true;
      STATUS_SEARCHING = false;
      notifyListeners();
    }
    if (checkRequestStatusResponseModel.status == "SEARCHING") {
      STATUS_SEARCHING = true;
      checkRequestStatusResponseModel.error ==
              "This customer has already an active ride."
          ? STATUS_HAVE_ACTIVE_RIDE = true
          : print(checkRequestStatusResponseModel.error);
      notifyListeners();
    }
    notifyListeners();
  }

  rateWinchDriver(ratingForWinchDriverRequestModel) async {
    isLoading = true;
    ratingForWinchDriverResponseModel = await api.rateWinchDriver(
        ratingForWinchDriverRequestModel, loadJwtTokenFromDB());
    isLoading = false;
    notifyListeners();
  }

  cancelWinchDriverRequest() async {
    isLoading = true;
    cancellingWinchServiceResponseModel =
        await api.cancelWinchRequest(loadJwtTokenFromDB());
    isLoading = false;
    notifyListeners();
  }
}
