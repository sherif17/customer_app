import 'dart:ui';
import 'package:customer_app/screens/login_screens/otp/phone_verification.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import 'componants/country_code_field.dart';
import 'componants/phone_input_field.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.1, left: size.width * 0.03),
            child: Text('Enter Your Phone Number below:',
                style: Theme.of(context).textTheme.headline1),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.05, top: size.height * 0.02),
            child: Text(
              'Enter your mobile number ,to create an account or to log in to your existing one.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(
            height: size.height * 0.06,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: CountryCode(
                      radius: 10,
                      borderColor: Theme.of(context).primaryColor,
                      width: 20,
                    )),
                Expanded(
                  flex: 8,
                  child: PhoneInputField(
                    type: TextInputType.phone,
                    hint: 'Your Phone Number',
                    radius: 10,
                    borderColor: Theme.of(context).primaryColor,
                    width: 30,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.2,
            ),
            child: RoundedButton(
              text: "Continue",
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).accentColor,
              press: () {
                Navigator.pushNamed(context, VerifyPhoneNumber.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
