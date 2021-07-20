// To parse this JSON data, do
//
//     final cancellingMechanicServiceResponseModel = cancellingMechanicServiceResponseModelFromJson(jsonString);

import 'dart:convert';

CancellingMechanicServiceResponseModel
    cancellingMechanicServiceResponseModelFromJson(String str) =>
        CancellingMechanicServiceResponseModel.fromJson(json.decode(str));

String cancellingMechanicServiceResponseModelToJson(
        CancellingMechanicServiceResponseModel data) =>
    json.encode(data.toJson());

class CancellingMechanicServiceResponseModel {
  CancellingMechanicServiceResponseModel({
    this.status,
    this.details,
    this.mechanicBalance,
    this.customerWallet,
  });

  String status;
  String details;
  int mechanicBalance;
  int customerWallet;

  factory CancellingMechanicServiceResponseModel.fromJson(
          Map<String, dynamic> json) =>
      CancellingMechanicServiceResponseModel(
        status: json["Status"],
        details: json["Details"],
        mechanicBalance: json["mechanicBalance"],
        customerWallet: json["customerWallet"],
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Details": details,
        "mechanicBalance": mechanicBalance,
        "customerWallet": customerWallet,
      };
}
