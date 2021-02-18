import 'dart:convert';
import 'package:customer_app/models/cars/add_new_car_model.dart';
import 'package:customer_app/models/cars/app_cars_model.dart';
import 'package:http/http.dart' as http;

class CarApiService {
  Future<List<CarModel>> loadCarsData() async {
    //Load All Car Blocks from Backend
    String url = 'http://161.97.155.244/api/info/allcars';
    final response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return CarModel.parseCars(response.body);
    } else {
      throw Exception("failed to load Data");
    }
  }

  Future<AddNewCarResponseModel> addUserNewCar(
      AddNewCarRequestModel addNewCarRequestModel, token) async {
    String url = 'http://161.97.155.244/api/customer/me/car';
    final response = await http.post(url,
        headers: {"x-auth-token": "$token"},
        body: addNewCarRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return AddNewCarResponseModel.fromJson(json.decode(response.body));
    }
  }
}
