import 'package:customer_app/screens/home_screen/home.dart';
import 'package:customer_app/screens/login_screens/confirm_user/confirm_is_that_user.dart';
import 'package:customer_app/screens/login_screens/otp/phone_verification.dart';
import 'package:customer_app/screens/login_screens/phone_number/enter_phone_number.dart';
import 'package:customer_app/screens/login_screens/user_register/register_new_user.dart';
import 'package:customer_app/screens/onboarding_screens/intro_screens/intro.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  Intro.routeName: (context) => Intro(),
  EnterPhoneNumber.routeName: (context) => EnterPhoneNumber(),
  VerifyPhoneNumber.routeName: (context) => VerifyPhoneNumber(),
  ConfirmThisUser.routeName: (context) => ConfirmThisUser(),
  RegisterNewUser.routeName: (context) => RegisterNewUser(),
  HomeScreen.routeName: (context) => HomeScreen(),
};
