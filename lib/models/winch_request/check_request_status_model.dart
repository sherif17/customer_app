// To parse this JSON data, do
//
//     final checkRequestStatusResponseModel = checkRequestStatusResponseModelFromJson(jsonString);

import 'dart:convert';

CheckRequestStatusResponseModel checkRequestStatusResponseModelFromJson(
        String str) =>
    CheckRequestStatusResponseModel.fromJson(json.decode(str));

String checkRequestStatusResponseModelToJson(
        CheckRequestStatusResponseModel data) =>
    json.encode(data.toJson());

class CheckRequestStatusResponseModel {
  CheckRequestStatusResponseModel({
    this.status,
    this.timePassedSinceRequestAcceptance,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.winchPlates,
    this.driverLocationLat,
    this.driverLocationLong,
    this.error,
    this.scope,
    this.reason,
  });

  String status;
  double timePassedSinceRequestAcceptance;
  String firstName;
  String lastName;
  String phoneNumber;
  String winchPlates;
  String driverLocationLat;
  String driverLocationLong;
  String error;
  int scope;
  String reason;

  factory CheckRequestStatusResponseModel.fromJson(Map<String, dynamic> json) =>
      CheckRequestStatusResponseModel(
        status: json["Status"],
        timePassedSinceRequestAcceptance:
        json["Time Passed Since Request Acceptance"],//.toDouble(),
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        winchPlates: json["winchPlates"],
        driverLocationLat: json["DriverLocation_lat"],
        driverLocationLong: json["DriverLocation_long"],
        error: json["error"],
        scope: json["Scope"],
        reason: json["Reason"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Time Passed Since Request Acceptance":
            timePassedSinceRequestAcceptance,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "winchPlates": winchPlates,
        "DriverLocation_lat": driverLocationLat,
        "DriverLocation_long": driverLocationLong,
        "error": error,
        "Scope": scope,
        "Reason": reason,
      };
}
