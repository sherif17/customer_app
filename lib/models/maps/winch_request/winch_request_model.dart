// To parse this JSON data, do
//
//     final winchRequestModel = winchRequestModelFromJson(jsonString);

import 'dart:convert';

WinchRequestModel winchRequestModelFromJson(String str) => WinchRequestModel.fromJson(json.decode(str));

String winchRequestModelToJson(WinchRequestModel data) => json.encode(data.toJson());

class WinchRequestModel {
  WinchRequestModel({
    this.dropOffLocationLat,
    this.dropOffLocationLong,
    this.pickupLocationLat,
    this.pickupLocationLong,
  });

  String dropOffLocationLat;
  String dropOffLocationLong;
  String pickupLocationLat;
  String pickupLocationLong;

  factory WinchRequestModel.fromJson(Map<String, dynamic> json) => WinchRequestModel(
    dropOffLocationLat: json["DropOffLocation_Lat"],
    dropOffLocationLong: json["DropOffLocation_Long"],
    pickupLocationLat: json["PickupLocation_Lat"],
    pickupLocationLong: json["PickupLocation_Long"],
  );

  Map<String, dynamic> toJson() => {
    "DropOffLocation_Lat": dropOffLocationLat,
    "DropOffLocation_Long": dropOffLocationLong,
    "PickupLocation_Lat": pickupLocationLat,
    "PickupLocation_Long": pickupLocationLong,
  };
}

// To parse this JSON data, do
//
//     final winchResponseModel = winchResponseModelFromJson(jsonString);


WinchResponseModel winchResponseModelFromJson(String str) => WinchResponseModel.fromJson(json.decode(str));

String winchResponseModelToJson(WinchResponseModel data) => json.encode(data.toJson());

class WinchResponseModel {
  String error;
  String status;
  String requestId;

  WinchResponseModel({
    this.error,
    this.status,
    this.requestId,
  });



  factory WinchResponseModel.fromJson(Map<String, dynamic> json) => WinchResponseModel(
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
