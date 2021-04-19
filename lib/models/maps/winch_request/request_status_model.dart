// To parse this JSON data, do
//
//     final requestStatusResponseModel = requestStatusResponseModelFromJson(jsonString);

import 'dart:convert';

RequestStatusResponseModel requestStatusResponseModelFromJson(String str) => RequestStatusResponseModel.fromJson(json.decode(str));

String requestStatusResponseModelToJson(RequestStatusResponseModel data) => json.encode(data.toJson());

class RequestStatusResponseModel {
  RequestStatusResponseModel({
    this.status,
    this.error,
    this.scope,
    this.reason,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.winchPlates,
  });

  String status;
  String error;
  int scope;
  String reason;
  String firstName;
  String lastName;
  String phoneNumber;
  String winchPlates;

  factory RequestStatusResponseModel.fromJson(Map<String, dynamic> json) => RequestStatusResponseModel(
    status: json["Status"],
    error: json["error"],
    scope: json["Scope"],
    reason: json["Reason"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phoneNumber: json["phoneNumber"],
    winchPlates: json["winchPlates"],
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "error": error,
    "Scope": scope,
    "Reason": reason,
    "firstName": firstName,
    "lastName": lastName,
    "phoneNumber": phoneNumber,
    "winchPlates": winchPlates,
  };
}
