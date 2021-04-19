import 'dart:async';
import 'package:customer_app/models/maps/winch_request/request_status_model.dart';
import 'package:customer_app/models/maps/winch_request/winch_request_model.dart';
import 'package:customer_app/services/maps_services/winch_services/winch_request_services.dart';
import 'package:flutter/foundation.dart';

class WinchRequestProvider with ChangeNotifier {

  WinchResponseModel winchResponseModel=WinchResponseModel();
  RequestStatusResponseModel requestStatusResponseModel=RequestStatusResponseModel();
  WinchRequestApi api= new WinchRequestApi();
  bool isLoading = false;
  Timer timer;

   confirmWinchService(winchRequestModel,token) async {
    isLoading = true;
    winchResponseModel=await api.findWinchDriver(winchRequestModel, token);
    isLoading = false;

    notifyListeners();
  }

  checkConfirmedWinchServiceStatus(token) async {
     isLoading=true;
     requestStatusResponseModel=await api.checkRequestStatus(token);
     isLoading=false;
     if(requestStatusResponseModel.status=="SEARCHING"){
       Timer.periodic(Duration(seconds: 30), (timer){
          checkConfirmedWinchServiceStatus(token);
          print(requestStatusResponseModel.status);
          if(requestStatusResponseModel.status=="TERMINATED"||requestStatusResponseModel.status=="ACCEPTED")
            timer.cancel();
       });
     }
     notifyListeners();
  }

}