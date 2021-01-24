import 'dart:convert';

UserRegisterRequestModel userRegisterRequestModelFromJson(String str) =>
    UserRegisterRequestModel.fromJson(json.decode(str));

String userRegisterRequestModelToJson(UserRegisterRequestModel data) =>
    json.encode(data.toJson());

class UserRegisterRequestModel {
  UserRegisterRequestModel({
    this.token,
    this.firstName,
    this.lastName,
  });

  String token;
  String firstName;
  String lastName;

  factory UserRegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      UserRegisterRequestModel(
        token: json["token"],
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "firstName": firstName,
        "lastName": lastName,
      };
}
// To parse this JSON data, do
//
//     final userRegisterResponseModel = userRegisterResponseModelFromJson(jsonString);

UserRegisterResponseModel userRegisterResponseModelFromJson(String str) =>
    UserRegisterResponseModel.fromJson(json.decode(str));

String userRegisterResponseModelToJson(UserRegisterResponseModel data) =>
    json.encode(data.toJson());

class UserRegisterResponseModel {
  UserRegisterResponseModel({
    this.token,
    this.error,
  });

  String token;
  String error;

  factory UserRegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      UserRegisterResponseModel(
        token: json["token"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "error": error,
      };
}
