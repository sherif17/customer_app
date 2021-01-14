import 'package:customer_app/screens/login_screens/confirm_user/confirm_is_that_user.dart';
import 'package:customer_app/screens/login_screens/otp/otp_form.dart';
import 'package:customer_app/screens/login_screens/user_register/register_new_user.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  final bool islogin = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "Verify This Mobile  Number",
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Column(
            children: [
              Text(
                "Enter the pin you have received Via SMS on+02xx-xxx-xxx-xx.",
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.left,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/PhoneNumber');
                },
                child: Text(
                  "Edit number",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.03),
          buildTimer(),
          OtpForm(),
          RoundedButton(
            text: "Verify",
            color: Theme.of(context).accentColor,
            press: () {
              islogin
                  ? Navigator.pushNamed(context, ConfirmThisUser.routeName)
                  : Navigator.pushNamed(context, RegisterNewUser.routeName);
            },
          )
        ],
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code Will Expire in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (context, value, child) => Text(
            "00:${value.toInt()}",
            style: Theme.of(context).textTheme.headline4,
          ),
          onEnd: () {},
        ),
      ],
    );
  }
}
