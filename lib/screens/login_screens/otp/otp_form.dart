import 'package:customer_app/screens/login_screens/confirm_user/confirm_is_that_user.dart';
import 'package:customer_app/screens/login_screens/phone_number/componants/phone_number.dart';
import 'package:customer_app/utils/constants.dart';
import 'package:customer_app/utils/size_config.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'componants/otp_code_field.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _pinKey = GlobalKey<ScaffoldState>();
  final _pinKey_two = GlobalKey<FormState>();

  String pin1;
  String pin2;
  String pin3;
  String pin4;
  String pin5;
  String pin6;

  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;
  String _verificationCode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
    _verifyPhone();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _pinKey_two,
      child: Column(
        children: [
          SizedBox(height: size.height * 0.08),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(45),
                  child: TextFormField(
                    autofocus: true,
                    obscureText: false,
                    style: TextStyle(fontSize: 27, color: Color(0xFFBD4242)),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: otpInputDecoration,
                    onChanged: (value) {
                      nextField(value, pin2FocusNode);
                    },
                    onSaved: (newValue) => pin1 = newValue,
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(45),
                  child: TextFormField(
                    focusNode: pin2FocusNode,
                    obscureText: false,
                    style: TextStyle(fontSize: 27, color: Color(0xFFBD4242)),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: otpInputDecoration,
                    onChanged: (value) => nextField(value, pin3FocusNode),
                    onSaved: (newValue) => pin2 = newValue,
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(45),
                  child: TextFormField(
                    focusNode: pin3FocusNode,
                    obscureText: false,
                    style: TextStyle(fontSize: 27, color: Color(0xFFBD4242)),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: otpInputDecoration,
                    onChanged: (value) => nextField(value, pin4FocusNode),
                    onSaved: (newValue) => pin3 = newValue,
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(45),
                  child: TextFormField(
                    focusNode: pin4FocusNode,
                    obscureText: false,
                    style: TextStyle(fontSize: 27, color: Color(0xFFBD4242)),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: otpInputDecoration,
                    onChanged: (value) => nextField(value, pin5FocusNode),
                    onSaved: (newValue) => pin4 = newValue,
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(45),
                  child: TextFormField(
                    focusNode: pin5FocusNode,
                    obscureText: false,
                    style: TextStyle(fontSize: 27, color: Color(0xFFBD4242)),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: otpInputDecoration,
                    onChanged: (value) => nextField(value, pin6FocusNode),
                    onSaved: (newValue) => pin5 = newValue,
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(45),
                  child: TextFormField(
                    focusNode: pin6FocusNode,
                    obscureText: false,
                    style: TextStyle(
                      fontSize: 27,
                      color: Color(0xFFBD4242),
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    decoration: otpInputDecoration,
                    onChanged: (value) {
                      if (value.length == 1) {
                        pin6FocusNode.unfocus();
                        // Then you need to check is the code is correct or not
                      }
                    },
                    onSaved: (newValue) => pin6 = newValue,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.07),
          RoundedButton(
            text: "Verify",
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).accentColor,
            press: () async {
              _pinKey_two.currentState.save();
              String code = pin1 + pin2 + pin3 + pin4 + pin5 + pin6;
              print(code);
              try {
                await FirebaseAuth.instance
                    .signInWithCredential(PhoneAuthProvider.credential(
                        verificationId: _verificationCode, smsCode: code))
                    .then((value) async {
                  if (value.user != null) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConfirmThisUser()),
                        (route) => false);
                  }
                });
              } catch (e) {
                FocusScope.of(context).unfocus();
                _pinKey.currentState
                    .showSnackBar(SnackBar(content: Text('invalid OTP')));
              }
            },
            /*islogin
                  ? Navigator.pushNamed(context, ConfirmThisUser.routeName)
                  : Navigator.pushNamed(context, RegisterNewUser.routeName);*/
          ),
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+201142555375',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ConfirmThisUser()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }
}
