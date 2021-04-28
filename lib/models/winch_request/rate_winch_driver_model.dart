// To parse this JSON data, do
//
//     final ratingForWinchDriverRequestModel = ratingForWinchDriverRequestModelFromJson(jsonString);

import 'dart:convert';

RatingForWinchDriverRequestModel ratingForWinchDriverRequestModelFromJson(
        String str) =>
    RatingForWinchDriverRequestModel.fromJson(json.decode(str));

String ratingForWinchDriverRequestModelToJson(
        RatingForWinchDriverRequestModel data) =>
    json.encode(data.toJson());

class RatingForWinchDriverRequestModel {
  RatingForWinchDriverRequestModel({
    this.stars,
  });

  String stars;

  factory RatingForWinchDriverRequestModel.fromJson(
          Map<String, dynamic> json) =>
      RatingForWinchDriverRequestModel(
        stars: json["Stars"],
      );

  Map<String, dynamic> toJson() => {
        "Stars": stars,
      };
}
// To parse this JSON data, do
//
//     final ratingForWinchDriverResponseModel = ratingForWinchDriverResponseModelFromJson(jsonString);

RatingForWinchDriverResponseModel ratingForWinchDriverResponseModelFromJson(
        String str) =>
    RatingForWinchDriverResponseModel.fromJson(json.decode(str));

String ratingForWinchDriverResponseModelToJson(
        RatingForWinchDriverResponseModel data) =>
    json.encode(data.toJson());

class RatingForWinchDriverResponseModel {
  RatingForWinchDriverResponseModel({
    this.msg,
  });

  String msg;

  factory RatingForWinchDriverResponseModel.fromJson(
          Map<String, dynamic> json) =>
      RatingForWinchDriverResponseModel(
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
      };
}
