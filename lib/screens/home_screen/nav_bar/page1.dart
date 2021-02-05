import 'package:bottom_tab_app/pages/profile.dart';
import 'package:bottom_tab_app/pages/home1.dart';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'home1.dart';
import 'first.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Properties & Variables needed

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    home1(),
    Chat(),
    Profile(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = Chat(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.chat),
        onPressed: () {
          setState(() {
            currentScreen = Chat(); // if user taps on this dashboard tab will be active
            currentTab = 1;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
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
                            home1(); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.blue : Colors.grey,
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
                  'Chatbot',
                  style: TextStyle(
                    color: currentTab == 1 ? Colors.blue : Colors.grey,
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
                          Icons.people_alt,
                          color: currentTab == 2 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                            color: currentTab == 2 ? Colors.blue : Colors.grey,
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
