import 'package:customer_app/provider/winch_request/winch_request_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WinchTrip extends StatefulWidget {
  @override
  _WinchTripState createState() => _WinchTripState();
}

class _WinchTripState extends State<WinchTrip> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Consumer<WinchRequestProvider>(
        builder: (context,val,child)=>DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.22,
          maxChildSize: 1.0,
          builder: (BuildContext myContext, controller) {
            return SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0),),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7,0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 17.0),
                  child: Column(
                    children: [

                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}