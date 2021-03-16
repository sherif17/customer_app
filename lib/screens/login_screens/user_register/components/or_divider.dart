import 'package:flutter/material.dart';

class OrDivider extends StatefulWidget {
  String currentLang;

  OrDivider(this.currentLang);

  @override
  _OrDividerState createState() => _OrDividerState();
}

class _OrDividerState extends State<OrDivider> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildExpanded(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(widget.currentLang == "en" ? "OR" : "او"),
          ),
          buildExpanded(context),
        ],
      ),
    );
  }

  Expanded buildExpanded(BuildContext context) {
    return Expanded(
      child: Divider(
        color: Theme.of(context).primaryColor,
        height: 1.5,
        thickness: 2.5,
      ),
    );
  }
}
