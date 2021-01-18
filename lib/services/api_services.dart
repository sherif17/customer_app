import 'package:customer_app/models/phone_num_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  Future<PhoneResponseModel> phoneCheck(
      PhoneRequestModel phoneRequestModel) async {
    String url = 'http://161.97.155.244/api/registeration/customer';
    final reponse = await http.post(url, body: phoneRequestModel.toJson());
    if (reponse.statusCode == 200 || reponse.statusCode == 400) {
      return PhoneResponseModel.fromJson(json.decode(reponse.body));
    } else {
      throw Exception("failed to load Data");
    }
  }
}
