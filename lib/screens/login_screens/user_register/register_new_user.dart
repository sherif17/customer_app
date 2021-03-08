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
          'Register New User',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Theme.of(context).primaryColorDark),
        ),
      ),
      body: //Text("hi")
          Body(),
    );
  }
}
// Helped Resources https://youtu.be/ExKYjqgswJg
