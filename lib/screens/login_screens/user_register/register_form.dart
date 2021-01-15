import 'package:customer_app/utils/constants.dart';
import 'package:customer_app/utils/size_config.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import 'form_error.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  String FName;
  String LName;

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

  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(children: [
        Row(
          children: [
            Expanded(
                child: Column(
              children: [
                buildFirstNameField(),
                SizedBox(height: size.height * 0.02),
              ],
            )),
            SizedBox(width: 15),
            Expanded(
                child: Column(
              children: [
                buildLastField(),
                SizedBox(height: size.height * 0.02),
              ],
            )),
          ],
        ),
        FormError(size: size, errors: errors),
        SizedBox(height: size.height * 0.03),
        RoundedButton(
          text: 'Create Account',
          color: Theme.of(context).accentColor,
          press: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              print(FName);
              print(LName);
              Navigator.of(context).pushNamed('/HomeScreen');
            }
          },
        ),
      ]),
    );
  }

  TextFormField buildFirstNameField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: 'Your First Name',
        labelText: 'First Name',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      onSaved: (newValue) => FName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: NullFirstNameError);
          return "";
        } else if (value.length > 1) {
          removeError(error: SmallFirstNameError);
          return "";
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: NullFirstNameError);
          return "";
        } else if (value.length == 1) {
          addError(error: SmallFirstNameError);
          return "";
        }
        return null;
      },
    );
  }

  TextFormField buildLastField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: 'Your Last Name',
        labelText: 'Last Name',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      onSaved: (newValue) => LName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: NullLastNameError);
          return "";
        } else if (value.length > 1) {
          removeError(error: SmallLastNameError);
          return "";
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: NullLastNameError);
          return "";
        } else if (value.length == 1) {
          addError(error: SmallLastNameError);
          return "";
        }
        return null;
      },
    );
  }
}
