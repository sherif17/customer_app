import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

Future buildStepperShowModalBottomSheet(
    BuildContext context, Size size, activeStep, upperBound) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: false,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Container(
            height: size.height * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                IconStepper(
                  icons: [
                    Icon(Icons.directions_car_outlined),
                    Icon(Icons.directions_car),
                    Icon(Icons.date_range_rounded),
                    Icon(Icons.done_outline_rounded),
                  ],
                  activeStepBorderColor: Colors.redAccent,
                  activeStepColor: Colors.white,
                  scrollingDisabled: true,
                  stepColor: Colors.white,
                  enableNextPreviousButtons: false,
                  lineColor: Colors.grey,
                  steppingEnabled: true,

                  // activeStep property set to activeStep variable defined above.
                  activeStep: activeStep,

                  // bound receives value from upperBound.
                  upperBound: (bound) => upperBound = bound,
                  // This ensures step-tapping updates the activeStep.
                  onStepReached: (index) {
                    setState(() {
                      activeStep = index;
                    });
                  },
                ),
                Content(activeStep: activeStep),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: activeStep == 0
                          ? null
                          : () {
                              // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
                              if (activeStep > 0) {
                                setState(() {
                                  activeStep--;
                                  print(activeStep);
                                });
                              }
                            },
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        //color: activeStep == 0 ? Colors.grey : Colors.red,
                      ),
                      iconSize: 50,
                      disabledColor: Colors.grey,
                    ),
                    header(activeStep),
                    IconButton(
                      onPressed: activeStep == 3
                          ? null
                          : () {
                              // Increment activeStep, when the next button is tapped. However, check for upper bound.
                              if (activeStep < upperBound) {
                                setState(() {
                                  activeStep++;
                                  print(activeStep);
                                });
                              }
                            },
                      icon: Icon(Icons.chevron_right_rounded,
                          color: activeStep < 3 ? Colors.red : Colors.grey),
                      iconSize: 50,
                      disabledColor: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget header(activeStep) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            headerText(activeStep),
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ],
    ),
  );
}

String headerText(activeStep) {
  switch (activeStep) {
    case 0:
      return 'Car Brand';

    case 1:
      return 'Car Modal';

    case 2:
      return 'Year of Production';

    case 3:
      return 'Required information';

    default:
      return 'Introduction';
  }
}

class Content extends StatefulWidget {
  const Content({
    Key key,
    @required this.activeStep,
  }) : super(key: key);

  final int activeStep;

  @override
  _ContentState createState() => _ContentState();
}

List<int> answer = [0, 0, 0];
List<RadioModel> step0 = [
  RadioModel(false, "Opel", Icons.directions_car),
  RadioModel(false, "Fiat", Icons.directions_car),
];

Map<int, List<RadioModel>> step1Index = {
  0: [
    RadioModel(false, "Astra", Icons.local_shipping),
    RadioModel(false, "Corsa", Icons.title)
  ],
  1: [
    RadioModel(false, "Tipo", Icons.local_shipping),
    RadioModel(false, "500", Icons.title)
  ],
};

//step1Index

List<RadioModel> step1 = [
  RadioModel(false, "Honda", Icons.local_shipping),
  RadioModel(false, "Toyota", Icons.title)
];

List<RadioModel> step1_1 = [
  RadioModel(false, "abc", Icons.branding_watermark),
  RadioModel(false, "def", Icons.branding_watermark_outlined)
];

List<RadioModel> step3 = [
  RadioModel(false, "2020", Icons.access_time_rounded),
  RadioModel(false, "2021", Icons.access_time_rounded)
];

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    switch (widget.activeStep) {
      case 0:
        return Expanded(child: SelectableCard(options: step0, step: 0));

      case 1:
        return Expanded(
            child: SelectableCard(options: choiceNextStep(), step: 1));

      case 2:
        return Expanded(child: SelectableCard(options: step3, step: 2));
      case 3:
        return Expanded(child: Text("3"));
    }
  }
}

List<RadioModel> choiceNextStep() {
  return step1Index[answer[0]];

  /*if (answer[0] == 0) {
      return step1;
    } else {
      return step1_1;
    }*/
}

Widget _commentary() {
  return TextFormField(
    keyboardType: TextInputType.multiline,
    maxLines: 3,
    decoration: InputDecoration(
      labelText: 'i.e - Concurrent Area',
    ),
  );
}

class SelectableInLineCard extends StatefulWidget {
  final List<RadioModel> options;

  SelectableInLineCard({@required this.options});

  @override
  _SelectableInLineCardState createState() => _SelectableInLineCardState();
}

class _SelectableInLineCardState extends State<SelectableInLineCard> {
  List<RadioModel> sampleData = new List<RadioModel>();

  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData = widget.options;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 12),
      ),
      itemCount: sampleData.length,
      itemBuilder: (context, index) {
        return Card(
          shape: sampleData[index].isSelected
              ? RoundedRectangleBorder(
                  side: BorderSide(color: Colors.redAccent, width: 2.0),
                  borderRadius: BorderRadius.circular(4.0))
              : RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey[200], width: 2.0),
                  borderRadius: BorderRadius.circular(4.0)),
          color: Colors.white,
          elevation: 0,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              setState(() {
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;

                //print(sampleData[index].time);
              });
            },
            child: GridTile(
              child: FlatButton(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          sampleData[index].time,
                          style: TextStyle(
                            fontSize: 15,
                            color: sampleData[index].isSelected
                                ? Colors.redAccent
                                : Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SelectableCard extends StatefulWidget {
  final List<RadioModel> options;
  final int step;
  SelectableCard({@required this.options, @required this.step});

  @override
  _SelectableCardState createState() => _SelectableCardState();
}

class _SelectableCardState extends State<SelectableCard> {
  List<RadioModel> choiceNextStep() {
    return step1Index[answer[0]];

    /*if (answer[0] == 0) {
      return step1;
    } else {
      return step1_1;
    }*/
  }

  Widget _commentary() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'i.e - Concurrent Area',
      ),
    );
  }

  List<RadioModel> sampleData = new List<RadioModel>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //sampleData = widget.options;
    //print(sampleData.toString());
  }

  @override
  Widget build(BuildContext context) {
    sampleData = widget.options;
    print(sampleData.toString());
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 2.5),
      ),
      itemCount: sampleData.length,
      itemBuilder: (context, index) {
        return Card(
          shape: sampleData[index].isSelected
              ? RoundedRectangleBorder(
                  side: BorderSide(color: Colors.redAccent, width: 2.0),
                  borderRadius: BorderRadius.circular(4.0))
              : RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey[200], width: 2.0),
                  borderRadius: BorderRadius.circular(4.0)),
          color: Colors.white,
          elevation: 0,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              setState(() {
                sampleData.forEach((element) => element.isSelected = false);
                sampleData[index].isSelected = true;
                print('step ${widget.step}');
                print('index ${index}');
                answer[widget.step] = index;
                print(answer[widget.step]);
              });
            },
            child: GridTile(child: RadioItem(sampleData[index])),
          ),
        );
      },
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              _item.icon,
              color: _item.isSelected ? Colors.redAccent : Colors.grey[500],
              size: 35,
            ),
            Text(
              _item.time,
              style: TextStyle(
                fontSize: 15,
                color: _item.isSelected ? Colors.redAccent : Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  String time;
  IconData icon;
  RadioModel(this.isSelected, this.time, this.icon);
}
//https://stackoverflow.com/questions/59130685/flutter-populating-steps-content-based-on-previous-selection-on-stepper
