import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:customer_app/provider/customer_cars/customer_car_provider.dart';
import 'package:customer_app/provider/mechanic_request/mechnic_request_provider.dart';
import 'package:customer_app/screens/login_screens/confirm_user/confirm_body.dart';
import 'package:customer_app/screens/to_mechanic/starting_mechanic_service/cheking_componants/ripple_animation.dart';
import 'package:customer_app/screens/to_mechanic/starting_mechanic_service/viewing_coming_diagnoses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CarChecking extends StatefulWidget {
  static String routeName = '/CarChecking';
  const CarChecking({key}) : super(key: key);

  @override
  _CarCheckingState createState() => _CarCheckingState();
}

class _CarCheckingState extends State<CarChecking> {
  @override
  void initState() {
    super.initState();
    listenForDiagnosis(context);
  }

  listenForDiagnosis(context) async {
    Provider.of<MechanicRequestProvider>(context, listen: false)
        .isNavigatedToCarChecking = true;
    await Provider.of<MechanicRequestProvider>(context, listen: false)
        .listeningForMechanicDiagnoses(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerCarProvider>(
      builder: (context, val, child) => Scaffold(
        appBar: AppBar(
          title: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Checking - ${val.selectedCarInfo} - Started",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                //LinearProgressIndicator()
              ],
            ),
          ),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RipplesAnimation(),
              DefaultTextStyle(
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w900,
                    fontSize: 22),
                child: Container(
                  height: 50,
                  child: Center(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        ScaleAnimatedText('Please Wait....',
                            duration: Duration(seconds: 3)),
                        ScaleAnimatedText('Mechanic checking Your Car Now',
                            duration: Duration(seconds: 3)),
                        ScaleAnimatedText('You will receive list of diagnoses',
                            duration: Duration(seconds: 3)),
                        ScaleAnimatedText('To be confirmed',
                            duration: Duration(seconds: 3))
                      ],
                      repeatForever: true,
                    ),
                  ),
                ),
              ),
              // TextButton(
              //     onPressed: () {;
              //     },
              //     child: Text("press"))
            ],
          ),
        ),
      ),
    );
  }

  void _onPressed(context) {}
}
