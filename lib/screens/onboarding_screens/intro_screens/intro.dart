import 'package:customer_app/screens/onboarding_screens/intro_screens/intro_body.dart';
import 'package:customer_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class Intro extends StatelessWidget {
  static String routeName = '/intro';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: IntroBody(),
    );
  }
}
