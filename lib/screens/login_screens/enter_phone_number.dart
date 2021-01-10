import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnterPhoneNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
        home: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.only(left: 0.0, top: 80.0, right: 0.0, bottom: 0.0),
          child: Form(
            child: Column(
              children: <Widget>[
                Text('Enter Your Phone Number below:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'MPLUSRounded1c-Medium',
                      fontSize: 35,
                      color: Colors.blue,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 15.0, right: 0.0, bottom: 0.0),
                  child: Text(
                      'Enter your mobile number ,to create an account or to log in to your existing one.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'MPLUSRounded1c-Thin',
                        fontSize: 15,
                        color: Colors.black.withOpacity(0.2),
                      )),
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 0.0, right: 20.0, bottom: 0.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter Phone ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.blue, width: 0.0),
                        )),
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 200.0, right: 20.0, bottom: 40.0),
                  child: RaisedButton(
                    color: Color(0xff0091EA),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    onPressed: () => {
                      //do something
                    },
                    child: Text('Continue',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontFamily: 'MPLUSRounded1c-Regular')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
