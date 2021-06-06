import 'package:customer_app/local_db/customer_db/cutomer_owned_cars_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

const String _CURRENT_LANGUAGE = 'currentLanguage';
const String _JWT_TOKEN = 'jwtToken';
const String _FIREBASE_ID = 'fireBaseId';
const String _BACKEND_ID = 'ID';
const String _FIRST_NAME = 'firstName';
const String _LAST_NAME = 'lastName';
const String _PHONE_NUMBER = 'phoneNumber';
const String _IAT = 'iat';
const String _SOCIAL_IMAGE = 'socialImage';
const String _SOCIAL_EMAIL = 'socialEmail';

Box customerInfo = Hive.box<String>("customerInfoDBBox");

saveCurrentLangInDB(String lang) {
  customerInfo.put(_CURRENT_LANGUAGE, lang);
}

String loadCurrentLangFromDB() {
  return customerInfo.get(_CURRENT_LANGUAGE, defaultValue: "en");
}

////////////////////////////////////////////////////////////////////////
saveJwtTokenInDB(String jwt) {
  customerInfo.put(_JWT_TOKEN, jwt);
}

String loadJwtTokenFromDB() {
  return customerInfo.get(_JWT_TOKEN, defaultValue: "");
}

///////////////////////////////////////////////////////////////////////////
saveFirebaseIDInDB(String fireID) {
  customerInfo.put(_FIREBASE_ID, fireID);
}

String loadFirebaseFromDB() {
  return customerInfo.get(_FIREBASE_ID, defaultValue: "");
}

////////////////////////////////////////////////////////////////////////////
saveBackendIBInDB(String backID) {
  customerInfo.put(_BACKEND_ID, backID);
}

String loadBackendIDFromDB() {
  return customerInfo.get(_BACKEND_ID, defaultValue: "");
}

////////////////////////////////////////////////////////////////////////////
saveFirstNameInDB(String fName) {
  customerInfo.put(_FIRST_NAME, fName);
}

String loadFirstNameFromDB() {
  return customerInfo.get(_FIRST_NAME, defaultValue: "");
}

/////////////////////////////////////////////////////////////////////////
saveLastNameInDB(String lName) {
  customerInfo.put(_LAST_NAME, lName);
}

String loadLastNameFromDB() {
  return customerInfo.get(_LAST_NAME, defaultValue: "");
}

/////////////////////////////////////////////////////////////////////
savePhoneNumberInDB(String phone) {
  customerInfo.put(_PHONE_NUMBER, phone);
}

String loadPhoneNumberFromDB() {
  return customerInfo.get(_PHONE_NUMBER, defaultValue: "");
}

//////////////////////////////////////////////////////////////////////
saveIATInDB(String iat) {
  customerInfo.put(_IAT, iat);
}

String loadIATFromDB() {
  return customerInfo.get(_IAT, defaultValue: "");
}

///////////////////////////////////////////////////////////////////////
saveSocialImageInDB(String url) {
  customerInfo.put(_SOCIAL_IMAGE, url);
}

String loadSocialImageFromDB() {
  return customerInfo.get(_SOCIAL_IMAGE, defaultValue: "");
}

////////////////////////////////////////////////////////////////////
saveSocialEmailInDB(String email) {
  customerInfo.put(_SOCIAL_EMAIL, email);
}

String loadSocialEmailFromDB() {
  return customerInfo.get(_SOCIAL_EMAIL, defaultValue: "");
}

/////////////////////////////////////////////////////////////////
printAllCustomerSavedInfoInDB() {
  print("_CURRENT_LANGUAGE : ${loadCurrentLangFromDB()}");
  print("_JWT_TOKEN : ${loadJwtTokenFromDB()}");
  print("_FIREBASE_ID : ${loadFirebaseFromDB()}");
  print("_BACKEND_ID : ${loadBackendIDFromDB()}");
  print("_FIRST_NAME : ${loadFirstNameFromDB()}");
  print("_LAST_NAME : ${loadLastNameFromDB()}");
  print("_PHONE_NUMBER : ${loadPhoneNumberFromDB()}");
  print("_IAT : ${loadIATFromDB()}");
  print("_SOCIAL_IMAGE : ${loadSocialImageFromDB()}");
  print("_SOCIAL_EMAIL : ${loadSocialEmailFromDB()}");
}

resetAllCustomerSavedInfoInDB() {
  customerInfo.clear();
  Hive.box<customerOwnedCarsDB>("customerCarsDBBox").clear();
}
