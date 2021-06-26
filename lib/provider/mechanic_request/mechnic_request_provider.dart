import 'package:customer_app/local_db/customer_db/customer_info_db.dart';
import 'package:customer_app/models/mechanic_request/cancel_mechanic_service_model.dart';
import 'package:customer_app/models/mechanic_request/confirm_mechanic_service_model.dart';
import 'package:customer_app/services/mechanic_services/mechanic_request.dart';
import 'package:flutter/cupertino.dart';

class MechanicRequestProvider extends ChangeNotifier {
  bool isConfirmingMechanicMapReady = false;

  MechanicApiRequest mechanicApiRequest = new MechanicApiRequest();
  ConfirmMechanicServiceRequestModel confirmMechanicServiceRequestModel =
      ConfirmMechanicServiceRequestModel();
  ConfirmMechanicServiceResponseModel confirmMechanicServiceResponseModel =
      ConfirmMechanicServiceResponseModel();
  CancellingMechanicServiceResponseModel
      cancellingMechanicServiceResponseModel =
      CancellingMechanicServiceResponseModel();

  bool isLoading = false;
  bool MECHANIC_STATUS_TERMINATED = false;
  bool MECHANIC_STATUS_SEARCHING = false;
  bool MECHANIC_STATUS_ACCEPTED = false;
  bool MECHANIC_STATUS_COMPLETED = false;
  bool MECHANIC_STATUS_HAVE_ACTIVE_RIDE = false;
  bool MECHANIC_CANCELING_ADDED_FINE = false;
  bool MECHANIC_CANCLING_RIDE = false;
  bool MECHANIC_STATUS_ARRIVED = false;
  bool MECHANIC_STATUS_STARTED = false;

  confirmMechanicRequest() async {
    isLoading = true;
    confirmMechanicServiceResponseModel =
        await mechanicApiRequest.findAMechanic(
            confirmMechanicServiceRequestModel, loadJwtTokenFromDB());
    isLoading = false;
    print(confirmMechanicServiceResponseModel.status);
    if (confirmMechanicServiceResponseModel.status == "SEARCHING" &&
        confirmMechanicServiceResponseModel.error == null) {
      MECHANIC_STATUS_SEARCHING = true;
    }
    if (confirmMechanicServiceResponseModel.status == "COMPLETED") {
      MECHANIC_STATUS_COMPLETED = true;
    }
    if (confirmMechanicServiceResponseModel.status == "SEARCHING" &&
        confirmMechanicServiceResponseModel.requestId != null)
      MECHANIC_STATUS_HAVE_ACTIVE_RIDE = true;
    print(MECHANIC_STATUS_SEARCHING);

    notifyListeners();
  }

  cancelMechanicRequest() async {
    isLoading = true;
    cancellingMechanicServiceResponseModel =
        await mechanicApiRequest.cancelMechanicRequest(loadJwtTokenFromDB());
    isLoading = false;
    print("${cancellingMechanicServiceResponseModel.details}");
    MECHANIC_STATUS_SEARCHING = false;
    notifyListeners();
  }
}
