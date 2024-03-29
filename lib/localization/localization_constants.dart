import 'package:customer_app/local_db/customer_db/customer_info_db.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:flutter/material.dart';
import 'demo_localization.dart';

String getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context).getTranslatedValue(key);
}

//languages code
const String ENGLISH = 'en';
const String ARABIC = 'ar';

Future<Locale> setLocale(String languageCode) async {
  setPrefCurrentLang(languageCode);
  saveCurrentLangInDB(languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  String languageCode = await getPrefCurrentLang();
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale _temp;
  switch (languageCode) {
    case ENGLISH:
      _temp = Locale(languageCode, 'US');
      break;
    case ARABIC:
      _temp = Locale(languageCode, 'EG');
      break;
    default:
      _temp = Locale(languageCode, 'US');
  }
  return _temp;
}
