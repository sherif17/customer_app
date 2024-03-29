import 'package:customer_app/localization/localization_constants.dart';
import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/screens/dash_board/chatbot/chat.dart';
import 'package:customer_app/screens/dash_board/home/home.dart';
import 'package:customer_app/screens/dash_board/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  static String routeName = '/DashBoard';
  @override
  _DashBoard createState() => _DashBoard();
}

class _DashBoard extends State<DashBoard> {
  // Properties & Variables needed

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Home(),
    ChatBot(),
    Profile(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = Home(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    //Provider.of<MapsProvider>(context).locatePosition(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.chat_outlined,
            size: 35,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              currentScreen =
                  ChatBot(); // if user taps on this dashboard tab will be active
              currentTab = 1;
            });
          },
          backgroundColor: Theme.of(context).primaryColorLight),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Container(
          height: size.height * 0.099,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Home(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home_outlined,
                          size: 35,
                          color: currentTab == 0
                              ? Theme.of(context).primaryColorLight
                              : Colors.grey,
                        ),
                        Text(
                          getTranslated(context, "Home"),
                          style: TextStyle(
                            color: currentTab == 0
                                ? Theme.of(context).primaryColorLight
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 36.0),
                child: Text(
                  getTranslated(context, "Chatbot"),
                  style: TextStyle(
                    fontSize: 20,
                    color: currentTab == 1
                        ? Theme.of(context).primaryColorLight
                        : Colors.grey,
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen =
                            Profile(); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          size: 35,
                          color: currentTab == 2
                              ? Theme.of(context).primaryColorLight
                              : Colors.grey,
                        ),
                        Text(
                          getTranslated(context, "Profile"),
                          style: TextStyle(
                            color: currentTab == 2
                                ? Theme.of(context).primaryColorLight
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
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
