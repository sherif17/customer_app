// To parse this JSON data, do
//
//     final cancellingWinchServiceResponseModel = cancellingWinchServiceResponseModelFromJson(jsonString);

import 'dart:convert';

CancellingWinchServiceResponseModel cancellingWinchServiceResponseModelFromJson(
        String str) =>
    CancellingWinchServiceResponseModel.fromJson(json.decode(str));

String cancellingWinchServiceResponseModelToJson(
        CancellingWinchServiceResponseModel data) =>
    json.encode(data.toJson());

class CancellingWinchServiceResponseModel {
  CancellingWinchServiceResponseModel({
    this.status,
    this.details,
    this.driverBalance,
    this.customerWallet,
  });

  String status;
  String details;
  int driverBalance;
  int customerWallet;

  factory CancellingWinchServiceResponseModel.fromJson(
          Map<String, dynamic> json) =>
      CancellingWinchServiceResponseModel(
        status: json["Status"],
        details: json["Details"],
        driverBalance: json["driverBalance"],
        customerWallet: json["customerWallet"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Details": details,
        "driverBalance": driverBalance,
        "customerWallet": customerWallet,
      };
}
