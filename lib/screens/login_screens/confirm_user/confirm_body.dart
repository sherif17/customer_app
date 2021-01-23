import 'package:customer_app/screens/home_screen/home.dart';
import 'package:customer_app/screens/login_screens/common_widgets/background.dart';
import 'package:customer_app/screens/login_screens/confirm_user/user_avatar.dart';
import 'package:customer_app/screens/login_screens/phone_number/enter_phone_number.dart';
import 'package:customer_app/widgets/borderd_buttons.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import 'confirm_user_form.dart';

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
              color: Theme.of(context).primaryColor,
              press: () {
                Navigator.pushNamed(context, HomeScreen.routeName);
              }),
          Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
            child: borderedRoundedButton(
                text: 'No, Edit Info',
                CornerRadius: 10,
                press: () {
                  _showModalBottomSheet(context, size.height * 0.5);
                }),
          )
        ],
      ),
    );
  }

  _showModalBottomSheet(context, size) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          height: size,
          /*padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),*/
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ConfirmUserForm(),
        ),
      ),
    );
  }
}
