import 'package:customer_app/local_db/customer_info_db.dart';
import 'package:customer_app/localization/localization_constants.dart';
import 'package:customer_app/screens/login_screens/confirm_user/confirm_is_that_user.dart';
import 'package:customer_app/screens/login_screens/otp/otp_form.dart';
import 'package:customer_app/screens/login_screens/phone_number/componants/phone_number.dart';
import 'package:customer_app/screens/login_screens/phone_number/enter_phone_number.dart';
import 'package:customer_app/screens/login_screens/user_register/register_new_user.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String currentLang=loadCurrentLangFromDB();

  @override
  void initState() {
    super.initState();
   // getCurrentPrefData();
  }

  void getCurrentPrefData() {
    getPrefCurrentLang().then((value) {
      setState(() {
        currentLang = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    phoneNum response = ModalRoute.of(context).settings.arguments;
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.1),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.01, right: size.height * 0.01),
              child: Align(
                alignment: currentLang == "en"
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    getTranslated(context, "Verify This Mobile  Number"),
                    style: Theme.of(context).textTheme.headline1,
                    textAlign:
                        currentLang == "en" ? TextAlign.left : TextAlign.right,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.only(
                  right: size.width * 0.05, left: size.width * 0.05),
              child: Align(
                alignment: currentLang == "en"
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: SvgPicture.asset(
                  'assets/illustrations/undraw_confirmed.svg',
                  height: size.height * 0.08,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.02, right: size.height * 0.02),
              child: Align(
                alignment: currentLang == "en"
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Row(
                    children: [
                      Text(
                        getTranslated(context, "We sent your code via SMS to"),
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        currentLang == "en"
                            ? "+20-${response.phoneNumber}."
                            : "20-${response.phoneNumber}+",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: Row(
                children: [
                  Align(
                    alignment: currentLang == "en"
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Text(
                      getTranslated(context, "Please enter this code here"),
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context,
                          EnterPhoneNumber.routeName, (route) => false);
                    },
                    child: Text(
                      getTranslated(context, "Edit number"),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ],
              ),
            ),
            //SizedBox(height: size.height * 0.01),
            OtpForm(
                phoneRequestModel: response.phoneRequestModel,
                phone_num: response.phoneNumber,
                scafoldKey: response.scafoldKey),
            // SizedBox(height: size.height * 0.01),
            //buildTimer(),
            //SizedBox(height: size.height * 0.06),
          ],
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(getTranslated(context, "Resend Code")),
        TweenAnimationBuilder(
          tween: Tween(begin: 60.0, end: 0.0),
          duration: Duration(seconds: 60),
          builder: (context, value, child) => Text(
            "00:${value.toInt()}",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          onEnd: () {},
        ),
      ],
    );
  }
}
