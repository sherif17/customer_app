// To parse this JSON data, do
//
//     final repairsAssignedByMechanicResponseModel = repairsAssignedByMechanicResponseModelFromJson(jsonString);

import 'dart:convert';

RepairsAssignedByMechanicResponseModel
    repairsAssignedByMechanicResponseModelFromJson(String str) =>
        RepairsAssignedByMechanicResponseModel.fromJson(json.decode(str));

String repairsAssignedByMechanicResponseModelToJson(
        RepairsAssignedByMechanicResponseModel data) =>
    json.encode(data.toJson());

class RepairsAssignedByMechanicResponseModel {
  RepairsAssignedByMechanicResponseModel({
    this.repairsToBeMade,
  });

  List<RepairsToBeMade> repairsToBeMade;

  factory RepairsAssignedByMechanicResponseModel.fromJson(
          Map<String, dynamic> json) =>
      RepairsAssignedByMechanicResponseModel(
        repairsToBeMade: List<RepairsToBeMade>.from(
            json["Repairs to be made"].map((x) => RepairsToBeMade.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Repairs to be made":
            List<dynamic>.from(repairsToBeMade.map((x) => x.toJson())),
      };
}

class RepairsToBeMade {
  RepairsToBeMade({
    this.repairkind,
    this.repairitself,
    this.repairNumber,
  });

  String repairkind;
  Repairitself repairitself;
  String repairNumber;

  factory RepairsToBeMade.fromJson(Map<String, dynamic> json) =>
      RepairsToBeMade(
        repairkind: json["Repairkind"],
        repairitself: Repairitself.fromJson(json["Repairitself"]),
        repairNumber: json["RepairNumber"],
      );

  Map<String, dynamic> toJson() => {
        "Repairkind": repairkind,
        "Repairitself": repairitself.toJson(),
        "RepairNumber": repairNumber,
      };
}

class Repairitself {
  Repairitself({
    this.id,
    this.category,
    this.itemDesc,
    this.price,
    this.v,
    this.serviceDesc,
    this.expectedFare,
  });

  String id;
  String category;
  String itemDesc;
  int price;
  int v;
  String serviceDesc;
  int expectedFare;

  factory Repairitself.fromJson(Map<String, dynamic> json) => Repairitself(
        id: json["_id"],
        category: json["Category"],
        itemDesc: json["ItemDesc"] == null ? null : json["ItemDesc"],
        price: json["Price"] == null ? null : json["Price"],
        v: json["__v"],
        serviceDesc: json["ServiceDesc"] == null ? null : json["ServiceDesc"],
        expectedFare:
            json["ExpectedFare"] == null ? null : json["ExpectedFare"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Category": category,
        "ItemDesc": itemDesc == null ? null : itemDesc,
        "Price": price == null ? null : price,
        "__v": v,
        "ServiceDesc": serviceDesc == null ? null : serviceDesc,
        "ExpectedFare": expectedFare == null ? null : expectedFare,
      };
}
