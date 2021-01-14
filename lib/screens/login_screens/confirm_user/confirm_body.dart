import 'package:customer_app/screens/home_screen/home.dart';
import 'package:customer_app/screens/login_screens/common_widgets/background.dart';
import 'package:customer_app/screens/login_screens/confirm_user/user_avatar.dart';
import 'package:customer_app/screens/login_screens/phone_number/enter_phone_number.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("First Name , Is That You"),
          UserAvatar(size: size),
          Text("First Last"),
          RoundedButton(
              text: 'Yes, its Me',
              color: Theme.of(context).accentColor,
              press: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              }),
          RoundedButton(
              text: 'No, Edit Info',
              color: Theme.of(context).accentColor,
              press: () {
                Navigator.pushNamed(context, EnterPhoneNumber.routeName);
              })
        ],
      ),
    );
  }
}
