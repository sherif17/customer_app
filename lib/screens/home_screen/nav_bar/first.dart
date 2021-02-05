import 'package:flutter/material.dart';

class first extends StatefulWidget {
  @override
  _firstState createState() => _firstState();
}

class _firstState extends State<first> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 45.0,
                right: 190.0,
              ),
              child: Text(
                "Welcome user,",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 15.0),
              child: Container(
                width: 400.0,
                height: 210.0,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 20.0,
                        right: 15.0,
                      ),
                      child: Text(
                        "Services We offer",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        left: 10.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 180.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(15))),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 40.0,
                                    ),
                                  ),
                                  Text(
                                    "Winch",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 32.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 180.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(15))),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 30.0,
                                    ),
                                  ),
                                  Text(
                                    "mechanic &\nrepair service",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 17.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
