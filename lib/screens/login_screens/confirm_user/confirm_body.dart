import 'package:customer_app/screens/dash_board/dash_board.dart';
import 'package:customer_app/screens/login_screens/common_widgets/background.dart';
import 'package:customer_app/screens/login_screens/otp/componants/navigation_args.dart';
import 'package:customer_app/screens/login_screens/phone_number/enter_phone_number.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:customer_app/widgets/borderd_buttons.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'components/user_avatar.dart';
import 'confirm_user_form.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

String prefFName;
String prefLName;
String prefJwtToken;
String prefPhone;
String currentLang;

class _BodyState extends State<Body> {
  //otpNavData otpResponse;

  @override
  void initState() {
    getCurrentPrefData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //otpResponse = ModalRoute.of(context).settings.arguments;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            prefFName.toUpperCase() + ",Is That You ?",
            style: Theme.of(context).textTheme.headline1,
          ),
          UserAvatar(
              imgSrc: 'assets/icons/profile_bordered.svg',
              size: size,
              color: Theme.of(context).primaryColor),
          Text(
            prefFName + " " + prefLName,
            style: Theme.of(context).textTheme.headline2,
          ),
          RoundedButton(
              text: 'Yes, its Me',
              color: Theme.of(context).primaryColor,
              press: () {
                Map<String, dynamic> decodedToken =
                    JwtDecoder.decode(prefJwtToken);
                setPrefBackendID(decodedToken["_id"]);
                Navigator.pushNamed(
                  context,
                  DashBoard.routeName,
                  /* arguments: otpNavData(
                        jwtToken: otpResponse.jwtToken,
                        Phone: otpResponse.Phone,
                        socialPhoto: null)*/
                );
                printAllUserCurrentData();
              }),
          Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
            child: borderedRoundedButton(
                text: 'No, Edit Info',
                CornerRadius: 10,
                press: () {
                  _showModalBottomSheet(context, size);
                }),
          )
        ],
      ),
    );
  }

  void getCurrentPrefData() {
    getPrefFirstName().then((value) {
      setState(() {
        prefFName = value;
      });
    });
    getPrefLastName().then((value) {
      setState(() {
        prefLName = value;
      });
    });
    getPrefPhoneNumber().then((value) {
      setState(() {
        prefPhone = value;
      });
    });
    getPrefJwtToken().then((value) {
      setState(() {
        prefJwtToken = value;
      });
    });
    getPrefCurrentLang().then((value) => currentLang = value);
  }
}

_showModalBottomSheet(BuildContext context, Size size) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        overflow: Overflow.visible,
        children: [
          Container(
            height: size.height * 0.5,
            /*padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),*/
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ConfirmUserForm(
              prefFName: prefFName,
              prefLName: prefLName,
              prefPhone: prefPhone,
              prefJwtToken: prefJwtToken,
            ),
          ),
          Positioned(
            top: size.height * -0.03,
            left: size.width * 0.4,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal: size.width * 0.09),
                //padding: EdgeInsets.all(30),
                child: SvgPicture.asset(
                  'assets/icons/profile.svg',
                  height: size.height * 0.1,
                  width: size.width * 0.08,
                  //color: Theme.of(context),
                ),
              ),
            ),
          ),
        ]),
  );
}
