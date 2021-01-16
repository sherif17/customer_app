import 'file:///G:/Programming/Projects/Flutter/AndroidStudio/GradProject/customer_app/lib/screens/login_screens/user_register/components/rounded_input_field.dart';
import 'package:customer_app/utils/size_config.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../common_widgets/background.dart';
import 'form_error.dart';
import 'components/or_divider.dart';
import 'register_form.dart';
import 'components/social_buttons.dart';

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
            // SizedBox(height: size.height * 0.00005),
            Text(
              "What's Your Name",
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: RegisterForm()),
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
          ],
        ),
      ),
    );
  }
}
