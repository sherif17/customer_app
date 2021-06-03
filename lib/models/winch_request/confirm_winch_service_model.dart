// To parse this JSON data, do
//
//     final confirmWinchServiceRequestModel = confirmWinchServiceRequestModelFromJson(jsonString);

import 'dart:convert';

ConfirmWinchServiceRequestModel confirmWinchServiceRequestModelFromJson(String str) => ConfirmWinchServiceRequestModel.fromJson(json.decode(str));

String confirmWinchServiceRequestModelToJson(ConfirmWinchServiceRequestModel data) => json.encode(data.toJson());

class ConfirmWinchServiceRequestModel {
  ConfirmWinchServiceRequestModel({
    this.dropOffLocationLat,
    this.dropOffLocationLong,
    this.pickupLocationLat,
    this.pickupLocationLong,
    this.estimatedTime,
    this.estimatedDistance,
    this.estimatedFare,
    this.carId,
  });

  String dropOffLocationLat;
  String dropOffLocationLong;
  String pickupLocationLat;
  String pickupLocationLong;
  String estimatedTime;
  String estimatedDistance;
  String estimatedFare;
  String carId;

  factory ConfirmWinchServiceRequestModel.fromJson(Map<String, dynamic> json) => ConfirmWinchServiceRequestModel(
    dropOffLocationLat: json["DropOffLocation_Lat"],
    dropOffLocationLong: json["DropOffLocation_Long"],
    pickupLocationLat: json["PickupLocation_Lat"],
    pickupLocationLong: json["PickupLocation_Long"],
    estimatedTime: json["Estimated_Time"],
    estimatedDistance: json["Estimated_Distance"],
    estimatedFare: json["Estimated_Fare"],
    carId: json["Car_ID"],
  );

  Map<String, dynamic> toJson() => {
    "DropOffLocation_Lat": dropOffLocationLat,
    "DropOffLocation_Long": dropOffLocationLong,
    "PickupLocation_Lat": pickupLocationLat,
    "PickupLocation_Long": pickupLocationLong,
    "Estimated_Time": estimatedTime,
    "Estimated_Distance": estimatedDistance,
    "Estimated_Fare": estimatedFare,
    "Car_ID": carId,
  };
}

// To parse this JSON data, do
//
//     final confirmWinchServiceResponseModel = confirmWinchServiceResponseModelFromJson(jsonString);


ConfirmWinchServiceResponseModel confirmWinchServiceResponseModelFromJson(String str) => ConfirmWinchServiceResponseModel.fromJson(json.decode(str));

String confirmWinchServiceResponseModelToJson(ConfirmWinchServiceResponseModel data) => json.encode(data.toJson());

class ConfirmWinchServiceResponseModel {
  ConfirmWinchServiceResponseModel({
    this.error,
    this.status,
    this.requestId,
  });

  String error;
  String status;
  String requestId;

  factory ConfirmWinchServiceResponseModel.fromJson(Map<String, dynamic> json) => ConfirmWinchServiceResponseModel(
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
