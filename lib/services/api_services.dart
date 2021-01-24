import 'package:customer_app/models/phone_num_model.dart';
import 'package:customer_app/models/user_register_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  Future<PhoneResponseModel> phoneCheck(
      PhoneRequestModel phoneRequestModel) async {
    String url = 'http://161.97.155.244/api/registeration/customer';
    final response = await http.post(url,
        //headers: {"Content-Type": "application/json; charset=utf-8"},
        body: phoneRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return PhoneResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to load Data");
    }
  }

  Future<UserRegisterResponseModel> registerUser(
      UserRegisterRequestModel userRegisterRequestModel) async {
    String url = 'http://161.97.155.244/api/customer/me/updateprofile';
    final response = await http.post(url,
        headers: {"Content-Type": userRegisterRequestModel.token},
        body: userRegisterRequestModel.toJson());
    if (response.statusCode == 200) {
      return UserRegisterResponseModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      return UserRegisterResponseModel.fromJson(json.decode(response.body));
    }
  }
}
