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
    this.timePassedSinceDriverArrival,
    this.timePassedSinceServiceStart,
    this.timePassedSinceRequestAcceptance,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.winchPlates,
    this.driverLocationLat,
    this.driverLocationLong,
    this.reason,
    this.scope,
    this.error,
  });

  String status;
  double timePassedSinceDriverArrival;
  double timePassedSinceServiceStart;
  double timePassedSinceRequestAcceptance;
  String firstName;
  String lastName;
  String phoneNumber;
  String winchPlates;
  String driverLocationLat;
  String driverLocationLong;
  String reason;
  int scope;
  String error;

  factory CheckRequestStatusResponseModel.fromJson(Map<String, dynamic> json) =>
      CheckRequestStatusResponseModel(
        status: json["Status"],
        timePassedSinceDriverArrival:
            json["Time Passed Since Driver Arrival"] != null
                ? json["Time Passed Since Driver Arrival"].toDouble()
                : null,
        timePassedSinceServiceStart:
            json["Time Passed Since Service Start "] != null
                ? json["Time Passed Since Service Start "].toDouble()
                : null,
        timePassedSinceRequestAcceptance:
            json["Time Passed Since Request Acceptance"] != null
                ? json["Time Passed Since Request Acceptance"].toDouble()
                : null,
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        winchPlates: json["winchPlates"],
        driverLocationLat: json["DriverLocation_lat"],
        driverLocationLong: json["DriverLocation_long"],
        reason: json["Reason"],
        scope: json["Scope"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Time Passed Since Driver Arrival": timePassedSinceDriverArrival,
        "Time Passed Since Service Start ": timePassedSinceServiceStart,
        "Time Passed Since Request Acceptance":
            timePassedSinceRequestAcceptance,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "winchPlates": winchPlates,
        "DriverLocation_lat": driverLocationLat,
        "DriverLocation_long": driverLocationLong,
        "Reason": reason,
        "Scope": scope,
        "error": error,
      };
}
