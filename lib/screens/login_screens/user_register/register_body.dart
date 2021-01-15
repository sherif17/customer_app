import 'package:customer_app/screens/login_screens/user_register/rounded_input_field.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import '../common_widgets/background.dart';
import 'or_divider.dart';
import 'social_buttons.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        child: Column(
          children: <Widget>[
            SizedBox(height: size.height * 0.01),
            Text(
              "What's Your Name",
            ),
            SizedBox(height: size.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RoundedInputField(
                  hintText: 'First Name',
                  onChanged: (value) {},
                ),
                RoundedInputField(hintText: 'Last Name', onChanged: (value) {}),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            OrDivider(),
            SizedBox(height: size.height * 0.02),
            SocialRoundedButton(
              text: 'Continue with Facebook',
              iconSrc: 'assets/icons/facebook.svg',
              press: () {},
            ),
            SizedBox(height: size.height * 0.02),
            SocialRoundedButton(
              text: 'Continue with Google',
              iconSrc: 'assets/icons/gmail_logo.svg',
              press: () {},
            ),
            SizedBox(height: size.height * 0.02),
            SocialRoundedButton(
              text: 'Continue with Apple ID',
              iconSrc: 'assets/icons/apple.svg',
              press: () {},
            ),
            SizedBox(height: size.height * 0.02),
            RoundedButton(
              text: 'Create Account',
              color: Theme.of(context).primaryColor,
              press: () {
                Navigator.of(context).pushNamed('/HomeScreen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
