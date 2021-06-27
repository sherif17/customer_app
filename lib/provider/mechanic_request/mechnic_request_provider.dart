import 'package:customer_app/local_db/customer_db/customer_info_db.dart';
import 'package:customer_app/models/mechanic_request/cancel_mechanic_service_model.dart';
import 'package:customer_app/models/mechanic_request/confirm_mechanic_service_model.dart';
import 'package:customer_app/models/mechanic_request/customer_resoponse_about_services_to_be_made_model.dart';
import 'package:customer_app/models/mechanic_request/repaires_assigned_by_mechanic_model.dart';
import 'package:customer_app/screens/dash_board/profile/profile_body.dart';
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

  RepairsAssignedByMechanicResponseModel
      repairsAssignedByMechanicResponseModel =
      RepairsAssignedByMechanicResponseModel();

  CustomerResponseAboutServicesToBeDoneRequestModel
      customerResponseAboutServicesToBeDoneRequestModelAccept =
      CustomerResponseAboutServicesToBeDoneRequestModel(
          customerResponse: "Approve");

  CustomerResponseAboutServicesToBeDoneRequestModel
      customerResponseAboutServicesToBeDoneRequestModelReject =
      CustomerResponseAboutServicesToBeDoneRequestModel(
          customerResponse: "Refuse");
  CustomerResponseAboutServicesToBeDoneResponseModel
      customerResponseAboutServicesToBeDoneResponseModel =
      CustomerResponseAboutServicesToBeDoneResponseModel();

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

  List<RepairsToBeMade> repairsToBeMadeList = [
    RepairsToBeMade(
        repairkind: "item",
        repairitself: Repairitself(
            category: "سينسور",
            itemDesc: "سينسور اكسوجين Nissan Sunny",
            price: 1200),
        repairNumber: "2"),
    RepairsToBeMade(
        repairkind: "service",
        repairitself: Repairitself(
            category: " تغير سينسور",
            expectedFare: 250,
            serviceDesc: "تغير سينسور الاكسوجين"),
        repairNumber: "1"),
  ];
  List<RepairsToBeMade> repairsToBeMadeList_Items = [];
  List<RepairsToBeMade> repairsToBeMadeList_Services = [];

  double _itemsSubTotal = 0.0;
  double _servicesSubTotal = 0.0;
  double _finalEstimatedFare = 0.0;

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

  loadDiagnoses() async {
    isLoading = true;
    // repairsAssignedByMechanicResponseModel = await mechanicApiRequest
    //     .getServicesToBeDoneByMechanic(loadJwtTokenFromDB());
    for (var j in repairsToBeMadeList) {
      if (j.repairkind == "item") {
        repairsToBeMadeList_Items.add(j);
        _itemsSubTotal += j.repairitself.price;
      }
      if (j.repairkind == "service") {
        repairsToBeMadeList_Services.add(j);
        _servicesSubTotal += j.repairitself.expectedFare;
      }
    }
    isLoading = false;
    //print(repairsAssignedByMechanicResponseModel.repairsToBeMade);
  }

  approveUpComingDiagnosis() async {
    isLoading = true;
    customerResponseAboutServicesToBeDoneResponseModel =
        await mechanicApiRequest.respondToConfirmedRepairsFromMechanic(
            customerResponseAboutServicesToBeDoneRequestModelAccept,
            loadJwtTokenFromDB());
    isLoading = false;
  }

  rejectUpComingDiagnosis() async {
    isLoading = true;
    customerResponseAboutServicesToBeDoneResponseModel =
        await mechanicApiRequest.respondToConfirmedRepairsFromMechanic(
            customerResponseAboutServicesToBeDoneRequestModelReject,
            loadJwtTokenFromDB());
    isLoading = false;
  }

  double get servicesSubTotal => _servicesSubTotal;

  double get finalEstimatedFare {
    return _finalEstimatedFare = _servicesSubTotal + _itemsSubTotal + 50;
  }

  double get itemsSubTotal => _itemsSubTotal;
}
