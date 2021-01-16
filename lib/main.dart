import 'package:customer_app/screens/login_screens/phone_number/enter_phone_number.dart';
import 'package:customer_app/screens/login_screens/user_register/register_new_user.dart';
import 'package:customer_app/screens/onboarding_screens/intro_screens/intro.dart';
import 'package:customer_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'themes/light_theme.dart';
import 'package:customer_app/screens/login_screens/confirm_user/confirm_is_that_user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    // TODO: implement build
    return new MaterialApp(
        //theme: lightTheme(), initialRoute: ConfirmThisUser.routeName, routes: routes);
        theme: lightTheme(),
        initialRoute: Intro.routeName,
        routes: routes);
  }
}
