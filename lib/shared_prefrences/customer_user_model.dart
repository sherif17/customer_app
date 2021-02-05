import 'package:shared_preferences/shared_preferences.dart';

const String _CURRENT_LANGUAGE = 'currentLanguage';
const String _JWT_TOKEN = 'jwtToken';
const String _FIREBASE_ID = 'fireBaseId';
const String _BACKEND_ID = 'ID';
const String _FIRST_NAME = 'firstName';
const String _LAST_NAME = 'lastName';
const String _PHONE_NUMBER = 'phoneNumber';

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
  return _prefs.getString(_JWT_TOKEN) ?? null;
}

Future<String> setPrefJwtToken(String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(_JWT_TOKEN, value);
}

//////////////////////////////////////////////////////////////
Future<String> getPrefFirebaseID() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(_FIREBASE_ID) ?? null;
}

Future<String> setPrefFirebaseID(String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(_FIREBASE_ID, value);
}

////////////////////////////////////////////////////////////////////
Future<String> getPrefBackendID() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(_BACKEND_ID) ?? null;
}

Future<String> setPrefBackendID(String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(_BACKEND_ID, value);
}

///////////////////////////////////////////////////////////////////////
Future<String> getPrefFirstName() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(_FIRST_NAME) ?? null;
}

Future<String> setPrefFirstName(String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(_FIRST_NAME, value);
}

//////////////////////////////////////////////////////////////////////
Future<String> getPrefLastName() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(_LAST_NAME) ?? null;
}

Future<String> setPrefLastName(String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(_LAST_NAME, value);
}

///////////////////////////////////////////////////////////////////////
Future<String> getPrefPhoneNumber() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString(_PHONE_NUMBER) ?? null;
}

Future<String> setPrefPhoneNumber(String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(_PHONE_NUMBER, value);
}
