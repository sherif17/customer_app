import 'package:customer_app/localization/localization_constants.dart';
import 'package:customer_app/models/cars/add_new_car_model.dart';
import 'package:customer_app/screens/dash_board/dash_board.dart';
import 'package:customer_app/screens/login_screens/otp/componants/progress_bar.dart';
import 'package:customer_app/services/api_services.dart';
import 'package:customer_app/services/car_services/car_services.dart';
import 'package:customer_app/shared_prefrences/customer_user_model.dart';
import 'package:customer_app/utils/constants.dart';
import 'package:customer_app/widgets/form_error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:im_stepper/stepper.dart';

GlobalKey<FormState> finalStepFormKey = GlobalKey<FormState>();
AddNewCarRequestModel addNewCarRequestModel;
String winchPlatesNum;
String winchPlatesChar;
bool isApiCallProcess = false;
List<dynamic> answer = [0, 0, 0];

Future buildStepperShowModalBottomSheet(BuildContext context, Size size,
    activeStep, upperBound, list, response, currentLang) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, setState) {
          return Container(
            height: size.height * 0.6,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
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
                    Icon(Icons.edit),
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
                Content(
                  activeStep: activeStep,
                  list: list,
                  response: response,
                ),
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
                        currentLang == "en"
                            ? Icons.chevron_left_rounded
                            : Icons.chevron_right_rounded,
                        //color: activeStep == 0 ? Colors.grey : Colors.red,
                      ),
                      iconSize: 50,
                      disabledColor: Colors.grey,
                    ),
                    header(activeStep, context),
                    IconButton(
                      onPressed: () async {
                        if (activeStep == 3) {
                          if (finalFormValidateAndSave()) {
                            addNewCarRequestModel.carBrand = answer[0];
                            addNewCarRequestModel.model = answer[1];
                            addNewCarRequestModel.year = answer[2];
                            addNewCarRequestModel.plates =
                                winchPlatesNum + winchPlatesChar;
                            print(
                                "Request body: ${addNewCarRequestModel.toJson()}.");

                            setState(() {
                              isApiCallProcess = true;
                            });

                            CarApiService api = new CarApiService();
                            api
                                .addUserNewCar(addNewCarRequestModel,
                                    await getPrefJwtToken())
                                .then((value) {
                              if (value.error == null) {
                                print(value.id);
                                print(value.plates);
                                //  Navigator.pop(context);
                                Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              DashBoard(),
                                      transitionDuration: Duration(seconds: 0),
                                    ));
                                // (route) => false);
                              } else {
                                print(value.error);
                              }
                            });
                            setState(() {
                              isApiCallProcess = false;
                            });
                          }
                        }
                        // Increment activeStep, when the next button is tapped. However, check for upper bound.
                        else if (activeStep < upperBound) {
                          setState(() {
                            activeStep++;
                            print(activeStep);
                          });
                        }
                      },
                      icon: activeStep == 3
                          ? Icon(
                              Icons.check,
                              color: Colors.red,
                            )
                          : Icon(
                              currentLang == "en"
                                  ? Icons.chevron_right_rounded
                                  : Icons.chevron_left_rounded,
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

bool finalFormValidateAndSave() {
  final registerFormKey = finalStepFormKey.currentState;
  if (registerFormKey.validate()) {
    registerFormKey.save();
    return true;
  } else
    return false;
}

Widget header(activeStep, context) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            headerText(activeStep, context),
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

String headerText(activeStep, context) {
  switch (activeStep) {
    case 0:
      return getTranslated(context, "Car Brand"); //'Car Brand'; //

    case 1:
      return getTranslated(context, "Car Model"); //'Car Model'; //
    case 2:
      return getTranslated(
          context, "Year of Production"); //'Year of Production'; //

    case 3:
      return getTranslated(
          context, "Required information"); //'Required information'; //

    default:
      return 'Introduction';
  }
}

class Content extends StatefulWidget {
  // GlobalKey<FormState> finalStepFormKey = GlobalKey<FormState>();
  //List<dynamic> answer = [0, 0, 0];
  var list;
  Map<String, List<dynamic>> response = {};
  Content({Key key, @required this.activeStep, this.list, this.response})
      : super(key: key);

  final int activeStep;

  @override
  _ContentState createState() => _ContentState();
}

List<RadioModel> step0;
Map<dynamic, List<RadioModel>> step1Index;
Map<dynamic, List<RadioModel>> step3;

class _ContentState extends State<Content> {
  ApiService apiService = new ApiService();

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    step0 = [
      //car brand
      for (var j in widget.response.entries)
        RadioModel(false, j.key, Icons.directions_car),
    ];

    step1Index = {}; //car model
    for (var j in widget.list) {
      if (step1Index.containsKey(j.carBrand)) {
        step1Index.putIfAbsent(j.carBrand, () => null).add(
              RadioModel(false, j.model, Icons.local_shipping),
            );
      } else
        step1Index.addAll({
          j.carBrand: [
            RadioModel(false, j.model, Icons.local_shipping),
          ]
        });
    }
    step3 = {}; //year
    for (var j in widget.list) {
      step3.addAll({
        j.model: [
          for (var x = j.endYear; x >= j.startYear; x--)
            RadioModel(false, x.toString(), Icons.access_time_rounded),
        ]
      });
    }

/*
    step1Index.forEach((key, value) {
      print('$key: $value');
    });
    step3.forEach((key, value) {
      print('$key: $value');
    });*/

    print("Api List ${widget.list}");
    switch (widget.activeStep) {
      case 0:
        return Expanded(child: SelectableCard(options: step0, step: 0));

      case 1:
        return Expanded(
            child: SelectableCard(options: choiceNextStep(), step: 1));

      case 2:
        return Expanded(
          child: SelectableCard(options: choiceFinalStep(), step: 2),
        );
      case 3:
        return Expanded(child: FinalForm());
    }
  }
}

