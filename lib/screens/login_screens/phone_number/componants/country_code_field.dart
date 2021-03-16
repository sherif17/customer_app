import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CountryCode extends StatefulWidget {
  final double radius;
  final double width;
  final Color borderColor;
  const CountryCode({
    Key key,
    this.width,
    this.borderColor,
    this.radius,
  }) : super(key: key);

  @override
  _CountryCodeState createState() => _CountryCodeState();
}

class _CountryCodeState extends State<CountryCode> {
  String currentLang;

  @override
  void initState() {
    super.initState();
    getCurrentPrefData();
  }

  void getCurrentPrefData() {
    getPrefCurrentLang().then((value) {
      setState(() {
        currentLang = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: false,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          hintText: currentLang == "en" ? "+20" : "+02",
          hintStyle: Theme.of(context).textTheme.subtitle1,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.radius),
                bottomLeft: Radius.circular(widget.radius)),
            borderSide:
                BorderSide(color: widget.borderColor, width: widget.width),
          )),
    );
  }
}
