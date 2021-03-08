import 'package:customer_app/localization/localization_constants.dart';
import 'package:customer_app/screens/login_screens/phone_number/enter_phone_number.dart';
import 'package:customer_app/utils/constants.dart';
import 'package:customer_app/utils/size_config.dart';
import 'package:customer_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'onboarding_content.dart';

class IntroBody extends StatefulWidget {
  @override
  _IntroBodyState createState() => _IntroBodyState();
}

class _IntroBodyState extends State<IntroBody> {
  int currentPage = 0;
  List<Map<String, String>> onBoardingData = [
    {"text": "info 1", "image": "assets/illustrations/towTruck.svg"},
    {"text": "info 2", "image": "assets/illustrations/womanCar.svg"},
    {"text": "info 3", "image": "assets/illustrations/boyCar.svg"},
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.05),
              child: Text(
                getTranslated(context, "overAllProjectName"),
                style: Theme.of(context).textTheme.headline1,
                /*style: TextStyle(
                  fontSize: getProportionateScreenWidth(30),
                  color: Theme.of(context).primaryColor,
                ),*/
              ),
            ),
            Text("Customer App ,Let's Start",
                style: Theme.of(context).textTheme.headline2),
            Expanded(
              flex: 8,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: onBoardingData.length,
                itemBuilder: (context, index) => onBoardingContent(
                  image: onBoardingData[index]["image"],
                  text: onBoardingData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onBoardingData.length,
                        (index) => DotSweeper(index: index),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(50),
                  ),
                  RoundedButton(
                    text: 'GET STARTED',
                    color: Theme.of(context).primaryColor,
                    press: () {
                      Navigator.pushReplacementNamed(
                          context, EnterPhoneNumber.routeName);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer DotSweeper({int index}) {
    return AnimatedContainer(
      duration: animationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPage == index
              ? Theme.of(context).primaryColor
              : Colors.grey,
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
