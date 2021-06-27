import 'package:animated_text_kit/animated_text_kit.dart';
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
    Provider.of<MechanicRequestProvider>(context, listen: false)
        .loadDiagnoses();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // Alert(
      //     context: context,
      //     title: "LOGIN",
      //     content: Column(
      //       children: <Widget>[
      //         Expanded(
      //           child: ListView.builder(
      //               // shrinkWrap: true,
      //               itemCount: 5,
      //               itemBuilder: (BuildContext context, int index) {
      //                 return ListTile(
      //                     leading: Icon(Icons.list),
      //                     trailing: Text(
      //                       "GFG",
      //                       style: TextStyle(color: Colors.green, fontSize: 15),
      //                     ),
      //                     title: Text("List item $index"));
      //               }),
      //         )
      //       ],
      //     ),
      //     buttons: [
      //       DialogButton(
      //         onPressed: () => Navigator.pop(context),
      //         child: Text(
      //           "LOGIN",
      //           style: TextStyle(color: Colors.red, fontSize: 20),
      //         ),
      //       )
      //     ]).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Checking Your Car",
                style: Theme.of(context).textTheme.headline2,
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
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (BuildContext context, _, __) =>
                          ViewingComingDiagnoses()));
                },
                child: Text("press"))
          ],
        ),
      ),
    );
  }

  void _onPressed(context) {}
}
