// To parse this JSON data, do
//
//     final confirmMechanicServiceRequestModel = confirmMechanicServiceRequestModelFromJson(jsonString);
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
    this.estimatedTime,
    this.estimatedFare,
    this.carId,
  });

  String pickupLocationLat;
  String pickupLocationLong;
  List<IntialDiagnosis> intialDiagnosis;
  String estimatedTime;
  String estimatedFare;
  String carId;

  factory ConfirmMechanicServiceRequestModel.fromJson(
          Map<String, dynamic> json) =>
      ConfirmMechanicServiceRequestModel(
        pickupLocationLat: json["PickupLocation_Lat"],
        pickupLocationLong: json["PickupLocation_Long"],
        intialDiagnosis: List<IntialDiagnosis>.from(
            json["IntialDiagnosis"].map((x) => IntialDiagnosis.fromJson(x))),
        estimatedTime: json["Estimated_Time"],
        estimatedFare: json["Estimated_Fare"],
        carId: json["Car_ID"],
      );

  Map<String, dynamic> toJson() => {
        "PickupLocation_Lat": pickupLocationLat,
        "PickupLocation_Long": pickupLocationLong,
        "IntialDiagnosis":
            List<dynamic>.from(intialDiagnosis.map((x) => x.toJson())),
        "Estimated_Time": estimatedTime,
        "Estimated_Fare": estimatedFare,
        "Car_ID": carId,
      };
}

class IntialDiagnosis {
  IntialDiagnosis({
    this.id,
    this.category,
  });

  String id;
  String category;

  factory IntialDiagnosis.fromJson(Map<String, dynamic> json) =>
      IntialDiagnosis(
        id: json["id"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
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
