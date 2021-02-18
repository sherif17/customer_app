import 'package:customer_app/DataHandler/appData.dart';
import 'package:customer_app/models/cars/app_cars_model.dart';
import 'package:flutter/foundation.dart';
import 'file:///G:/Programming/Projects/Flutter/AndroidStudio/GradProject/customer_app_1/lib/models/maps/direction_details.dart';
import 'file:///G:/Programming/Projects/Flutter/AndroidStudio/GradProject/customer_app_1/lib/models/user_register/phone_num_model.dart';
import 'file:///G:/Programming/Projects/Flutter/AndroidStudio/GradProject/customer_app_1/lib/models/user_register/user_register_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'file:///G:/Programming/Projects/Flutter/AndroidStudio/GradProject/customer_app_1/lib/models/maps/address.dart';
import 'package:customer_app/screens/to_winch/to_winch_map.dart';
import 'package:customer_app/services/RequestAssistant.dart';
import 'package:provider/provider.dart';

class ApiService {
  Future<PhoneResponseModel> phoneCheck(
      PhoneRequestModel phoneRequestModel) async {
    String url = 'http://161.97.155.244/api/registeration/customer';
    final response = await http.post(url,
        headers: {'charset': 'utf-8'}, body: phoneRequestModel.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return PhoneResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("failed to load Data");
    }
  }

  Future<UserRegisterResponseModel> registerUser(
      UserRegisterRequestModel userRegisterRequestModel, token) async {
    String url = 'http://161.97.155.244/api/customer/me/updateprofile';
    final response = await http.post(url,
        headers: {"x-auth-token": "$token"},
        body: userRegisterRequestModel.toJson());
    if (response.statusCode == 200) {
      return UserRegisterResponseModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400)
      return UserRegisterResponseModel.fromJson(json.decode(response.body));
  }

  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    String mapKey = "AIzaSyAbT3_43qH7mG81Ufy4xS-GbqDjo9rrPAU";
    String placeAddress = "";
    String st1, st2, st3, st4;
    //String url = 'https//maps.googleapis.com/maps/api/geocode/json?lating-${position.latitude},${position.longitude}&key-$mapKey';
    String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey';
    var response = await RequestAssistant.getRequest(url);
    if (response != "failed") {
      //placeAddress = response["results"][0]["formatted_address"];
      st1 = response["results"][0]["address_components"][0]["long_name"];
      st2 = response["results"][0]["address_components"][1]["long_name"];
      st3 = response["results"][0]["address_components"][2]["long_name"];
      st4 = response["results"][0]["address_components"][3]["long_name"];
      placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;

      Address userPickupAddress = new Address();
      userPickupAddress.longitude = position.longitude;
      userPickupAddress.latitude = position.latitude;
      userPickupAddress.placeName = placeAddress;

      Provider.of<AppData>(context, listen: false)
          .updatePickUpLocationAddress(userPickupAddress);
    }
    return placeAddress;
  }

  static Future<DirectionDetails> obtainPlaceDirectionDetails(
      LatLng initialPosition, LatLng finalPosition) async {
    String mapKey = "AIzaSyAbT3_43qH7mG81Ufy4xS-GbqDjo9rrPAU";
    String directionUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$mapKey";

    var res = await RequestAssistant.getRequest(directionUrl);

    if (res == "failed") {
      return null;
    }

    DirectionDetails directionsDetails = DirectionDetails();

    directionsDetails.encodedPoints =
        res["routes"][0]["overview_polyline"]["points"];
    directionsDetails.distanceText =
        res["routes"][0]["legs"][0]["distance"]["text"];
    directionsDetails.distanceValue =
        res["routes"][0]["legs"][0]["distance"]["value"];
    directionsDetails.durationText =
        res["routes"][0]["legs"][0]["duration"]["text"];
    directionsDetails.durationValue =
        res["routes"][0]["legs"][0]["duration"]["value"];

    return directionsDetails;
  }
}
