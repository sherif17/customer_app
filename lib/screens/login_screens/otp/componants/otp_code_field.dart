import 'package:customer_app/utils/constants.dart';
import 'package:flutter/material.dart';

void nextField(String value, FocusNode focusNode) {
  if (value.length == 1) {
    focusNode.requestFocus();
  }
}

TextFormField buildLastCodeField(FocusNode lastNode) {
  return TextFormField(
    focusNode: lastNode,
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
        lastNode.unfocus();
        // Then you need to check is the code is correct or not
      }
    },
  );
}

TextFormField buildFirstCodeField(FocusNode toNode) {
  return TextFormField(
    autofocus: true,
    obscureText: false,
    style: TextStyle(fontSize: 27, color: Color(0xFFBD4242)),
    keyboardType: TextInputType.number,
    textAlign: TextAlign.center,
    maxLength: 1,
    decoration: otpInputDecoration,
    onChanged: (value) {
      nextField(value, toNode);
    },
  );
}

TextFormField buildCodeFormField(FocusNode fromNode, FocusNode toNode) {
  return TextFormField(
    focusNode: fromNode,
    obscureText: false,
    style: TextStyle(fontSize: 27, color: Color(0xFFBD4242)),
    keyboardType: TextInputType.number,
    textAlign: TextAlign.center,
    maxLength: 1,
    decoration: otpInputDecoration,
    onChanged: (value) => nextField(value, toNode),
  );
}
