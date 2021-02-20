import 'package:customer_app/screens/login_screens/otp/componants/navigation_args.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'home_body.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userFName = "user";
  @override
  void initState() {
    getCurrentUserData();
    super.initState();
  }

  getCurrentUserData() async {
    await getPrefFirstName().then((value) {
      setState(() {
        userFName = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome $userFName,",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w900),
            ),
            // SizedBox(
            //   width: size.width * 0.3,
            // ),
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
