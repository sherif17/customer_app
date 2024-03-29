import 'package:customer_app/lang/language_list.dart';
import 'package:customer_app/localization/localization_constants.dart';
import 'package:customer_app/main.dart';
import 'package:customer_app/screens/onboarding_screens/intro_screens/intro_body.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:customer_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Intro extends StatefulWidget {
  static String routeName = '/intro';
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  void _changeLanguage(Language language) async {
    Locale _temp = await setLocale(language.languageCode);
    print("current lang: ${await getPrefCurrentLang()}");
    MyApp.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildLangDropdown(),
          ),
        ],
        // title: Align(
        //   alignment: Alignment.bottomLeft,
        //   child: Text(
        //     getTranslated(context, "Mechawinch"),
        //     style: Theme.of(context).textTheme.headline1,
        //     /*style: TextStyle(
        //             fontSize: getProportionateScreenWidth(30),
        //             color: Theme.of(context).primaryColor,
        //           ),*/
        //   ),
        // ),
      ),
      body: IntroBody(),
    );
  }

  DropdownButton<Language> buildLangDropdown() {
    return DropdownButton(
      underline: SizedBox(),
      icon: Icon(
        Icons.language,
        color: Colors.redAccent,
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
}
