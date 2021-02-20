// To parse this JSON data, do
//
//     final loadUserCarsModel = loadUserCarsModelFromJson(jsonString);

import 'dart:convert';

List<LoadUserCarsModel> loadUserCarsModelFromJson(String str) =>
    List<LoadUserCarsModel>.from(
        json.decode(str).map((x) => LoadUserCarsModel.fromJson(x)));

String loadUserCarsModelToJson(List<LoadUserCarsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoadUserCarsModel {
  LoadUserCarsModel({
    this.id,
    this.carBrand,
    this.model,
    this.year,
    this.ownerId,
    this.plates,
    this.v,
  });

  String id;
  String carBrand;
  String model;
  int year;
  String ownerId;
  String plates;
  int v;

  factory LoadUserCarsModel.fromJson(Map<String, dynamic> json) =>
      LoadUserCarsModel(
        id: json["_id"],
        carBrand: json["CarBrand"],
        model: json["Model"],
        year: json["Year"],
        ownerId: json["OwnerId"],
        plates: json["Plates"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "CarBrand": carBrand,
        "Model": model,
        "Year": year,
        "OwnerId": ownerId,
        "Plates": plates,
        "__v": v,
      };
  static List<LoadUserCarsModel> parseUserCars(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<LoadUserCarsModel> carList =
        list.map((model) => LoadUserCarsModel.fromJson(model)).toList();
    return carList;
  }
}
