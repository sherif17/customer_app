import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialRoundedButton extends StatelessWidget {
  final String iconSrc;
  final Function press;
  final String text;

  const SocialRoundedButton({
    Key key,
    @required this.size,
    this.iconSrc,
    this.press,
    this.text,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.09),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).accentColor, width: 3),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(29)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            SvgPicture.asset(
              iconSrc,
              height: size.height * 0.03,
              width: size.width * 0.03,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