class FinalForm extends StatefulWidget {
  //GlobalKey<FormState> finalStepFormKey = GlobalKey<FormState>();
  // List<dynamic> answer = [0, 0, 0];
  @override
  _FinalFormState createState() => _FinalFormState();

  FinalForm();
}

class _FinalFormState extends State<FinalForm> {
  String Lang = 'en';
  @override
  void initState() {
    getCurrentLang();
    // TODO: implement initState
    super.initState();
    addNewCarRequestModel = new AddNewCarRequestModel();
  }

  getCurrentLang() async {
    getPrefCurrentLang().then((value) {
      setState(() {
        Lang = value;
      });
    });
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  final List<String> errors = [];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Center(
        child: Column(
          children: [
            /*Text(answer[0]),
            Text(answer[1]),
            Text(answer[2]),*/
            SizedBox(height: size.height * 0.01),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: buildFinalSelectedCards([
                    "assets/icons/b.svg",
                    "assets/icons/m.svg",
                    "assets/icons/y.svg"
                  ]))
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: size.width * 0.02, left: size.width * 0.02),
              child: Align(
                alignment:
                    Lang == "en" ? Alignment.centerLeft : Alignment.centerRight,
                child: Text(
                  getTranslated(
                      context, "Please enter selected car plates here"),
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Expanded(
              flex: 4,
              child: Form(
                key: finalStepFormKey,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              Expanded(
                                child: BuildCharPlateTextFormField(),
                              ),
                              Expanded(child: BuildNumPlateTextFormField()),
                            ],
                          ),
                          FormError(size: size, errors: errors),
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

  buildFinalSelectedCards(List img) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 2.5),
      ),
      itemCount: answer.length,
      itemBuilder: (context, index) {
        return Card(
            shape: false //sampleData[index].isSelected
                ? RoundedRectangleBorder(
                    side: BorderSide(color: Colors.redAccent, width: 2.0),
                    borderRadius: BorderRadius.circular(4.0))
                : RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[200], width: 3.0),
                    borderRadius: BorderRadius.circular(4.0)),
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.all(10),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {},
              child: GridTile(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    img[index],
                    //"assets/icons/google_logo.svg",
                    //  color: _item.isSelected ? Colors.redAccent : Colors.grey[500],
                    color: Colors.redAccent,
                    height: 28,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text(
                    answer[index],
                    style: TextStyle(
                      fontSize: 17,
                      // color: _item.isSelected ? Colors.redAccent : Colors.grey[500],
                    ),
                  ),
                ],
              )),
            ));
      },
    );
  }

  TextFormField BuildCharPlateTextFormField() {
    return TextFormField(
      maxLength: 3,
      maxLengthEnforced: true,
      inputFormatters: [
        // FilteringTextInputFormatter.deny(new RegExp(r'(?<!^)(\B|b)(?!$)'))
      ],
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: Lang == "en" ? "Characters" : "الحروف",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).hintColor, width: 2),
          borderRadius: Lang == 'en'
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(10), topLeft: Radius.circular(10))
              : BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).hintColor,
            ),
            borderRadius: Lang == 'en'
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10))
                : BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10))),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).hintColor,
            ),
            borderRadius: Lang == 'en'
                ? BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10))
                : BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10))),
      ),
      onSaved: (newValue) {
        winchPlatesChar = newValue;
        print(winchPlatesChar);
        //winchRegisterRequestModel.firstName = newValue;
        // setPrefFirstName(newValue);
        // setPrefWinchPlatesChars(newValue);
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: NullCharPlateError);
          removeError(error: SmallCharPlateError);
          return "";
        }
        if (value.length > 1 && value.length < 3) {
          removeError(error: SmallCharPlateError);
          removeError(error: LargeCharPlateError);
          return "";
        }
        if (value.length > 3) {
          addError(error: LargeCharPlateError);
          return "";
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: NullCharPlateError);
          return "";
        } else if (value.length == 1) {
          addError(error: SmallCharPlateError);
          return "";
        } else if (value.length > 3) {
          addError(error: LargeCharPlateError);
          return "";
        }
        return null;
      },
    );
  }

  TextFormField BuildNumPlateTextFormField() {
    return TextFormField(
      maxLength: 4,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: Lang == "en" ? "Numbers" : "الارقام",
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).hintColor,
            width: 2,
          ),
          borderRadius: Lang == 'en'
              ? BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10))
              : BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).hintColor,
            ),
            borderRadius: Lang == 'en'
                ? BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10))),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).hintColor,
            ),
            borderRadius: Lang == 'en'
                ? BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10))),
      ),
      onSaved: (newValue) {
        winchPlatesNum = newValue;
        print(winchPlatesNum);
        //winchRegisterRequestModel.firstName = newValue;
        // setPrefFirstName(newValue);
        //numPlatController.text = newValue;
        // setPrefWinchPlatesNum(newValue);
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: NullNumPlateError);
          removeError(error: SmallNumPlateError);
          return "";
        }
        if (value.length > 1) {
          removeError(error: SmallCharPlateError);
          return "";
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: NullNumPlateError);
          return "";
        } else if (value.length < 3) {
          addError(error: SmallNumPlateError);
          return "";
        } else if (value.length > 4) {
          addError(error: LargeCharPlateError);
          return "";
        }
        return null;
      },
    );
  }
}

