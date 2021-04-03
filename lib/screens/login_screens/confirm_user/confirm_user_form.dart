//import 'file:///G:/Programming/Projects/Flutter/AndroidStudio/GradProject/customer_app_1/lib/models/user_register/user_register_model.dart';
import 'package:customer_app/models/user_register/user_register_model.dart';
import 'package:customer_app/localization/localization_constants.dart';
import 'package:customer_app/screens/dash_board/dash_board.dart';
import 'package:customer_app/screens/login_screens/otp/componants/navigation_args.dart';
import 'package:customer_app/screens/login_screens/otp/componants/progress_bar.dart';
import 'package:customer_app/services/api_services.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:customer_app/utils/constants.dart';
import 'package:customer_app/utils/size_config.dart';
import 'package:customer_app/widgets/form_error.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ConfirmUserForm extends StatefulWidget {
  String prefFName;
  String prefLName;
  String prefJwtToken;
  String prefPhone;
  String currentLang;

  ConfirmUserForm({
    //Key key,
    this.prefFName,
    this.prefLName,
    this.prefJwtToken,
    this.prefPhone,
    this.currentLang,
  }); //: super(key: key);
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

  String Fname;
  String Lname;

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
            // Container(
            //   // margin: EdgeInsets.symmetric(horizontal: size.width * 0.09),
            //   padding: EdgeInsets.all(30),
            //   child: SvgPicture.asset(
            //     'assets/icons/profile.svg',
            //     height: size.height * 0.08,
            //     width: size.width * 0.08,
            //     //color: Theme.of(context),
            //   ),
            // ),
            SizedBox(
              height: size.height * 0.1,
              width: size.width * 0.6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
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
                text: getTranslated(context, "Edit my info"),
                color: Theme.of(context).primaryColor,
                press: () {
                  if (confirmValidateAndSave()) {
                    if (FName_Changed == true || LName_changed == true) {
                      print(
                          "Request body: ${userRegisterRequestModel.toJson()}.");
                      print("hii${widget.prefJwtToken}");
                      setState(() {
                        isApiCallProcess = true;
                      });
                      ApiService apiService = new ApiService();
                      apiService
                          .registerUser(
                              userRegisterRequestModel, widget.prefJwtToken)
                          .then(
                        (value) {
                          if (value.error == null) {
                            jwtToken = value.token;
                            setPrefJwtToken(jwtToken);
                            print(jwtToken);
                            Map<String, dynamic> decodedToken =
                                JwtDecoder.decode(jwtToken);
                            responseID = decodedToken["_id"];
                            setPrefBackendID(responseID);
                            //responseFName = decodedToken["firstName"];
                            setPrefFirstName(
                                userRegisterRequestModel.firstName);
                            //responseLName = decodedToken["lastName"];
                            setPrefLastName(userRegisterRequestModel.lastName);
                            responseIat = decodedToken["iat"];
                            setPrefIAT(responseIat.toString());
                            // print(responseID);
                            // print(responseLName);
                            // print(responseFName);
                            // print(responseIat);
                            // print(value.token);
                            printAllUserCurrentData();
                            setState(() {
                              isApiCallProcess = false;
                            });
                            Navigator.pushReplacementNamed(
                              context,
                              DashBoard.routeName,
                              /* arguments: otpNavData(
                                    jwtToken: jwtToken,
                                    Phone: widget.otpResponse_Phone,
                                    socialPhoto: null)*/
                            );
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
      initialValue: widget.prefFName,
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        labelText: widget.currentLang == "en" ? 'First Name' : "الاسم الاول",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onSaved: (newValue) {
        if (newValue != widget.prefFName) FName_Changed = true;
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
      initialValue: widget.prefLName,
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        labelText: widget.currentLang == "en" ? 'Last Name' : "اسم العائله",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      onSaved: (newValue) {
        if (newValue != widget.prefLName) LName_changed = true;
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
      initialValue: widget.prefPhone,
      style: Theme.of(context).textTheme.bodyText2,
      decoration: InputDecoration(
        labelText: widget.currentLang == "en" ? 'Phone number' : "رقم الهاتف",
        //disabledBorder: disableInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
