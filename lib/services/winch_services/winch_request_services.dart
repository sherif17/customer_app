import 'dart:convert';
import 'package:customer_app/models/winch_request/cancel_winch_service_model.dart';
import 'package:customer_app/models/winch_request/check_request_status_model.dart';
import 'package:customer_app/models/winch_request/confirm_winch_service_model.dart';
import 'package:customer_app/models/winch_request/rate_winch_driver_model.dart';
import 'package:http/http.dart' as http;

class WinchRequestApi {
  Future<ConfirmWinchServiceResponseModel> findWinchDriver(
      ConfirmWinchServiceRequestModel winchRequestModel, token) async {
    print(winchRequestModel.toJson());
    var url = Uri.parse('http://161.97.155.244/api/requestwinch/createrequest');
    final response = await http.post(url,
        headers: {"x-auth-token": "$token"}, body: winchRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return ConfirmWinchServiceResponseModel.fromJson(
          json.decode(response.body));
    } else {
      throw Exception("Something Wrong happenedd");
    }
  }

  Future<CheckRequestStatusResponseModel> checkRequestStatus(token) async {
    var url = Uri.parse('http://161.97.155.244/api/requestwinch/checkstatus');
    final response = await http.get(
      url,
      headers: {"x-auth-token": "$token"},
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return CheckRequestStatusResponseModel.fromJson(
          json.decode(response.body));
    } else {
      throw Exception("Something Wrong happenedd");
    }
  }

  Future<RatingForWinchDriverResponseModel> rateWinchDriver(
      RatingForWinchDriverRequestModel ratingForWinchDriverRequestModel,
      token) async {
    var url = Uri.parse('http://161.97.155.244/api/requestwinch/createrequest');
    final response = await http.post(url,
        headers: {"x-auth-token": "$token"},
        body: ratingForWinchDriverRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return RatingForWinchDriverResponseModel.fromJson(
          json.decode(response.body));
    } else {
      throw Exception("Something Wrong happenedd");
    }
  }

  Future<CancellingWinchServiceResponseModel> cancelWinchRequest(token) async {
    var url = Uri.parse('http://161.97.155.244/api/requestwinch/cancelride');
    final response = await http.get(
      url,
      headers: {"x-auth-token": "$token"},
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return CancellingWinchServiceResponseModel.fromJson(
          json.decode(response.body));
    } else {
      throw Exception("Something Wrong happenedd");
    }
  }
}
