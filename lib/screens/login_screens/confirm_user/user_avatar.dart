import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserAvatar extends StatelessWidget {
  final String imgSrc;
  const UserAvatar({
    Key key,
    @required this.size,
    this.imgSrc,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.09),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor, width: 3),
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        'assets/icons/man.svg',
        height: size.height * 0.09,
        width: size.width * 0.08,
        //color: Theme.of(context),
      ),
    );
  }
}
