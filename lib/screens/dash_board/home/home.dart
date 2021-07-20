import 'package:customer_app/local_db/customer_db/customer_info_db.dart';
import 'package:customer_app/localization/localization_constants.dart';
import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/screens/login_screens/otp/componants/navigation_args.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

import 'home_body.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String userFName = loadFirstNameFromDB();
  @override
  void initState() {
    //getCurrentUserData();
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Positioned(
              left: 0,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  getTranslated(context, "Welcome") + userFName,
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            /*SizedBox(
              width: size.width * 0.25,
            ),*/
            Icon(
              Icons.notifications_rounded,
              color: Colors.redAccent,
              size: 30,
            )
          ],
        ),
        centerTitle: false,
      ),
      body: HomeBody(),
    );
  }
}
