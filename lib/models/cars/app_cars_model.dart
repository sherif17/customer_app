import 'dart:convert';

// To parse this JSON data, do
//
//     final carModel = carModelFromJson(jsonString);

import 'dart:convert';

List<CarModel> carModelFromJson(String str) =>
    List<CarModel>.from(json.decode(str).map((x) => CarModel.fromJson(x)));

String carModelToJson(List<CarModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarModel {
  CarModel({
    this.id,
    this.carBrand,
    this.model,
    this.startYear,
    this.endYear,
    this.v,
  });

  String id;
  String carBrand;
  String model;
  int startYear;
  int endYear;
  int v;

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        id: json["_id"],
        carBrand: json["CarBrand"],
        model: json["Model"],
        startYear: json["StartYear"],
        endYear: json["EndYear"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "CarBrand": carBrand,
        "Model": model,
        "StartYear": startYear,
        "EndYear": endYear,
        "__v": v,
      };

  static List<CarModel> parseCars(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<CarModel> carList =
        list.map((model) => CarModel.fromJson(model)).toList();
    return carList;
  }
}

// // To parse this JSON data, do
// //
// //     final loadAllCarsInfoForAppModel = loadAllCarsInfoForAppModelFromJson(jsonString);
//
// import 'dart:convert';
// /*
// List<LoadAllCarsInfoForAppModel> loadAllCarsInfoForAppModelFromJson(
//         String str) =>
//     List<LoadAllCarsInfoForAppModel>.from(
//         json.decode(str).map((x) => LoadAllCarsInfoForAppModel.fromJson(x)));
// */
// /*String loadAllCarsInfoForAppModelToJson(
//         List<LoadAllCarsInfoForAppModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));*/
//
// class LoadAllCarsInfoForAppModel {
//   LoadAllCarsInfoForAppModel({
//     this.id,
//     this.carBrand,
//     this.model,
//     this.startYear,
//     this.endYear,
//     this.v,
//   });
//
//   String id;
//   String carBrand;
//   String model;
//   int startYear;
//   int endYear;
//   int v;
//
//   factory LoadAllCarsInfoForAppModel.fromJson(Map<String, dynamic> json) {
//     return new LoadAllCarsInfoForAppModel(
//       id: json["_id"],
//       carBrand: json["CarBrand"],
//       model: json["Model"],
//       startYear: json["StartYear"],
//       endYear: json["EndYear"],
//       v: json["__v"],
//     );
//   }
//
//
//   }
//
//   /*List<dynamic> toJson() => {
//         "_id": id,
//         "CarBrand": carBrand,
//         "Model": model,
//         "StartYear": startYear,
//         "EndYear": endYear,
//         "__v": v,
//       };*/
// }
