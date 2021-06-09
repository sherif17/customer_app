import 'dart:async';
import 'package:customer_app/local_db/customer_db/customer_info_db.dart';
import 'package:customer_app/models/maps/address.dart';
import 'package:customer_app/models/winch_request/cancel_winch_service_model.dart';
import 'package:customer_app/models/winch_request/check_request_status_model.dart';
import 'package:customer_app/models/winch_request/confirm_winch_service_model.dart';
import 'package:customer_app/models/winch_request/rate_winch_driver_model.dart';
import 'package:customer_app/services/winch_services/winch_request_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

import '../customer_cars/customer_car_provider.dart';
import '../maps_preparation/mapsProvider.dart';
import '../maps_preparation/polyLineProvider.dart';

class WinchRequestProvider with ChangeNotifier {
  ConfirmWinchServiceRequestModel confirmWinchServiceRequestModel;
  ConfirmWinchServiceResponseModel confirmWinchServiceResponseModel =
      ConfirmWinchServiceResponseModel();
  CheckRequestStatusResponseModel checkRequestStatusResponseModel =
      CheckRequestStatusResponseModel();
  RatingForWinchDriverResponseModel ratingForWinchDriverResponseModel =
      RatingForWinchDriverResponseModel();
  CancellingWinchServiceResponseModel cancellingWinchServiceResponseModel =
      CancellingWinchServiceResponseModel();

  WinchRequestApi api = new WinchRequestApi();

  Timer trackWinchDriverTimer;

  Address winchLocation = Address();

  bool isLoading = false;
  bool STATUS_TERMINATED = false;
  bool STATUS_SEARCHING = false;
  bool STATUS_ACCEPTED = false;
  bool STATUS_COMPLETED = false;
  bool STATUS_HAVE_ACTIVE_RIDE = false;
  bool CANCELING_ADDED_FINE = false;
  bool CANCLING_RIDE = false;
  bool STATUS_ARRIVED = false;
  bool STATUS_STARTED = false;

  confirmWinchService(context) async {
    confirmWinchServiceRequestModel.carId =
        Provider.of<CustomerCarProvider>(context, listen: false).selectedItem;
    print(confirmWinchServiceRequestModel.toJson());
    isLoading = true;
    confirmWinchServiceResponseModel = await api.findWinchDriver(
        confirmWinchServiceRequestModel, loadJwtTokenFromDB());
    isLoading = false;
    if (confirmWinchServiceResponseModel.status == "SEARCHING"
        /*confirmWinchServiceResponseModel.requestId == null*/) {
      STATUS_SEARCHING = true;
      // Provider.of<PolyLineProvider>(context, listen: false).resetPolyLine();
    }
    if (confirmWinchServiceResponseModel.status == "COMPLETED") {
      STATUS_COMPLETED = true;
    }
    if (confirmWinchServiceResponseModel.status == "SEARCHING" &&
        confirmWinchServiceResponseModel.requestId != null)
      STATUS_HAVE_ACTIVE_RIDE = true;
    notifyListeners();
  }

  checkStatusForConfirmedWinchService(context) async {
    isLoading = true;
    checkRequestStatusResponseModel =
        await api.checkRequestStatus(loadJwtTokenFromDB());
    isLoading = false;
    if (checkRequestStatusResponseModel.status == "SEARCHING") {
      STATUS_SEARCHING = true;
      STATUS_TERMINATED = false;
      checkRequestStatusResponseModel.error ==
              "This customer has already an active ride."
          ? STATUS_HAVE_ACTIVE_RIDE = true
          : print(checkRequestStatusResponseModel.error);
    }

    if (checkRequestStatusResponseModel.status == "ACCEPTED") {
      STATUS_ACCEPTED = true;
      STATUS_SEARCHING = false;
      winchLocation.latitude =
          double.parse(checkRequestStatusResponseModel.driverLocationLat);
      winchLocation.longitude =
          double.parse(checkRequestStatusResponseModel.driverLocationLong);
      winchLocation.placeName = "Winch driver current Location";
      print(
          "timePassedSinceRequestAcceptance: ${checkRequestStatusResponseModel.timePassedSinceRequestAcceptance}");
    }
    if (checkRequestStatusResponseModel.status == "ARRIVED") {
      STATUS_SEARCHING = false;
      STATUS_ARRIVED = true;
      STATUS_TERMINATED = false;
      print(
          "timePassedSinceDriverArrival: ${checkRequestStatusResponseModel.timePassedSinceDriverArrival}");
    }
    if (checkRequestStatusResponseModel.status == "Service STARTED") {
      STATUS_STARTED = true;
      Provider.of<PolyLineProvider>(context, listen: false).resetPolyLine();
      print(
          "timePassedSinceServiceStart:${checkRequestStatusResponseModel.timePassedSinceServiceStart}");
      Provider.of<PolyLineProvider>(context, listen: false).getPlaceDirection(
          context: context,
          initialPosition:
              Provider.of<MapsProvider>(context, listen: false).pickUpLocation,
          finalPosition:
              Provider.of<MapsProvider>(context, listen: false).dropOffLocation,
          googleMapController: Provider.of<MapsProvider>(context, listen: false)
              .googleMapController);
    }

    if (checkRequestStatusResponseModel.status == "TERMINATED") {
      STATUS_TERMINATED = true;
      STATUS_SEARCHING = false;
    }
    notifyListeners();
  }

  trackWinchDriver(context) async {
    if (STATUS_ACCEPTED == true) {
      trackWinchDriverTimer =
          Timer.periodic(Duration(seconds: 5), (timer) async {
        print("Driver Tracking........");
        await checkStatusForConfirmedWinchService(context);
        if (STATUS_ACCEPTED == true ||
            STATUS_ARRIVED == true ||
            STATUS_STARTED == true) {
          winchLocation.latitude =
              double.parse(checkRequestStatusResponseModel.driverLocationLat);
          winchLocation.longitude =
              double.parse(checkRequestStatusResponseModel.driverLocationLong);
          winchLocation.placeName = "Winch driver current Location";

          print(
              "Driver Current Location Lat : ${checkRequestStatusResponseModel.driverLocationLat}");
          print(
              "Driver Current Location long : ${checkRequestStatusResponseModel.driverLocationLong}");
        } else
          print("Status now : ${checkRequestStatusResponseModel.status}");
        notifyListeners();
      });
    } else
      print("your request didn't accepted yet");
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
    if (STATUS_ACCEPTED == true) trackWinchDriverTimer.cancel();
    if (cancellingWinchServiceResponseModel.status == "CANCELLED") {
      print("Driver live location tracking timer cancelled");
      CANCLING_RIDE = true;
      if (cancellingWinchServiceResponseModel.details != null)
        CANCELING_ADDED_FINE = false;
      else
        CANCELING_ADDED_FINE = true;
    }
    notifyListeners();
  }

  resetAllFlags() {
    isLoading = false;
    STATUS_TERMINATED = false;
    STATUS_SEARCHING = false;
    STATUS_ACCEPTED = false;
    STATUS_COMPLETED = false;
    STATUS_HAVE_ACTIVE_RIDE = false;
    CANCELING_ADDED_FINE = false;
    CANCLING_RIDE = false;
    notifyListeners();
  }

  void updateWinchLocationAddress(Address winchPosition) {
    winchLocation = winchPosition;
    notifyListeners();
  }
}
