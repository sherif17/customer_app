import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1.0,
      color: Theme.of(context).hintColor,
      thickness: 1.0,
    );
  }
}