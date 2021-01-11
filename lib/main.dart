import 'package:flutter/material.dart';
import 'screens/login_screens/phone_number/enter_phone_number.dart';
import 'screens/login_screens/confirm_user/confirm_is_that_user.dart';
import 'screens/login_screens/otp/phone_verification.dart';
import 'screens/login_screens/user_register/register_new_user.dart';
import 'themes/light_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    // TODO: implement build
    return new MaterialApp(
        theme: lightTheme(),
        //home: EnterPhoneNumber(),
        initialRoute: '/PhoneNumber',
        routes: {
          '/PhoneNumber': (context) => EnterPhoneNumber(),
          '/PhoneVerification': (context) => VerifyPhoneNumber(),
          '/ConfirmThatUser': (context) => ConfirmThisUser(),
          '/RegisterNewUser': (context) => RegisterNewUser(),
        });
  }
}
