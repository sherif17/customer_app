// To parse this JSON data, do
//
//     final checkMechanicRequestStatusResponseModel = checkMechanicRequestStatusResponseModelFromJson(jsonString);

import 'dart:convert';

CheckMechanicRequestStatusResponseModel
    checkMechanicRequestStatusResponseModelFromJson(String str) =>
        CheckMechanicRequestStatusResponseModel.fromJson(json.decode(str));

String checkMechanicRequestStatusResponseModelToJson(
        CheckMechanicRequestStatusResponseModel data) =>
    json.encode(data.toJson());

class CheckMechanicRequestStatusResponseModel {
  CheckMechanicRequestStatusResponseModel({
    this.error,
    this.status,
    this.scope,
    this.reason,
    this.timePassedSinceRequestAcceptance,
    this.timePassedSinceDriverArrival,
    this.timePassedSinceServiceStart,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.mechanicLocationLat,
    this.mechanicLocationLong,
    this.tripTime,
    this.fare,
  });

  String error;
  String status;
  int scope;
  String reason;
  double timePassedSinceRequestAcceptance;
  double timePassedSinceDriverArrival;
  double timePassedSinceServiceStart;
  String firstName;
  String lastName;
  String phoneNumber;
  String mechanicLocationLat;
  String mechanicLocationLong;
  TripTime tripTime;
  double fare;

  factory CheckMechanicRequestStatusResponseModel.fromJson(
          Map<String, dynamic> json) =>
      CheckMechanicRequestStatusResponseModel(
        error: json["error"],
        status: json["Status"],
        scope: json["Scope"],
        reason: json["Reason"],
        timePassedSinceRequestAcceptance:
            json["Time Passed Since Request Acceptance"] != null
                ? json["Time Passed Since Request Acceptance"].toDouble()
                : null,
        timePassedSinceDriverArrival:
            json["Time Passed Since Driver Arrival"] != null
                ? json["Time Passed Since Driver Arrival"].toDouble()
                : null,
        timePassedSinceServiceStart:
            json["Time Passed Since Service Start "] != null
                ? json["Time Passed Since Service Start "].toDouble()
                : null,
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        mechanicLocationLat: json["MechanicLocation_lat"],
        mechanicLocationLong: json["MechanicLocation_long"],
        tripTime: json["TripTime"] != null
            ? TripTime.fromJson(json["TripTime"])
            : null,
        fare: json["Fare"] != null ? json["Fare"].toDouble() : null,
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "Status": status,
        "Scope": scope,
        "Reason": reason,
        "Time Passed Since Request Acceptance":
            timePassedSinceRequestAcceptance,
        "Time Passed Since Driver Arrival": timePassedSinceDriverArrival,
        "Time Passed Since Service Start ": timePassedSinceServiceStart,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "MechanicLocation_lat": mechanicLocationLat,
        "MechanicLocation_long": mechanicLocationLong,
        "TripTime": tripTime.toJson(),
        "Fare": fare,
      };
}

class TripTime {
  TripTime({
    this.days,
    this.hours,
    this.minutes,
    this.seconds,
  });

  int days;
  int hours;
  int minutes;
  double seconds;

  factory TripTime.fromJson(Map<String, dynamic> json) => TripTime(
        days: json["days"],
        hours: json["hours"],
        minutes: json["minutes"],
        seconds: json["seconds"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "days": days,
        "hours": hours,
        "minutes": minutes,
        "seconds": seconds,
      };
}
