import 'package:customer_app/localization/localization_constants.dart';
import 'package:customer_app/screens/login_screens/user_register/register_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterNewUser extends StatelessWidget {
  static String routeName = '/RegisterNewUser';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          getTranslated(context, "Register New customer"),
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).primaryColorDark),
        ),
      ),
      body: //Text("hi")
          Body(),
    );
  }
}
// Helped Resources https://youtu.be/ExKYjqgswJg
