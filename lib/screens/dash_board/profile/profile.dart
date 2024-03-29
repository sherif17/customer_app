import 'package:customer_app/lang/language_list.dart';
import 'package:customer_app/local_db/customer_db/customer_info_db.dart';
import 'package:customer_app/localization/localization_constants.dart';
import 'package:customer_app/main.dart';
import 'package:customer_app/screens/dash_board/profile/profile_body.dart';
import 'package:customer_app/screens/onboarding_screens/intro_screens/intro.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          getTranslated(context, "Profile"),
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () {
            Widget cancelButton = FlatButton(
              child: Text(getTranslated(context, "Stay")),
              onPressed: () {
                Navigator.pop(context);
              },
            );
            Widget continueButton = FlatButton(
              child: Text(getTranslated(context, "Leave")),
              onPressed: () {
                resetAllUserCurrentData();
                resetAllCustomerSavedInfoInDB();
                Navigator.pushNamedAndRemoveUntil(
                    context, Intro.routeName, (route) => false);
              },
            );

            // set up the AlertDialog
            AlertDialog alert = AlertDialog(
              title: Text(getTranslated(context, "Logout")),
              content: Text(getTranslated(
                  context, "Are you sure that you want to leave our app?")),
              actions: [
                cancelButton,
                continueButton,
              ],
              backgroundColor: Colors.white,
            );
            // show the dialog
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return alert;
              },
            );
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildLangDropdown(),
          ),
        ],
      ),
      body: ProfileBody(),
    );
  }

  DropdownButton<Language> buildLangDropdown() {
    return DropdownButton(
      underline: SizedBox(),
      icon: Icon(
        Icons.language,
        color: Colors.white,
      ),
      onChanged: (Language language) {
        _changeLanguage(language);
      },
      items: Language.languageList()
          .map<DropdownMenuItem<Language>>(
            (lang) => DropdownMenuItem(
              value: lang,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    lang.flag,
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(lang.name)
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  void _changeLanguage(Language language) async {
    Locale _temp = await setLocale(language.languageCode);
    print("current lang: ${await getPrefCurrentLang()}");
    print(loadCurrentLangFromDB());
    MyApp.setLocale(context, _temp);
  }
}
