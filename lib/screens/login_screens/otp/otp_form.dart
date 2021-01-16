import 'package:customer_app/utils/size_config.dart';
import 'package:customer_app/widgets/rounded_button.dart';
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
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.08),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(60),
                  child: buildFirstCodeField(pin2FocusNode),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(60),
                  child: buildCodeFormField(pin2FocusNode, pin3FocusNode),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(60),
                  child: buildCodeFormField(pin3FocusNode, pin4FocusNode),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(60),
                  child: buildLastCodeField(pin4FocusNode),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.07),
        ],
      ),
    );
  }
}
