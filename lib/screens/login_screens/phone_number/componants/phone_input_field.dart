import 'package:flutter/material.dart';

class PhoneInputField extends StatelessWidget {
  final String hint;
  final double radius;
  final double width;
  final Color borderColor;
  final TextInputType type;

  const PhoneInputField({
    Key key,
    this.hint,
    this.radius,
    this.width,
    this.borderColor,
    this.type,
    //this.child,
    //this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.subtitle1,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyText2,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(radius),
                topRight: Radius.circular(radius)),
            borderSide: BorderSide(color: borderColor, width: width),
          )),
      keyboardType: type,
      maxLength: 11,

      //minLines: 2,
    );
  }
}
