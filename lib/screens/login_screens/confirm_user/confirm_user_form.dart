import 'file:///G:/Programming/Projects/Flutter/AndroidStudio/GradProject/customer_app_1/lib/widgets/form_error.dart';
import 'package:customer_app/utils/constants.dart';
import 'package:customer_app/utils/size_config.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmUserForm extends StatefulWidget {
  @override
  _ConfirmUserFormState createState() => _ConfirmUserFormState();
}

class _ConfirmUserFormState extends State<ConfirmUserForm> {
  final _formKey = GlobalKey<FormState>();

  String edited_FName;
  String edited_LName;

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
      child: Container(
        height: size.height,
        margin: EdgeInsets.only(top: size.height * 0.01, left: 5, right: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              radius: size.height * 0.06,
            ),
            SizedBox(
              height: size.height * 0.01,
              width: size.width * 0.6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                SizedBox(
                    height: size.height * 0.1,
                    width: size.width * 0.45,
                    child: DecoratedEditFNameTextField()),
                SizedBox(
                  width: size.width * 0.03,
                ),
                SizedBox(
                    height: size.height * 0.1,
                    width: size.width * 0.45,
                    child: DecoratedEditLNameTextField())
              ],
            ),
            SizedBox(
                width: size.height * 0.1,
                child: FormError(size: size, errors: errors)),
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
                height: size.height * 0.1,
                width: size.width * 0.5,
                child: DecoratedPhoneTField()),
            RoundedButton(
                text: "Edit my info",
                color: Theme.of(context).primaryColor,
                press: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    print(edited_FName);
                    print(edited_LName);
                  }
                }),
          ],
        ),
      ),
    );
  }

  TextFormField DecoratedEditFNameTextField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      initialValue: "FName",
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        labelText: 'First Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onSaved: (newValue) => edited_FName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: NullFirstNameError);
          removeError(error: SmallFirstNameError);
          return "";
        }
        if (value.length > 1) {
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

  TextFormField DecoratedEditLNameTextField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      initialValue: "LName",
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        //hintText: 'Your First Name',
        labelText: 'Last Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onSaved: (newValue) => edited_LName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: NullLastNameError);
          removeError(error: SmallLastNameError);
          return "";
        }
        if (value.length > 1) {
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

  TextFormField DecoratedPhoneTField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      enabled: false,
      initialValue: "01142555375",
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        labelText: 'Phone',
        //disabledBorder: disableInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      //onSaved: (newValue) => FName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          //  removeError(error: NullFirstNameError);
          // removeError(error: SmallFirstNameError);
          return "";
        }
        if (value.length > 1) {
          // removeError(error: SmallFirstNameError);
          return "";
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          //  addError(error: NullFirstNameError);
          return "";
        } else if (value.length == 1) {
          //addError(error: SmallFirstNameError);
          return "";
        }
        return null;
      },
    );
  }
}
