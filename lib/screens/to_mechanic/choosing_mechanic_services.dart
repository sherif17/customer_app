import 'package:customer_app/screens/to_mechanic/choosing_mechanic_services_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChoosingMechanicServices extends StatelessWidget {
  static String routeName = '/ChoosingMechanicServices';
  const ChoosingMechanicServices({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChoosingMechanicServicesBody(),
    );
  }
}
