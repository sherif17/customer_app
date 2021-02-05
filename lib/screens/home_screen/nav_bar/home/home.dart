import 'package:customer_app/screens/home_screen/nav_bar/home/home_body.dart';
import 'package:customer_app/screens/home_screen/nav_bar/dash_board.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
      ),
      body: HomeBody(),
    );
  }
}
