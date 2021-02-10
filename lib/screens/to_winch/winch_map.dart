import 'package:customer_app/screens/to_winch/to_winch_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class WinchMap extends StatelessWidget {
  static String routeName = '/WinchMap';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: Text(
          'Request A Winch',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Theme.of(context).primaryColorDark),
        ),
      ),*/

      body: ToWinchMap(),
    );
  }
}