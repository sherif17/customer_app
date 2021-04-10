import 'package:shared_preferences/shared_preferences.dart';

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

///////////////////////////////////////////////////////
Future<String> getPrefCurrentLang() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(_CURRENT_LANGUAGE) ?? "en";
}

Future<String> setPrefCurrentLang(String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(_CURRENT_LANGUAGE, value);
}

//////////////////////////////////////////////////////////////////
Future<String> getPrefJwtToken() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(_JWT_TOKEN) ?? "";
}

Future<String> setPrefJwtToken(String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(_JWT_TOKEN, value);
}

//////////////////////////////////////////////////////////////
Future<String> getPrefFirebaseID() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(_FIREBASE_ID) ?? "";
}

Future<String> setPrefFirebaseID(String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(_FIREBASE_ID, value);
}

////////////////////////////////////////////////////////////////////
Future<String> getPrefBackendID() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(_BACKEND_ID) ?? "";
}

Future<String> setPrefBackendID(String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(_BACKEND_ID, value);
}

///////////////////////////////////////////////////////////////////////
Future<String> getPrefFirstName() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(_FIRST_NAME) ?? "";
}

Future<String> setPrefFirstName(String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(_FIRST_NAME, value);
}

//////////////////////////////////////////////////////////////////////
Future<String> getPrefLastName() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(_LAST_NAME) ?? "";
}

Future<String> setPrefLastName(String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(_LAST_NAME, value);
}

///////////////////////////////////////////////////////////////////////
Future<String> getPrefPhoneNumber() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(_PHONE_NUMBER) ?? "";
}

Future<String> setPrefPhoneNumber(String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(_PHONE_NUMBER, value);
}

/////////////////////////////////////////////////////////////////////
Future<String> getPrefIAT() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(_IAT) ?? "";
}

Future<String> setPrefIAT(String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(_IAT, value);
}

loadPrefIAT() async {
  return getPrefIAT();
}

///////////////////////////////////////////////////////
Future<String> getPrefSocialImage() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(_SOCIAL_IMAGE) ?? "";
}

Future<String> setPrefSocialImage(String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(_SOCIAL_IMAGE, value);
}

loadPrefGoogleImage() async {
  return getPrefSocialImage();
}

///////////////////////////////////////////////////////
Future<String> getPrefSocialEmail() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(_SOCIAL_EMAIL) ?? "";
}

Future<String> setPrefSocialEmail(String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(_SOCIAL_EMAIL, value);
}

loadPrefGoogleEmail() async {
  return getPrefSocialEmail();
}

/////////////////////////////////////////////////////////////////
printAllUserCurrentData() async {
  print("_CURRENT_LANGUAGE : ${await getPrefCurrentLang()}");
  print("_JWT_TOKEN : ${await getPrefJwtToken()}");
  print("_FIREBASE_ID : ${await getPrefFirebaseID()}");
  print("_BACKEND_ID : ${await getPrefBackendID()}");
  print("_FIRST_NAME : ${await getPrefFirstName()}");
  print("_LAST_NAME : ${await getPrefLastName()}");
  print("_PHONE_NUMBER : ${await getPrefPhoneNumber()}");
  print("_IAT : ${await getPrefIAT()}");
  print("_GOOGLE_IMAGE : ${await getPrefSocialImage()}");
  print("_GOOGLE_EMAIL : ${await getPrefSocialEmail()}");
}

///////////////////////////////////////////
resetAllUserCurrentData() {
  setPrefBackendID("");
  setPrefJwtToken("");
  setPrefFirebaseID("");
  setPrefIAT("");
  setPrefFirstName("");
  setPrefLastName("");
  setPrefPhoneNumber("");
  setPrefSocialEmail("");
  setPrefSocialImage("");
}
