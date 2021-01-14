import 'package:customer_app/screens/onboarding_screens/intro_screens/intro.dart';
import 'package:customer_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'themes/light_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    // TODO: implement build
    return new MaterialApp(
        theme: lightTheme(), initialRoute: Intro.routeName, routes: routes);
  }
}
