import 'package:customer_app/screens/login_screens/otp/phone_verification.dart';
import 'package:customer_app/screens/login_screens/phone_number/componants/phone_number.dart';
import 'package:customer_app/screens/login_screens/user_register/form_error.dart';
import 'package:customer_app/utils/constants.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'componants/country_code_field.dart';

class PhoneForm extends StatefulWidget {
  @override
  _PhoneFormState createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm> {
  final _formKey = GlobalKey<FormState>();
  String phone, smssent, verificationId;
  final List<String> errors = [];
  get verifiedSuccess => null;
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  Future<void> verfiyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResent]) {
      this.verificationId = verId;
      print("Code Sent");
      /*smsCodeDialoge(context).then((value) {

      });*/
    };
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {};
    final PhoneVerificationFailed verifyFailed = (FirebaseAuthException e) {
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
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
                  child: Column(
                    children: [
                      buildPhoneField(),
                      FormError(size: size, errors: errors),
                    ],
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
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  verfiyPhone();
                  print('$phone');
                  Navigator.pushNamed(context, VerifyPhoneNumber.routeName,
                      arguments: phoneNum(phoneNumber: phone));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildPhoneField() {
    return TextFormField(
      style: Theme.of(context).textTheme.subtitle1,
      keyboardType: TextInputType.phone,
      maxLength: 11,
      decoration: InputDecoration(
        hintText: "enter Your Phone Number",
        hintStyle: Theme.of(context).textTheme.bodyText2,
        border: OutlineInputBorder(),
      ),
      onSaved: (newValue) => phone = newValue,
      onChanged: (value) {
        this.phone = value;
        if (value.isNotEmpty) {
          removeError(error: NullPhoneNumberError);
          removeError(error: SmallPhoneNumberError);
          return "";
        }
        if (value.length > 10) {
          removeError(error: SmallPhoneNumberError);
          return "";
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: NullPhoneNumberError);
          return "";
        } else if (value.length < 10) {
          addError(error: SmallPhoneNumberError);
          return "";
        }
        return null;
      },
    );
  }
}
