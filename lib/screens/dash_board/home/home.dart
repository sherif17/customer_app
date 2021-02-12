import 'package:customer_app/screens/login_screens/otp/componants/navigation_args.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'home_body.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    otpNavData finalResponse = ModalRoute.of(context).settings.arguments;
    Map<String, dynamic> decodedToken =
        JwtDecoder.decode(finalResponse.jwtToken);
    String Fname = decodedToken['firstName'];
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome $Fname,",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              width: size.width * 0.3,
            ),
            /* Expanded(
              child: Icon(
                Icons.notifications_rounded,
                color: Colors.redAccent,
                size: 30,
              ),
            )*/
          ],
        ),
        centerTitle: false,
      ),
      body: HomeBody(),
    );
  }
}
