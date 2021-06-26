// To parse this JSON data, do
//
//     final confirmMechanicServiceRequestModel = confirmMechanicServiceRequestModelFromJson(jsonString);

import 'dart:convert';

ConfirmMechanicServiceRequestModel confirmMechanicServiceRequestModelFromJson(
        String str) =>
    ConfirmMechanicServiceRequestModel.fromJson(json.decode(str));

String confirmMechanicServiceRequestModelToJson(
        ConfirmMechanicServiceRequestModel data) =>
    json.encode(data.toJson());

class ConfirmMechanicServiceRequestModel {
  ConfirmMechanicServiceRequestModel({
    this.pickupLocationLat,
    this.pickupLocationLong,
    this.intialDiagnosis,
    this.carId,
    this.Estimated_Time,
    this.Estimated_Fare,
  });

  String pickupLocationLat;
  String pickupLocationLong;
  String intialDiagnosis;
  String carId;
  String Estimated_Time;
  String Estimated_Fare;

  factory ConfirmMechanicServiceRequestModel.fromJson(
          Map<String, dynamic> json) =>
      ConfirmMechanicServiceRequestModel(
        pickupLocationLat: json["PickupLocation_Lat"],
        pickupLocationLong: json["PickupLocation_Long"],
        intialDiagnosis: json["IntialDiagnosis"],
        carId: json["Car_ID"],
        Estimated_Time: json["Estimated_Time"],
        Estimated_Fare: json["Estimated_Fare"],
      );

  Map<String, dynamic> toJson() => {
        "PickupLocation_Lat": pickupLocationLat,
        "PickupLocation_Long": pickupLocationLong,
        "IntialDiagnosis": intialDiagnosis,
        "Car_ID": carId,
        "Estimated_Time": Estimated_Time,
        "Estimated_Fare": Estimated_Fare
      };
}
// To parse this JSON data, do
//
//     final confirmMechanicServiceResponseModel = confirmMechanicServiceResponseModelFromJson(jsonString);

ConfirmMechanicServiceResponseModel confirmMechanicServiceResponseModelFromJson(
        String str) =>
    ConfirmMechanicServiceResponseModel.fromJson(json.decode(str));

String confirmMechanicServiceResponseModelToJson(
        ConfirmMechanicServiceResponseModel data) =>
    json.encode(data.toJson());

class ConfirmMechanicServiceResponseModel {
  ConfirmMechanicServiceResponseModel({
    this.error,
    this.status,
    this.requestId,
  });

  String error;
  String status;
  String requestId;

  factory ConfirmMechanicServiceResponseModel.fromJson(
          Map<String, dynamic> json) =>
      ConfirmMechanicServiceResponseModel(
        error: json["error"],
        status: json["status"],
        requestId: json["requestId"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "status": status,
        "requestId": requestId,
      };
}
