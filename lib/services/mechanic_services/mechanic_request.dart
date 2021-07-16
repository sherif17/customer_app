import 'dart:convert';
import 'package:customer_app/models/mechanic_request/cancel_mechanic_service_model.dart';
import 'package:customer_app/models/mechanic_request/check_mechanic_status_model.dart';
import 'package:customer_app/models/mechanic_request/confirm_mechanic_service_model.dart';
import 'package:customer_app/models/mechanic_request/customer_resoponse_about_services_to_be_made_model.dart';
import 'package:customer_app/models/mechanic_request/rate_mechanic_model.dart';
import 'package:customer_app/models/mechanic_request/repaires_assigned_by_mechanic_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MechanicApiRequest {
  Future<ConfirmMechanicServiceResponseModel> findAMechanic(
      ConfirmMechanicServiceRequestModel confirmMechanicServiceRequestModel,
      token,
      context) async {
    print(confirmMechanicServiceRequestModel.toJson());
    var url =
        Uri.parse('http://161.97.155.244/api/requestmechanic/createrequest');
    final response = await http.post(url,
        headers: {"x-auth-token": "$token", "Content-Type": "application/json"},
        body: json.encode(confirmMechanicServiceRequestModel));
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      if (response.statusCode == 400) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('error : ${response.body}')));
      }
      return ConfirmMechanicServiceResponseModel.fromJson(
          json.decode(response.body));
    } else {
      throw Exception("Something Wrong happenedd");
    }
  }

  Future<CheckMechanicRequestStatusResponseModel> checkMechanicRequestStatus(
      token, context) async {
    var url =
        Uri.parse('http://161.97.155.244/api/requestmechanic/checkstatus');
    final response = await http.get(
      url,
      headers: {"x-auth-token": "$token"},
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      if (response.statusCode == 400) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('error : ${response.body}')));
      }
      return CheckMechanicRequestStatusResponseModel.fromJson(
          json.decode(response.body));
    } else {
      throw Exception("Something Wrong happenedd");
    }
  }

  Future<RatingForMechanicServiceResponseModel> rateMechanic(
      RatingForMechanicServiceRequestModel ratingForMechanicServiceRequestModel,
      token) async {
    var url = Uri.parse('http://161.97.155.244/api/requestmechanic/Rate');
    final response = await http.post(url,
        headers: {"x-auth-token": "$token"},
        body: ratingForMechanicServiceRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return RatingForMechanicServiceResponseModel.fromJson(
          json.decode(response.body));
    } else {
      throw Exception("Something Wrong happenedd");
    }
  }

  Future<CancellingMechanicServiceResponseModel> cancelMechanicRequest(
      token, context) async {
    var url = Uri.parse('http://161.97.155.244/api/requestmechanic/cancelride');
    final response = await http.get(
      url,
      headers: {"x-auth-token": "$token"},
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      if (response.statusCode == 400) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('error : ${response.body}')));
      }
      print("response.body:${response.body}");
      return CancellingMechanicServiceResponseModel.fromJson(
          json.decode(response.body));
    } else {
      throw Exception("Something Wrong happenedd");
    }
  }

  Future<RepairsAssignedByMechanicResponseModel> getServicesToBeDoneByMechanic(
      token) async {
    var url = Uri.parse(
        'http://161.97.155.244/api/requestmechanic/loadRepairsToBeMade');
    final response = await http.get(
      url,
      headers: {"x-auth-token": "$token"},
    );
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return RepairsAssignedByMechanicResponseModel.fromJson(
          json.decode(response.body));
    } else {
      throw Exception("Something Wrong happenedd");
    }
  }

  Future<CustomerResponseAboutServicesToBeDoneResponseModel>
      respondToConfirmedRepairsFromMechanic(
          CustomerResponseAboutServicesToBeDoneRequestModel
              customerResponseAboutServicesToBeDoneRequestModel,
          token) async {
    var url =
        Uri.parse('http://161.97.155.244/api/requestmechanic/CustomerResponse');
    final response = await http.post(url,
        headers: {"x-auth-token": "$token"},
        body: customerResponseAboutServicesToBeDoneRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return CustomerResponseAboutServicesToBeDoneResponseModel.fromJson(
          json.decode(response.body));
    } else {
      throw Exception("Something Wrong happenedd");
    }
  }
}
