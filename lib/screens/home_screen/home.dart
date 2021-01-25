import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home_body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeBody(),
    );
  }
}

/*
 otpNavData finalResponse = ModalRoute.of(context).settings.arguments;
    Map<String, dynamic> decodedToken =
        JwtDecoder.decode(finalResponse.jwtToken);
    String ID = decodedToken['_id'];
    String Fname = decodedToken['firstName'];
    String Lname = decodedToken['lastName'];
    String Phone = finalResponse.Phone;
    int iat = decodedToken['iat'];

    Text("User JWT :${finalResponse.jwtToken}"),
          Text("User ID : $ID"),
          Text("User Fname:$Fname"),
          Text("User LName:$Lname"),
          Text("User Phone:$Phone"),
          Text("User iat: $iat"),
* */
