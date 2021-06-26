// To parse this JSON data, do
//
//     final customerResponseAboutServicesToBeDoneRequestModel = customerResponseAboutServicesToBeDoneRequestModelFromJson(jsonString);

import 'dart:convert';

CustomerResponseAboutServicesToBeDoneRequestModel
    customerResponseAboutServicesToBeDoneRequestModelFromJson(String str) =>
        CustomerResponseAboutServicesToBeDoneRequestModel.fromJson(
            json.decode(str));

String customerResponseAboutServicesToBeDoneRequestModelToJson(
        CustomerResponseAboutServicesToBeDoneRequestModel data) =>
    json.encode(data.toJson());

class CustomerResponseAboutServicesToBeDoneRequestModel {
  CustomerResponseAboutServicesToBeDoneRequestModel({
    this.customerResponse,
  });

  String customerResponse;

  factory CustomerResponseAboutServicesToBeDoneRequestModel.fromJson(
          Map<String, dynamic> json) =>
      CustomerResponseAboutServicesToBeDoneRequestModel(
        customerResponse: json["customerResponse"],
      );

  Map<String, dynamic> toJson() => {
        "customerResponse": customerResponse,
      };
}
// To parse this JSON data, do
//
//     final customerResponseAboutServicesToBeDoneResponseModel = customerResponseAboutServicesToBeDoneResponseModelFromJson(jsonString);

CustomerResponseAboutServicesToBeDoneResponseModel
    customerResponseAboutServicesToBeDoneResponseModelFromJson(String str) =>
        CustomerResponseAboutServicesToBeDoneResponseModel.fromJson(
            json.decode(str));

String customerResponseAboutServicesToBeDoneResponseModelToJson(
        CustomerResponseAboutServicesToBeDoneResponseModel data) =>
    json.encode(data.toJson());

class CustomerResponseAboutServicesToBeDoneResponseModel {
  CustomerResponseAboutServicesToBeDoneResponseModel({
    this.msg,
  });

  String msg;

  factory CustomerResponseAboutServicesToBeDoneResponseModel.fromJson(
          Map<String, dynamic> json) =>
      CustomerResponseAboutServicesToBeDoneResponseModel(
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
      };
}
