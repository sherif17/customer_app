// To parse this JSON data, do
//
//     final loadBreakDownModel = loadBreakDownModelFromJson(jsonString);

import 'dart:convert';

List<LoadBreakDownModel> loadBreakDownModelFromJson(String str) =>
    List<LoadBreakDownModel>.from(
        json.decode(str).map((x) => LoadBreakDownModel.fromJson(x)));

String loadBreakDownModelToJson(List<LoadBreakDownModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoadBreakDownModel {
  LoadBreakDownModel({
    this.id,
    this.category,
    this.problem,
    this.subproblem,
    this.expectedFare,
    this.v,
    this.isChecked = false,
  });

  String id;
  String category;
  String problem;
  String subproblem;
  int expectedFare;
  int v;
  bool isChecked;

  factory LoadBreakDownModel.fromJson(Map<String, dynamic> json) =>
      LoadBreakDownModel(
        id: json["_id"],
        category: json["Category"],
        problem: json["Problem"],
        subproblem: json["Subproblem"] == null ? null : json["Subproblem"],
        expectedFare:
            json["ExpectedFare"] == null ? null : json["ExpectedFare"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Category": category,
        "Problem": problem,
        "Subproblem": subproblem == null ? null : subproblem,
        "ExpectedFare": expectedFare == null ? null : expectedFare,
        "__v": v,
      };

  static List<LoadBreakDownModel> parseBreakDowns(String responseBody) {
    var list = json.decode(responseBody) as List<dynamic>;
    List<LoadBreakDownModel> breakDownList =
        list.map((model) => LoadBreakDownModel.fromJson(model)).toList();
    return breakDownList;
  }
}
