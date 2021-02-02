import 'package:customer_app/models/user_register_model.dart';
import 'package:customer_app/screens/home_screen/nav_bar/home.dart';
import 'package:customer_app/screens/login_screens/otp/componants/navigation_args.dart';
import 'package:customer_app/screens/login_screens/otp/componants/progress_bar.dart';
import 'package:customer_app/services/api_services.dart';
import 'package:customer_app/utils/constants.dart';
import 'package:customer_app/utils/size_config.dart';
import 'package:customer_app/widgets/form_error.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ConfirmUserForm extends StatefulWidget {
  String otpResponse_FName;
  String otpResponse_LName;
  String otpResponse_Phone;
  String otpResponse_JWT;
  ConfirmUserForm({
    Key key,
    this.otpResponse_FName,
    this.otpResponse_LName,
    this.otpResponse_Phone,
    this.otpResponse_JWT,
  }) : super(key: key);
  @override
  _ConfirmUserFormState createState() => _ConfirmUserFormState();
}

class _ConfirmUserFormState extends State<ConfirmUserForm> {
  final _formKey = GlobalKey<FormState>();
  UserRegisterRequestModel userRegisterRequestModel;
  bool isApiCallProcess = false;

  String jwtToken;
  String responseID;
  String responseFName;
  String responseLName;
  int responseIat;

  bool FName_Changed = false;
  bool LName_changed = false;

  @override
  void initState() {
    super.initState();
    userRegisterRequestModel = new UserRegisterRequestModel();
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

  final List<String> errors = [];
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: confirm_build(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0,
    );
  }

  Widget confirm_build(BuildContext context) {
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
            Container(
              // margin: EdgeInsets.symmetric(horizontal: size.width * 0.09),
              padding: EdgeInsets.all(30),
              child: SvgPicture.asset(
                'assets/icons/profile.svg',
                height: size.height * 0.08,
                width: size.width * 0.08,
                //color: Theme.of(context),
              ),
            ),
            SizedBox(
              height: size.height * 0.001,
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
                  if (confirmValidateAndSave()) {
                    if (FName_Changed == true || LName_changed == true) {
                      print(
                          "Request body: ${userRegisterRequestModel.toJson()}.");
                      print("hii${widget.otpResponse_JWT}");
                      setState(() {
                        isApiCallProcess = true;
                      });
                      ApiService apiService = new ApiService();
                      apiService
                          .registerUser(
                              userRegisterRequestModel, widget.otpResponse_JWT)
                          .then(
                        (value) {
                          if (value.error == null) {
                            jwtToken = value.token;
                            print(jwtToken);
                            Map<String, dynamic> decodedToken =
                                JwtDecoder.decode(jwtToken);
                            responseID = decodedToken["_id"];
                            responseFName = decodedToken["firstName"];
                            responseLName = decodedToken["lastName"];
                            responseIat = decodedToken["iat"];
                            print(responseID);
                            print(responseLName);
                            print(responseFName);
                            print(responseIat);
                            print(value.token);
                            setState(() {
                              isApiCallProcess = false;
                            });
                            Navigator.pushNamed(context, HomeScreen.routeName,
                                arguments: otpNavData(
                                    jwtToken: jwtToken,
                                    Phone: widget.otpResponse_Phone,socialPhoto:null));
                          } else
                            print(value.error);
                        },
                      );
                    } else {
                      setState(() {
                        Navigator.pop(context);
                      });
                    }
                  } else {
                    print("Validation error");
                  }
                }),
          ],
        ),
      ),
    );
  }

  bool confirmValidateAndSave() {
    final registerFormKey = _formKey.currentState;
    if (registerFormKey.validate()) {
      registerFormKey.save();
      return true;
    } else
      return false;
  }

  TextFormField DecoratedEditFNameTextField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      initialValue: widget.otpResponse_FName,
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        labelText: 'First Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onSaved: (newValue) {
        if (newValue != widget.otpResponse_FName) FName_Changed = true;
        userRegisterRequestModel.firstName = newValue;
      },
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
      initialValue: widget.otpResponse_LName,
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        labelText: 'Last Name',
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onSaved: (newValue) {
        if (newValue != widget.otpResponse_LName) LName_changed = true;
        userRegisterRequestModel.lastName = newValue;
      },
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
      initialValue: widget.otpResponse_Phone,
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        labelText: 'Phone',
        //disabledBorder: disableInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
