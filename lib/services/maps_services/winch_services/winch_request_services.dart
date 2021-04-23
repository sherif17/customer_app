import 'dart:convert';

import 'package:customer_app/models/maps/winch_request/request_status_model.dart';
import 'package:customer_app/models/maps/winch_request/winch_request_model.dart';
import 'package:http/http.dart' as http;

class WinchRequestApi{
  Future<WinchResponseModel> findWinchDriver(
      WinchRequestModel winchRequestModel , token) async {
    var url = Uri.parse('http://161.97.155.244/api/requestwinch/createrequest');
    final response = await http.post(url,
        headers: {"x-auth-token": "$token"}, body: winchRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return WinchResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Something Wrong happenedd");
    }
  }

  Future<RequestStatusResponseModel> checkRequestStatus(token) async {
    var url = Uri.parse('http://161.97.155.244/api/requestwinch/checkstatus');
    final response = await http.get(url,
        headers: {"x-auth-token": "$token"},);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return RequestStatusResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Something Wrong happenedd");
    }
  }

}