List<RadioModel> choiceNextStep() {
  print("Selected Brand :${answer[0]}");
  return step1Index[answer[0]];

  /*if (answer[0] == 0) {
      return step1;
    } else {
      return step1_1;
    }*/
}

List<RadioModel> choiceFinalStep() {
  print("Selected Model :${answer[1]}");
  return step3[answer[1]];

  /*if (answer[0] == 0) {
      return step1;
    } else {
      return step1_1;
    }*/
}

class SelectableCard extends StatefulWidget {
  List<RadioModel> options;
  List<dynamic> answer = [0, 0, 0];
  //Future<List<CarModel>> cars;
  var finalList;
  int step;
  SelectableCard({@required this.options, @required this.step, this.answer});

  @override
  _SelectableCardState createState() => _SelectableCardState();
}

class _SelectableCardState extends State<SelectableCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<RadioModel> sampleData = new List<RadioModel>();
    sampleData = widget.options;
    print(sampleData.toString());
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.step == 2 ? 3 : 2,
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
                  answer[widget.step] = sampleData[index].time;
                  print(answer[widget.step]);
                });
              },
              child: GridTile(
                  child: GridTile(
                      child: RadioItem(sampleData[index])) //RadioItem(),
                  ),
            ));
      },
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  //String ID;
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

/*
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
    _getAllCars();
    sampleData = widget.options;
  }

  _getAllCars() {
    ApiService apiService = new ApiService();
    apiService.loadCarsData().then((response) {
      print(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getAllCars(),
      builder: (context, snapshot) {
        print("snapshot");
        print(snapshot.data);
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 12),
              ),
              itemCount: snapshot.data.length,
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
                        sampleData
                            .forEach((element) => element.isSelected = false);
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
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}
*/
