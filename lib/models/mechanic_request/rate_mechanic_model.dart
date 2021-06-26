// To parse this JSON data, do
//
//     final ratingForMechanicServiceRequestModel = ratingForMechanicServiceRequestModelFromJson(jsonString);

import 'dart:convert';

RatingForMechanicServiceRequestModel
    ratingForMechanicServiceRequestModelFromJson(String str) =>
        RatingForMechanicServiceRequestModel.fromJson(json.decode(str));

String ratingForMechanicServiceRequestModelToJson(
        RatingForMechanicServiceRequestModel data) =>
    json.encode(data.toJson());

class RatingForMechanicServiceRequestModel {
  RatingForMechanicServiceRequestModel({
    this.stars,
  });

  String stars;

  factory RatingForMechanicServiceRequestModel.fromJson(
          Map<String, dynamic> json) =>
      RatingForMechanicServiceRequestModel(
        stars: json["Stars"],
      );

  Map<String, dynamic> toJson() => {
        "Stars": stars,
      };
}
// To parse this JSON data, do
//
//     final ratingForMechanicServiceResponseModel = ratingForMechanicServiceResponseModelFromJson(jsonString);

RatingForMechanicServiceResponseModel
    ratingForMechanicServiceResponseModelFromJson(String str) =>
        RatingForMechanicServiceResponseModel.fromJson(json.decode(str));

String ratingForMechanicServiceResponseModelToJson(
        RatingForMechanicServiceResponseModel data) =>
    json.encode(data.toJson());

class RatingForMechanicServiceResponseModel {
  RatingForMechanicServiceResponseModel({
    this.msg,
  });

  String msg;

  factory RatingForMechanicServiceResponseModel.fromJson(
          Map<String, dynamic> json) =>
      RatingForMechanicServiceResponseModel(
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
      };
}
