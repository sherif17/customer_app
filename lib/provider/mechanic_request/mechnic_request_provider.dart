import 'dart:async';

import 'package:customer_app/local_db/customer_db/customer_info_db.dart';
import 'package:customer_app/models/maps/address.dart';
import 'package:customer_app/models/mechanic_request/cancel_mechanic_service_model.dart';
import 'package:customer_app/models/mechanic_request/check_mechanic_status_model.dart';
import 'package:customer_app/models/mechanic_request/confirm_mechanic_service_model.dart';
import 'package:customer_app/models/mechanic_request/customer_resoponse_about_services_to_be_made_model.dart';
import 'package:customer_app/models/mechanic_request/rate_mechanic_model.dart';
import 'package:customer_app/models/mechanic_request/repaires_assigned_by_mechanic_model.dart';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/provider/maps_preparation/polyLineProvider.dart';
import 'package:customer_app/screens/dash_board/dash_board.dart';
import 'package:customer_app/screens/dash_board/profile/profile_body.dart';
import 'package:customer_app/screens/to_mechanic/acceptted_mechanic_service/acceppted_mechanic_service_map.dart';
import 'package:customer_app/screens/to_mechanic/starting_mechanic_service/car_checking.dart';
import 'package:customer_app/screens/to_mechanic/starting_mechanic_service/starting_mechanic_service.dart';
import 'package:customer_app/screens/to_mechanic/starting_mechanic_service/viewing_coming_diagnoses.dart';
import 'package:customer_app/services/mechanic_services/mechanic_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class MechanicRequestProvider extends ChangeNotifier {
  bool isConfirmingMechanicMapReady = false;

  MechanicApiRequest mechanicApiRequest = new MechanicApiRequest();

  ConfirmMechanicServiceRequestModel confirmMechanicServiceRequestModel =
      ConfirmMechanicServiceRequestModel();
  ConfirmMechanicServiceResponseModel confirmMechanicServiceResponseModel =
      ConfirmMechanicServiceResponseModel();
  CheckMechanicRequestStatusResponseModel
      checkMechanicRequestStatusResponseModel =
      CheckMechanicRequestStatusResponseModel();

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

  RatingForMechanicServiceRequestModel ratingForMechanicServiceRequestModel =
      RatingForMechanicServiceRequestModel();

  RatingForMechanicServiceResponseModel ratingForMechanicServiceResponseModel =
      RatingForMechanicServiceResponseModel();

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
  bool WAITING_FOR_APPROVAL = false;
  bool CUSTOMER_RESPONSE = false;
  bool DIAGNOSIS_ARRIVED = false;
  Timer waitingForEndingMechanicServiceTimer;
  Timer trackMechanicTimer;
  Timer searchingForMechanicTimer;
  Timer listeningForMechanicDiagnosesTimer;
  Address mechanicLocation = Address();
  bool isUpcomingRequestDataReady = false;

  // List<RepairsToBeMade> repairsToBeMadeList = [
  //   RepairsToBeMade(
  //       repairkind: "item",
  //       repairitself: Repairitself(
  //           category: "سينسور",
  //           itemDesc: "سينسور اكسوجين Nissan Sunny",
  //           price: 1200),
  //       repairNumber: "2"),
  //   RepairsToBeMade(
  //       repairkind: "service",
  //       repairitself: Repairitself(
  //           category: " تغير سينسور",
  //           expectedFare: 250,
  //           serviceDesc: "تغير سينسور الاكسوجين"),
  //       repairNumber: "1"),
  // ];

  List<RepairsToBeMade> repairsToBeMadeList_Items = [];
  List<RepairsToBeMade> repairsToBeMadeList_Services = [];

  double _itemsSubTotal = 0.0;
  double _servicesSubTotal = 0.0;
  double _finalEstimatedFare = 0.0;
  bool confirmMechanicRequestIsLoading = false;

  confirmMechanicRequest(context) async {
    confirmMechanicRequestIsLoading = true;
    notifyListeners();
    confirmMechanicServiceResponseModel =
        await mechanicApiRequest.findAMechanic(
            confirmMechanicServiceRequestModel, loadJwtTokenFromDB(), context);
    confirmMechanicRequestIsLoading = false;
    print(confirmMechanicServiceResponseModel.status);

    if (confirmMechanicServiceResponseModel.status == "SEARCHING" &&
        confirmMechanicServiceResponseModel.error == null) {
      MECHANIC_STATUS_SEARCHING = true;
      notifyListeners();
      print("hi bye ${confirmMechanicServiceResponseModel.status}");
      searchingForMechanicTimer =
          Timer.periodic(Duration(seconds: 10), (timer) async {
        print("timer loop");
        await checkStatusForConfirmedMechanicService(context);
        if (MECHANIC_STATUS_TERMINATED == true) {
          print("process terminated");
          final snackBar = SnackBar(
              content: Text(
                  'Time out !! Failed to get nearest winch driver \nPlease try again'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          timer.cancel();
          //resetApp();
          //searchForNearestWinchSheet(context);
        } else if (MECHANIC_STATUS_ACCEPTED == true) {
          print("driver found");
          print("timer Stopped");
          timer.cancel();
        } else {
          print(DateTime.now());
          print("still searching for nearest driver");
        }
      });
    } else if (confirmMechanicServiceResponseModel.status == "COMPLETED") {
      MECHANIC_STATUS_COMPLETED = true;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('error : ${confirmMechanicServiceResponseModel.error}')));
    } else if (confirmMechanicServiceResponseModel.status == "SEARCHING" &&
        confirmMechanicServiceResponseModel.requestId != null) {
      MECHANIC_STATUS_HAVE_ACTIVE_RIDE = true;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('error : ${confirmMechanicServiceResponseModel.error}')));
    } else {
      print("status: ${confirmMechanicServiceResponseModel.status}");
      print("error :${confirmMechanicServiceResponseModel.error}");
    }

    notifyListeners();
  }

  bool isNavigatedToAcceptedMap = false;
  bool isNavigatedToCarChecking = false;
  bool isNavigatedToStartingService = false;
  checkStatusForConfirmedMechanicService(context) async {
    isLoading = true;
    checkMechanicRequestStatusResponseModel = await mechanicApiRequest
        .checkMechanicRequestStatus(loadJwtTokenFromDB(), context);
    isLoading = false;
    if (checkMechanicRequestStatusResponseModel.status == "SEARCHING") {
      MECHANIC_STATUS_SEARCHING = true;
      MECHANIC_STATUS_TERMINATED = false;
      checkMechanicRequestStatusResponseModel.error ==
              "This customer has already an active ride."
          ? MECHANIC_STATUS_HAVE_ACTIVE_RIDE = true
          : print(checkMechanicRequestStatusResponseModel.error);
    }

    if (checkMechanicRequestStatusResponseModel.status == "ACCEPTED") {
      if (isNavigatedToAcceptedMap == false) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Mechanic Accept your requests')));
        Navigator.pushNamedAndRemoveUntil(
            context, AcceptedMechanicServiceMap.routeName, (route) => false);
        MECHANIC_STATUS_ACCEPTED = true;
        MECHANIC_STATUS_SEARCHING = false;
      }
      mechanicLocation.latitude = double.parse(
          checkMechanicRequestStatusResponseModel.mechanicLocationLat);
      mechanicLocation.longitude = double.parse(
          checkMechanicRequestStatusResponseModel.mechanicLocationLong);
      mechanicLocation.placeName = "Winch driver current Location";
      setCustomMarker();
      print(
          "timePassedSinceRequestAcceptance: ${checkMechanicRequestStatusResponseModel.timePassedSinceRequestAcceptance}");
    }
    if (checkMechanicRequestStatusResponseModel.status == "ARRIVED") {
      if (isNavigatedToCarChecking == false) {
        MECHANIC_STATUS_ARRIVED = true;
        MECHANIC_STATUS_SEARCHING = false;
        trackMechanicTimer.cancel();
        Navigator.pushNamedAndRemoveUntil(
            context, CarChecking.routeName, (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Mechanic Arrived To your location')));
      }
      print(
          "timePassedSinceDriverArrival: ${checkMechanicRequestStatusResponseModel.timePassedSinceDriverArrival}");
    }
    if (checkMechanicRequestStatusResponseModel.status == "Service STARTED") {
      if (isNavigatedToStartingService == false) {
        MECHANIC_STATUS_STARTED = true;
        MECHANIC_STATUS_SEARCHING = false;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Mechanic started your service')));
      }
      //Provider.of<PolyLineProvider>(context, listen: false).resetPolyLine();
      print(
          "timePassedSinceServiceStart:${checkMechanicRequestStatusResponseModel.timePassedSinceServiceStart}");
      // Provider.of<PolyLineProvider>(context, listen: false).getPlaceDirection(
      //     startMapMarker: secondMapStartMarker,
      //     destinationMapMarker: secondMapDestinationMarker,
      //     context: context,
      //     initialPosition:
      //         Provider.of<MapsProvider>(context, listen: false).pickUpLocation,
      //     finalPosition:
      //         Provider.of<MapsProvider>(context, listen: false).dropOffLocation,
      //     googleMapController: Provider.of<MapsProvider>(context, listen: false)
      //         .googleMapController);
    }

    if (checkMechanicRequestStatusResponseModel.status ==
        "WAITING_FOR_APPROVAL") {
      WAITING_FOR_APPROVAL = true;
    }
    if (checkMechanicRequestStatusResponseModel.status ==
        "WAITING_FOR_APPROVAL") {
      WAITING_FOR_APPROVAL = true;
    }
    if (checkMechanicRequestStatusResponseModel.status == "CUSTOMER_RESPONSE") {
      CUSTOMER_RESPONSE = true;
      WAITING_FOR_APPROVAL = false;
    }
    if (checkMechanicRequestStatusResponseModel.status == "COMPLETED") {
      MECHANIC_STATUS_COMPLETED = true;
      MECHANIC_STATUS_SEARCHING = false;
    }
    notifyListeners();
  }

  trackMechanic(context) async {
    if (MECHANIC_STATUS_ACCEPTED == true) {
      Provider.of<PolyLineProvider>(context, listen: false).updateMarkerPos(
          context,
          mechanicLocation,
          startMapMarker,
          Provider.of<MapsProvider>(context, listen: false).pickUpLocation);
      trackMechanicTimer = Timer.periodic(Duration(seconds: 2), (timer) async {
        print("Driver Tracking........");
        await checkStatusForConfirmedMechanicService(context);
        if (MECHANIC_STATUS_ACCEPTED == true ||
            MECHANIC_STATUS_ARRIVED == true ||
            MECHANIC_STATUS_STARTED == true) {
          mechanicLocation.latitude = double.parse(
              checkMechanicRequestStatusResponseModel.mechanicLocationLat);
          mechanicLocation.longitude = double.parse(
              checkMechanicRequestStatusResponseModel.mechanicLocationLong);
          mechanicLocation.placeName = "Winch driver current Location";
          Provider.of<PolyLineProvider>(context, listen: false).updateMarkerPos(
              context,
              mechanicLocation,
              startMapMarker,
              Provider.of<MapsProvider>(context, listen: false).pickUpLocation);
          print(
              "Driver Current Location Lat : ${checkMechanicRequestStatusResponseModel.mechanicLocationLat}");
          print(
              "Driver Current Location long : ${checkMechanicRequestStatusResponseModel.mechanicLocationLong}");
        } else
          print(
              "Status now : ${checkMechanicRequestStatusResponseModel.status}");
        notifyListeners();
      });
    } else
      print("your request didn't accepted yet");
    notifyListeners();
  }

  bool cancelMechanicRequestIsLoading = false;
  cancelMechanicRequest(context) async {
    cancelMechanicRequestIsLoading = true;
    notifyListeners();
    cancellingMechanicServiceResponseModel = await mechanicApiRequest
        .cancelMechanicRequest(loadJwtTokenFromDB(), context);
    cancelMechanicRequestIsLoading = false;
    Navigator.pushNamedAndRemoveUntil(
        context, DashBoard.routeName, (route) => false);
    // if (MechanicRequestProvider
    //         .MECHANIC_CANCELING_ADDED_FINE ==
    //         true ||
    //     MechanicRequestProvider
    //         .MECHANIC_CANCELING_ADDED_FINE ==
    //         false) {
    // }
    print("${cancellingMechanicServiceResponseModel.details}");
    MECHANIC_STATUS_SEARCHING = false;
    searchingForMechanicTimer.cancel();
    notifyListeners();
  }

  listeningForMechanicDiagnoses(context) {
    listeningForMechanicDiagnosesTimer =
        Timer.periodic(Duration(seconds: 2), (timer) async {
      checkStatusForConfirmedMechanicService(context);
      if (WAITING_FOR_APPROVAL == true) {
        loadDiagnoses();
        listeningForMechanicDiagnosesTimer.cancel();
        Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __) =>
                ViewingComingDiagnoses()));
      }
    });
  }

  bool loadDiagnosesIsLoading = false;
  loadDiagnoses() async {
    repairsAssignedByMechanicResponseModel = await mechanicApiRequest
        .getServicesToBeDoneByMechanic(loadJwtTokenFromDB());
    if (repairsAssignedByMechanicResponseModel.repairsToBeMade != null) {
      loadDiagnosesIsLoading = true;
      notifyListeners();
      for (var j in repairsAssignedByMechanicResponseModel.repairsToBeMade) {
        if (j.repairkind == "item") {
          repairsToBeMadeList_Items.add(j);
          _itemsSubTotal += j.repairitself.price;
        }
        if (j.repairkind == "service") {
          repairsToBeMadeList_Services.add(j);
          _servicesSubTotal += j.repairitself.expectedFare;
        }
      }
      DIAGNOSIS_ARRIVED = true;
      loadDiagnosesIsLoading = false;
    } else
      print(repairsAssignedByMechanicResponseModel.error);
    print("Still Diagnosing");
    notifyListeners();
    //print(repairsAssignedByMechanicResponseModel.repairsToBeMade);
  }

  bool approveUpComingDiagnosisIsLoading = false;
  approveUpComingDiagnosis(context) async {
    approveUpComingDiagnosisIsLoading = true;
    notifyListeners();
    customerResponseAboutServicesToBeDoneResponseModel =
        await mechanicApiRequest.respondToConfirmedRepairsFromMechanic(
            customerResponseAboutServicesToBeDoneRequestModelAccept,
            loadJwtTokenFromDB());
    approveUpComingDiagnosisIsLoading = false;
    if (customerResponseAboutServicesToBeDoneResponseModel.msg == "Approved!") {
      Navigator.pushNamedAndRemoveUntil(
          context, StartingMechanicService.routeName, (route) => false);
    }
    notifyListeners();
  }

  bool rejectUpComingDiagnosisIsLoading = false;
  rejectUpComingDiagnosis(context) async {
    rejectUpComingDiagnosisIsLoading = true;
    notifyListeners();
    customerResponseAboutServicesToBeDoneResponseModel =
        await mechanicApiRequest.respondToConfirmedRepairsFromMechanic(
            customerResponseAboutServicesToBeDoneRequestModelReject,
            loadJwtTokenFromDB());
    rejectUpComingDiagnosisIsLoading = false;

    if (customerResponseAboutServicesToBeDoneResponseModel.msg == "Refused!") {
      waitingForEndingMechanicService(context);
      final _dialog = RatingDialog(
        enableComment: MECHANIC_STATUS_COMPLETED == true ? true : false,
        ratingColor:
            MECHANIC_STATUS_COMPLETED == true ? Colors.yellow : Colors.white,
        // your app's name?
        title: MECHANIC_STATUS_COMPLETED == true
            ? '${checkMechanicRequestStatusResponseModel.fare} EGP'
            : 'Please wait',
        // encourage your user to leave a high rating?
        message: MECHANIC_STATUS_COMPLETED == true
            ? 'Tap a star to set your rating. Add more description here if you want.'
            : ',Mechanic will end this service soon',
        // your app's logo?
        image: MECHANIC_STATUS_COMPLETED == true
            ? SvgPicture.asset(
                "assets/icons/cash.svg",
                height: MediaQuery.of(context).size.height * 0.15,
              )
            : CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
        submitButton: MECHANIC_STATUS_COMPLETED == true ? 'Submit rating' : '',
        // onCancelled: () => print('cancelled'),
        onSubmitted: (response) async {
          ratingForMechanicServiceRequestModel.stars =
              response.rating.toString();
          await mechanicApiRequest.rateMechanic(
              ratingForMechanicServiceRequestModel, loadJwtTokenFromDB());
          Navigator.pushNamedAndRemoveUntil(
              context, DashBoard.routeName, (route) => false);
        },
      );
      showDialog(
        context: context,
        builder: (context) => _dialog,
      );
    }
    notifyListeners();
  }

  waitingForEndingMechanicService(context) {
    waitingForEndingMechanicServiceTimer =
        Timer.periodic(Duration(seconds: 2), (timer) async {
      checkStatusForConfirmedMechanicService(context);
      print(checkMechanicRequestStatusResponseModel.status);
      if (MECHANIC_STATUS_COMPLETED == true) {
        timer.cancel();
        final _dialog = RatingDialog(
          // your app's name?
          title: '${checkMechanicRequestStatusResponseModel.fare.ceil()} EGP',
          // encourage your user to leave a high rating?
          message:
              'Tap a star to set your rating for mechanic. Add comment here if you want.',
          // your app's logo?
          image: true
              ? SvgPicture.asset(
                  "assets/icons/cash.svg",
                  height: MediaQuery.of(context).size.height * 0.15,
                )
              : CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green)),
          submitButton: 'Submit Rating For Mechanic',
          // onCancelled: () => print('cancelled'),
          onSubmitted: (response) async {
            print("amr diab submitted");
            Navigator.pushNamedAndRemoveUntil(
                context, DashBoard.routeName, (route) => false);
            ratingForMechanicServiceRequestModel.stars =
                response.rating.toString();
            await mechanicApiRequest.rateMechanic(
                ratingForMechanicServiceRequestModel, loadJwtTokenFromDB());
          },
        );
        showDialog(
          context: context,
          builder: (context) => _dialog,
        );
      }
    });
  }

  BitmapDescriptor startMapMarker;
  BitmapDescriptor destinationMapMarker;
  BitmapDescriptor secondMapStartMarker;
  BitmapDescriptor secondMapDestinationMarker;

  void setCustomMarker() async {
    startMapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0.1, 0.1)),
        'assets/icons/empty_winch.png');
    destinationMapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/icons/Car.png');

    secondMapDestinationMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/icons/google-maps-car-icon.png');
    secondMapStartMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(0.1, 0.1)),
        'assets/icons/winch_with_car.png');
    notifyListeners();
  }

  double get servicesSubTotal => _servicesSubTotal;

  double get finalEstimatedFare {
    return _finalEstimatedFare = _servicesSubTotal + _itemsSubTotal + 50;
  }

  double get itemsSubTotal => _itemsSubTotal;
}
