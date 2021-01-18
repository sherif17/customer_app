import 'package:customer_app/models/phone_num_model.dart';
import 'package:flutter/material.dart';

class phoneNum {
  PhoneRequestModel phoneRequestModel;
  String phoneNumber;
  String Fname;
  String LName;
  String info;
  ScaffoldState scafoldKey;
  phoneNum(
      {this.phoneNumber,
      this.phoneRequestModel,
      this.Fname,
      this.LName,
      this.info});
}
