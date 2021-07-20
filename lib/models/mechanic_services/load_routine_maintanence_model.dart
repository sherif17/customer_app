// To parse this JSON data, do
//
//     final loadRoutineMaintenanceModel = loadRoutineMaintenanceModelFromJson(jsonString);

import 'dart:convert';

List<LoadRoutineMaintenanceModel> loadRoutineMaintenanceModelFromJson(
        String str) =>
    List<LoadRoutineMaintenanceModel>.from(
        json.decode(str).map((x) => LoadRoutineMaintenanceModel.fromJson(x)));

String loadRoutineMaintenanceModelToJson(
        List<LoadRoutineMaintenanceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoadRoutineMaintenanceModel {
  LoadRoutineMaintenanceModel(
      {this.id,
      this.category,
      this.serviceDesc,
      this.expectedFare,
      this.v,
      this.isChecked = false});

  String id;
  String category;
  String serviceDesc;
  int expectedFare;
  int v;
  bool isChecked;

  factory LoadRoutineMaintenanceModel.fromJson(Map<String, dynamic> json) =>
      LoadRoutineMaintenanceModel(
        id: json["_id"],
        category: json["Category"],
        serviceDesc: json["ServiceDesc"],
        expectedFare: json["ExpectedFare"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Category": category,
        "ServiceDesc": serviceDesc,
        "ExpectedFare": expectedFare,
        "__v": v,
      };

  static List<LoadRoutineMaintenanceModel> parseRoutineMaintenance(
      String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<LoadRoutineMaintenanceModel> routineMaintenanceList = list
        .map((model) => LoadRoutineMaintenanceModel.fromJson(model))
        .toList();
    return routineMaintenanceList;
  }
}
