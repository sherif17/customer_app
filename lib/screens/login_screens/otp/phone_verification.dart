import 'package:customer_app/screens/login_screens/otp/otp_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VerifyPhoneNumber extends StatelessWidget {
  static String routeName = '/PhoneVerification';
  final scafoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scafoldKey,
      body: Body(),
    );
  }
}
// Helped Resources :https://youtu.be/iZqxIvlzXVw
