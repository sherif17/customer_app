//try to use colors from this file ,instead of  using theme.
import 'package:customer_app/utils/size_config.dart';
import 'package:flutter/material.dart';

const animationDuration = Duration(microseconds: 2000);

//form Error
const String NullPhoneNumberError = "Please Enter Your Phone Number";
const String SmallPhoneNumberError =
    "This Number is too short to be Phone number";

const String NullFirstNameError = "Please Enter Your First Name";
const String InvalidFirstNameError = "Please Valid First Name";
const String SmallFirstNameError = " Entered First Name is too Short";

const String NullLastNameError = "Please Enter Your Last Name";
const String InvalidLastNameError = "Please Valid Last Name";
const String SmallLastNameError = " Entered Last Name is too Short";

final otpInputDecoration = InputDecoration(
  counterText: '',
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: Color(0xFF470000)),
  );
}
