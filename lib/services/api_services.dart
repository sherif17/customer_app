import 'package:customer_app/models/phone_num_model.dart';
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
}
