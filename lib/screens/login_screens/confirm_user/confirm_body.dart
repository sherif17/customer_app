import 'package:customer_app/screens/dash_board/dash_board.dart';
import 'package:customer_app/screens/login_screens/common_widgets/background.dart';
import 'package:customer_app/screens/login_screens/otp/componants/navigation_args.dart';
import 'package:customer_app/screens/login_screens/phone_number/enter_phone_number.dart';
import 'package:customer_app/widgets/borderd_buttons.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import 'components/user_avatar.dart';
import 'confirm_user_form.dart';

class Body extends StatelessWidget {
  otpNavData otpResponse;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    otpResponse = ModalRoute.of(context).settings.arguments;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            otpResponse.FName.toUpperCase() + ",Is That You ?",
            style: Theme.of(context).textTheme.headline1,
          ),
          UserAvatar(
              imgSrc: 'assets/icons/profile_bordered.svg',
              size: size,
              color: Theme.of(context).primaryColor),
          Text(
            otpResponse.FName + " " + otpResponse.LName,
            style: Theme.of(context).textTheme.headline2,
          ),
          RoundedButton(
              text: 'Yes, its Me',
              color: Theme.of(context).primaryColor,
              press: () {
                Navigator.pushNamed(context, DashBoard.routeName,
                    arguments: otpNavData(
                        jwtToken: otpResponse.jwtToken,
                        Phone: otpResponse.Phone,
                        socialPhoto: null));
              }),
          Theme(
            data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
            child: borderedRoundedButton(
                text: 'No, Edit Info',
                CornerRadius: 10,
                press: () {
                  _showModalBottomSheet(context, size.height * 0.5);
                }),
          )
        ],
      ),
    );
  }

  _showModalBottomSheet(context, size) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      builder: (context) => SingleChildScrollView(
        child: Container(
          height: size,
          /*padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),*/
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ConfirmUserForm(
            otpResponse_FName: otpResponse.FName,
            otpResponse_LName: otpResponse.LName,
            otpResponse_Phone: otpResponse.Phone,
            otpResponse_JWT: otpResponse.jwtToken,
          ),
        ),
      ),
    );
  }
}
