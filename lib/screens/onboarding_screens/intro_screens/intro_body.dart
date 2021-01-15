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
    {"text": "info 1", "image": "assets/images/women_truck.jpg"},
    {"text": "info 2", "image": "assets/images/mechanic_2.jpg"},
    {"text": "info 3", "image": "assets/images/mechnic.jpg"},
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "Rescue My Car\n",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(30),
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text("Customer APP ,Let's Start",
                style: Theme.of(context).textTheme.bodyText2),
            Expanded(
              flex: 4,
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
              flex: 2,
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
                      Navigator.pushNamed(context, EnterPhoneNumber.routeName);
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
              ? Theme.of(context).accentColor
              : Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
