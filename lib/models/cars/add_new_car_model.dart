// To parse this JSON data, do
//
//     final addNewCarRequestModel = addNewCarRequestModelFromJson(jsonString);

import 'dart:convert';

AddNewCarRequestModel addNewCarRequestModelFromJson(String str) =>
    AddNewCarRequestModel.fromJson(json.decode(str));

String addNewCarRequestModelToJson(AddNewCarRequestModel data) =>
    json.encode(data.toJson());

class AddNewCarRequestModel {
  AddNewCarRequestModel({
    this.carBrand,
    this.model,
    this.year,
    this.plates,
  });

  String carBrand;
  String model;
  String year;
  String plates;

  factory AddNewCarRequestModel.fromJson(Map<String, dynamic> json) =>
      AddNewCarRequestModel(
        carBrand: json["CarBrand"],
        model: json["Model"],
        year: json["Year"],
        plates: json["Plates"],
      );

  Map<String, dynamic> toJson() => {
        "CarBrand": carBrand,
        "Model": model,
        "Year": year,
        "Plates": plates,
      };
}

// To parse this JSON data, do
//
//     final addNewCarResponseModel = addNewCarResponseModelFromJson(jsonString);

AddNewCarResponseModel addNewCarResponseModelFromJson(String str) =>
    AddNewCarResponseModel.fromJson(json.decode(str));

String addNewCarResponseModelToJson(AddNewCarResponseModel data) =>
    json.encode(data.toJson());

class AddNewCarResponseModel {
  AddNewCarResponseModel({
    this.id,
    this.plates,
    this.error,
  });

  String id;
  String plates;
  String error;

  factory AddNewCarResponseModel.fromJson(Map<String, dynamic> json) =>
      AddNewCarResponseModel(
        id: json["_id"],
        plates: json["Plates"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Plates": plates,
        "error": error,
      };
}
