import 'package:customer_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class onBoardingContent extends StatelessWidget {
  final String text;
  final String image;
  const onBoardingContent({
    Key key,
    this.text,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Image.asset(
          image,
          height: getProportionateScreenHeight(400),
          width: getProportionateScreenWidth(400),
        ),
        //Spacer(),
        Text(text),
        Spacer(),
      ],
    );
  }
}
