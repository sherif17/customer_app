import 'package:flutter/material.dart';
import 'constants.dart';

class problems extends StatefulWidget {
  @override
  _problemsState createState() => _problemsState();
}

class _problemsState extends State<problems> {
  @override
  ScrollController controller = ScrollController();
  double topContainer = 0;

  List<Widget> itemsData = [];
  final List<String> names = <String>[
    'problem 1',
    'problem 2',
    'problem 3',
    'problem 4',
    'problem 5',
    'problem 6',
    'problem 7',
    'problem 8',
    'problem 9',
    'problem 10',
  ];
  final List<String> msgCount = <String>[
    'limited: a',
    'limited: a',
    'limited: a',
    'limited: a',
    'limited: a',
    'limited: a',
    'limited: a',
    'limited: a',
    'limited: a',
    'limited: a',
  ];
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.08;
    return Container(
      height: size.height * 0.5,
      child: ListView.builder(
          shrinkWrap: true,
          controller: controller,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount: names.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.01,
              ),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      color: Theme.of(context).accentColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(
                            1.0, // Move to right 10  horizontally
                            1.0,
                          ),
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      )),
                  height: categoryHeight,
                  margin: EdgeInsets.all(2),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: size.width * 0.02,
                      top: size.height * 0.01,
                    ),
                    child: Text(
                      '${names[index]}\n ${msgCount[index]}',
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
            );
          }),
    );
  }
}
