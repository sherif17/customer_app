// To parse this JSON data, do
//
//     final phoneRequestModel = phoneRequestModelFromJson(jsonString);

import 'dart:convert';

PhoneRequestModel phoneRequestModelFromJson(String str) =>
    PhoneRequestModel.fromJson(json.decode(str));

String phoneRequestModelToJson(PhoneRequestModel data) =>
    json.encode(data.toJson());

class PhoneRequestModel {
  PhoneRequestModel({
    this.phoneNumber,
  });

  String phoneNumber;

  factory PhoneRequestModel.fromJson(Map<String, dynamic> json) =>
      PhoneRequestModel(
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
      };
}

// To parse this JSON data, do
//
//     final phoneResponseModel = phoneResponseModelFromJson(jsonString);

PhoneResponseModel phoneResponseModelFromJson(String str) =>
    PhoneResponseModel.fromJson(json.decode(str));

String phoneResponseModelToJson(PhoneResponseModel data) =>
    json.encode(data.toJson());

class PhoneResponseModel {
  PhoneResponseModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.information,
  });

  String id;
  String firstName;
  String lastName;
  String phoneNumber;
  String information;

  factory PhoneResponseModel.fromJson(Map<String, dynamic> json) =>
      PhoneResponseModel(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        information: json["Information"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "Information": information,
      };
}
