import 'dart:ui';
import 'package:customer_app/screens/login_screens/otp/phone_verification.dart';
import 'package:customer_app/screens/login_screens/phone_number/phone_form.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';

import 'componants/country_code_field.dart';

class Body extends StatelessWidget {
  String phoneNumber = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.1, left: size.width * 0.03),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Enter Mobile Number:',
                  style: Theme.of(context).textTheme.headline1),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: size.width * 0.05),
            child: Align(
              alignment: Alignment.centerRight,
              child: SvgPicture.asset(
                'assets/illustrations/undraw_confirmed.svg',
                height: size.height * 0.08,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.05, top: size.height * 0.04),
            child: Text(
              'Enter your mobile number ,to create an account or to log in to existing one.',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(
            height: size.height * 0.06,
          ),
          PhoneForm(),
        ],
      ),
    );
  }
}
