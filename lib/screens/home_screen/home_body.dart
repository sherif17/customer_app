import 'package:customer_app/screens/login_screens/otp/componants/navigation_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  Widget _greenColors() {
    return Positioned(
      top: 0,
      child: Container(
        color: Theme.of(context).primaryColorLight,
        height: 250,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget _getInfo(ID, Fname, Lname, Phone, iat, token, profilePhoto, email) {
    bool exist;
    if (profilePhoto != null)
      exist = true;
    else
      exist = false;
    return Positioned(
      top: 75,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 250,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("User information",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.end),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.,
                children: <Widget>[
                  CircleAvatar(
                    radius: 40.0,
                    backgroundImage: exist
                        ? NetworkImage(profilePhoto)
                        : AssetImage("assets/icons/profile.png"),
                    backgroundColor: Colors.red,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Text(Fname,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                  SizedBox(
                    width: 5,
                  ),
                  Text(Lname,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Phone ",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                          fontSize: 15)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(Phone)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _userAdress(ID, Fname, Lname, Phone, iat, token, profilePhoto, email) {
    bool exist;
    if (email != null)
      exist = true;
    else
      exist = false;
    return Positioned(
      top: 300,
      child: Container(
        margin: EdgeInsets.all(20),
        height: 400,
        width: MediaQuery.of(context).size.width * 0.90,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Your Detailed Info",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("User ID",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                          fontSize: 15)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(ID),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey,
                height: 5,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Email",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                          fontSize: 15)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(exist ? email : "N/A"),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey,
                height: 5,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("IAT",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                          fontSize: 15)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(iat),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey,
                height: 5,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Jwt :",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                          fontSize: 12)),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      height: 20,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        token,
                        overflow: TextOverflow.visible,
                        maxLines: null,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    otpNavData finalResponse = ModalRoute.of(context).settings.arguments;
    Map<String, dynamic> decodedToken =
        JwtDecoder.decode(finalResponse.jwtToken);
    String token = finalResponse.jwtToken;
    String ID = decodedToken['_id'];
    String Fname = decodedToken['firstName'];
    String Lname = decodedToken['lastName'];
    String Phone = finalResponse.Phone;
    dynamic profilePhoto = finalResponse.socialPhoto;
    dynamic email = finalResponse.socialEmail;
    String iat = decodedToken['iat'].toString();

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          "Profile",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColorLight,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            _greenColors(),
            _getInfo(ID, Fname, Lname, Phone, iat, token, profilePhoto, email),
            SizedBox(),
            _userAdress(
                ID, Fname, Lname, Phone, iat, token, profilePhoto, email),
          ],
        ),
      ),
    );
  }
}