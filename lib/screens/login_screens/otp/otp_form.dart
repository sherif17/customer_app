import 'package:customer_app/models/phone_num_model.dart';
import 'package:customer_app/screens/login_screens/confirm_user/confirm_is_that_user.dart';
import 'package:customer_app/screens/login_screens/otp/componants/progress_bar.dart';
import 'package:customer_app/screens/login_screens/phone_number/componants/phone_number.dart';
import 'package:customer_app/screens/login_screens/user_register/register_new_user.dart';
import 'package:customer_app/services/api_services.dart';
import 'package:customer_app/utils/constants.dart';
import 'package:customer_app/utils/size_config.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'componants/otp_code_field.dart';

class OtpForm extends StatefulWidget {
  PhoneRequestModel phoneRequestModel;
  String phone_num;
  ScaffoldState scafoldKey;
  OtpForm({Key key, this.phoneRequestModel, this.phone_num, this.scafoldKey})
      : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  bool checkServer = false;
  bool checkFirebase = false;
  final _pinKey_two = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  PhoneRequestModel phoneRequestModel;

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
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0,
    );
  }

  Widget _uiSetup(BuildContext context) {
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
                      }
                    },
                    onSaved: (newValue) => pin6 = newValue,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: size.height * 0.07),
          RoundedButton(
              text: "Verify",
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).accentColor,
              press: () async {
                isApiCallProcess = true;
                _pinKey_two.currentState.save();
                String code = pin1 + pin2 + pin3 + pin4 + pin5 + pin6;
                print(code);
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode, smsCode: code))
                      .then((value) async {
                    if (value.user != null) {
                      checkFirebase = true;
                      print(checkFirebase);
                    }
                  });
                } catch (e) {
                  print("invalid otp");

                  /*FocusScope.of(context).unfocus();
                  widget.scafoldKey
                      .showSnackBar(SnackBar(content: Text('invalid OTP')));*/
                }
                print("Request body: ${widget.phoneRequestModel.toJson()}.");
                setState(() {
                  isApiCallProcess = true;
                });
                ApiService apiService = new ApiService();
                apiService.phoneCheck(widget.phoneRequestModel).then((value) {
                  if (value != null) {
                    setState(() {
                      isApiCallProcess = false;
                    });
                    print("Response:");
                    print("ID:${value.id}.");
                    print("FName:${value.firstName}.");
                    print("LName:${value.lastName}.");
                    print("Phone:${value.phoneNumber}.");
                    print("info:${value.exists}.");
                    if (value.exists == true && checkFirebase == true) {
                      print(
                          "Firebase Token:${FirebaseAuth.instance.currentUser.uid}");
                      Navigator.pushNamed(context, ConfirmThisUser.routeName);
                    } else if (value.exists == false && checkFirebase == true) {
                      Navigator.pushNamed(context, RegisterNewUser.routeName);
                    }
                  }
                });
              }),
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+20${widget.phone_num}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              /*Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ConfirmThisUser()),
                  (route) => false);*/
              print("LOGGEDINNNNNN");
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
