//
// import 'package:customer_app/models/cars/add_new_car_model.dart';
// import 'package:customer_app/services/api_services.dart';
// import 'package:customer_app/shared_prefrences/customer_user_model.dart';
// import 'package:customer_app/utils/constants.dart';
// import 'package:customer_app/widgets/form_error.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class Content extends StatefulWidget {
//   GlobalKey<FormState> finalStepFormKey = GlobalKey<FormState>();
//   List<dynamic> answer = [0, 0, 0];
//   var list;
//   Map<String, List<dynamic>> response = {};
//   Content(
//       {Key key,
//         @required this.activeStep,
//         this.list,
//         this.response,
//         this.finalStepFormKey,this.answer})
//       : super(key: key);
//
//   final int activeStep;
//
//   @override
//   _ContentState createState() => _ContentState();
// }
//
// List<RadioModel> step0;
// Map<dynamic, List<RadioModel>> step1Index;
// Map<dynamic, List<RadioModel>> step3;
//
// class _ContentState extends State<Content> {
//   ApiService apiService = new ApiService();
//
//   initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     step0 = [
//       //car brand
//       for (var j in widget.response.entries)
//         RadioModel(false, j.key, Icons.directions_car),
//     ];
//
//     step1Index = {}; //car model
//     for (var j in widget.list) {
//       if (step1Index.containsKey(j.carBrand)) {
//         step1Index.putIfAbsent(j.carBrand, () => null).add(
//           RadioModel(false, j.model, Icons.local_shipping),
//         );
//       } else
//         step1Index.addAll({
//           j.carBrand: [
//             RadioModel(false, j.model, Icons.local_shipping),
//           ]
//         });
//     }
//     step3 = {}; //year
//     for (var j in widget.list) {
//       step3.addAll({
//         j.model: [
//           for (var x = j.endYear; x >= j.startYear; x--)
//             RadioModel(false, x.toString(), Icons.access_time_rounded),
//         ]
//       });
//     }
//
// /*
//     step1Index.forEach((key, value) {
//       print('$key: $value');
//     });
//     step3.forEach((key, value) {
//       print('$key: $value');
//     });*/
//
//     print("Api List ${widget.list}");
//     switch (widget.activeStep) {
//       case 0:
//         return Expanded(child: SelectableCard(options: step0, step: 0,answer: widget.answer,));
//
//       case 1:
//         return Expanded(
//             child: SelectableCard(options: choiceNextStep(), step: 1,answer: widget.answer,));
//
//       case 2:
//         return Expanded(
//           child: SelectableCard(options: choiceFinalStep(), step: 2),);
//       case 3:
//         return Expanded(child: FinalForm(widget.finalStepFormKey,widget.answer));
//     }
//   }
// }
//
// class FinalForm extends StatefulWidget {
//   GlobalKey<FormState> finalStepFormKey = GlobalKey<FormState>();
//   List<dynamic> answer = [0, 0, 0];
//   @override
//   _FinalFormState createState() => _FinalFormState();
//
//   FinalForm(this.finalStepFormKey,this.answer);
// }
//
// class _FinalFormState extends State<FinalForm> {
//   String Lang = 'en';
//   @override
//   void initState() {
//     getCurrentLang();
//     // TODO: implement initState
//     super.initState();
//     addNewCarRequestModel = new AddNewCarRequestModel();
//   }
//
//   getCurrentLang() async {
//     getPrefCurrentLang().then((value) {
//       Lang = value;
//     });
//   }
//
//   void addError({String error}) {
//     if (!errors.contains(error))
//       setState(() {
//         errors.add(error);
//       });
//   }
//
//   void removeError({String error}) {
//     if (errors.contains(error))
//       setState(() {
//         errors.remove(error);
//       });
//   }
//
//   final List<String> errors = [];
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       child: Center(
//         child: Column(
//           children: [
//             /*Text(answer[0]),
//             Text(answer[1]),
//             Text(answer[2]),*/
//             SizedBox(height: size.height * 0.01),
//             Expanded(
//               flex: 3,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Expanded(
//                       child: buildFinalSelectedCards([
//                         "assets/icons/b.svg",
//                         "assets/icons/m.svg",
//                         "assets/icons/y.svg"
//                       ]))
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: size.height * 0.03,
//             ),
//             Expanded(
//               flex: 4,
//               child: Form(
//                 key: widget.finalStepFormKey,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding:
//                       EdgeInsets.symmetric(horizontal: size.width * 0.05),
//                       child: Column(
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.baseline,
//                             children: [
//                               Expanded(
//                                 child: BuildCharPlateTextFormField(),
//                               ),
//                               Expanded(child: BuildNumPlateTextFormField()),
//                             ],
//                           ),
//                           FormError(size: size, errors: errors),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   buildFinalSelectedCards(List img) {
//     return GridView.builder(
//       shrinkWrap: true,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         childAspectRatio: MediaQuery.of(context).size.width /
//             (MediaQuery.of(context).size.height / 2.5),
//       ),
//       itemCount: widget.answer.length,
//       itemBuilder: (context, index) {
//         return Card(
//             shape: false //sampleData[index].isSelected
//                 ? RoundedRectangleBorder(
//                 side: BorderSide(color: Colors.redAccent, width: 2.0),
//                 borderRadius: BorderRadius.circular(4.0))
//                 : RoundedRectangleBorder(
//                 side: BorderSide(color: Colors.grey[200], width: 3.0),
//                 borderRadius: BorderRadius.circular(4.0)),
//             color: Colors.white,
//             elevation: 0,
//             margin: EdgeInsets.all(10),
//             child: InkWell(
//               splashColor: Colors.transparent,
//               highlightColor: Colors.transparent,
//               onTap: () {},
//               child: GridTile(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       SvgPicture.asset(
//                         img[index],
//                         //"assets/icons/google_logo.svg",
//                         //  color: _item.isSelected ? Colors.redAccent : Colors.grey[500],
//                         color: Colors.redAccent,
//                         height: 28,
//                       ),
//                       SizedBox(height: MediaQuery.of(context).size.height * 0.01),
//                       Text(
//                         widget.[index],
//                         style: TextStyle(
//                           fontSize: 17,
//                           // color: _item.isSelected ? Colors.redAccent : Colors.grey[500],
//                         ),
//                       ),
//                     ],
//                   )),
//             ));
//       },
//     );
//   }
//
//   TextFormField BuildCharPlateTextFormField() {
//     return TextFormField(
//       maxLength: 3,
//       maxLengthEnforced: true,
//       inputFormatters: [
//         // FilteringTextInputFormatter.deny(new RegExp(r'(?<!^)(\B|b)(?!$)'))
//       ],
//       keyboardType: TextInputType.name,
//       decoration: InputDecoration(
//         labelText: "Characters",
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Theme.of(context).hintColor, width: 2),
//           borderRadius: Lang == 'en'
//               ? BorderRadius.only(
//               bottomLeft: Radius.circular(10), topLeft: Radius.circular(10))
//               : BorderRadius.only(
//               bottomRight: Radius.circular(10),
//               topRight: Radius.circular(10)),
//         ),
//         enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).hintColor,
//             ),
//             borderRadius: Lang == 'en'
//                 ? BorderRadius.only(
//                 bottomLeft: Radius.circular(10),
//                 topLeft: Radius.circular(10))
//                 : BorderRadius.only(
//                 bottomRight: Radius.circular(10),
//                 topRight: Radius.circular(10))),
//         errorBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).hintColor,
//             ),
//             borderRadius: Lang == 'en'
//                 ? BorderRadius.only(
//                 bottomLeft: Radius.circular(10),
//                 topLeft: Radius.circular(10))
//                 : BorderRadius.only(
//                 bottomRight: Radius.circular(10),
//                 topRight: Radius.circular(10))),
//       ),
//       onSaved: (newValue) {
//         winchPlatesChar = newValue;
//         print(winchPlatesChar);
//         //winchRegisterRequestModel.firstName = newValue;
//         // setPrefFirstName(newValue);
//         // setPrefWinchPlatesChars(newValue);
//       },
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           removeError(error: NullCharPlateError);
//           removeError(error: SmallCharPlateError);
//           return "";
//         }
//         if (value.length > 1 && value.length < 3) {
//           removeError(error: SmallCharPlateError);
//           removeError(error: LargeCharPlateError);
//           return "";
//         }
//         if (value.length > 3) {
//           addError(error: LargeCharPlateError);
//           return "";
//         }
//         return null;
//       },
//       validator: (value) {
//         if (value.isEmpty) {
//           addError(error: NullCharPlateError);
//           return "";
//         } else if (value.length == 1) {
//           addError(error: SmallCharPlateError);
//           return "";
//         } else if (value.length > 3) {
//           addError(error: LargeCharPlateError);
//           return "";
//         }
//         return null;
//       },
//     );
//   }
//
//   TextFormField BuildNumPlateTextFormField() {
//     return TextFormField(
//       maxLength: 4,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         labelText: "Numbers",
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Theme.of(context).hintColor,
//             width: 2,
//           ),
//           borderRadius: Lang == 'en'
//               ? BorderRadius.only(
//               bottomRight: Radius.circular(10),
//               topRight: Radius.circular(10))
//               : BorderRadius.only(
//               bottomLeft: Radius.circular(10),
//               topLeft: Radius.circular(10)),
//         ),
//         enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).hintColor,
//             ),
//             borderRadius: Lang == 'en'
//                 ? BorderRadius.only(
//                 bottomRight: Radius.circular(10),
//                 topRight: Radius.circular(10))
//                 : BorderRadius.only(
//                 bottomLeft: Radius.circular(10),
//                 topLeft: Radius.circular(10))),
//         errorBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Theme.of(context).hintColor,
//             ),
//             borderRadius: Lang == 'en'
//                 ? BorderRadius.only(
//                 bottomRight: Radius.circular(10),
//                 topRight: Radius.circular(10))
//                 : BorderRadius.only(
//                 bottomLeft: Radius.circular(10),
//                 topLeft: Radius.circular(10))),
//       ),
//       onSaved: (newValue) {
//         winchPlatesNum = newValue;
//         print(winchPlatesNum);
//         //winchRegisterRequestModel.firstName = newValue;
//         // setPrefFirstName(newValue);
//         //numPlatController.text = newValue;
//         // setPrefWinchPlatesNum(newValue);
//       },
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           removeError(error: NullNumPlateError);
//           removeError(error: SmallNumPlateError);
//           return "";
//         }
//         if (value.length > 1) {
//           removeError(error: SmallCharPlateError);
//           return "";
//         }
//         return null;
//       },
//       validator: (value) {
//         if (value.isEmpty) {
//           addError(error: NullNumPlateError);
//           return "";
//         } else if (value.length < 3) {
//           addError(error: SmallNumPlateError);
//           return "";
//         } else if (value.length > 4) {
//           addError(error: LargeCharPlateError);
//           return "";
//         }
//         return null;
//       },
//     );
//   }
// }
//
// List<RadioModel> choiceNextStep() {
//   print("Selected Brand :${answer[0]}");
//   return step1Index[answer[0]];
//
//   /*if (answer[0] == 0) {
//       return step1;
//     } else {
//       return step1_1;
//     }*/
// }
//
// List<RadioModel> choiceFinalStep() {
//   print("Selected Model :${answer[1]}");
//   return step3[answer[1]];
//
//   /*if (answer[0] == 0) {
//       return step1;
//     } else {
//       return step1_1;
//     }*/
// }
//
// class SelectableCard extends StatefulWidget {
//   List<RadioModel> options;
//   List<dynamic> answer = [0, 0, 0];
//   //Future<List<CarModel>> cars;
//   var finalList;
//   int step;
//   SelectableCard({@required this.options, @required this.step,this.answer});
//
//   @override
//   _SelectableCardState createState() => _SelectableCardState();
// }
//
// class _SelectableCardState extends State<SelectableCard> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<RadioModel> sampleData = new List<RadioModel>();
//     sampleData = widget.options;
//     print(sampleData.toString());
//     return GridView.builder(
//       shrinkWrap: true,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: widget.step == 2 ? 3 : 2,
//         childAspectRatio: MediaQuery.of(context).size.width /
//             (MediaQuery.of(context).size.height / 2.5),
//       ),
//       itemCount: sampleData.length,
//       itemBuilder: (context, index) {
//         return Card(
//             shape: sampleData[index].isSelected
//                 ? RoundedRectangleBorder(
//                 side: BorderSide(color: Colors.redAccent, width: 2.0),
//                 borderRadius: BorderRadius.circular(4.0))
//                 : RoundedRectangleBorder(
//                 side: BorderSide(color: Colors.grey[200], width: 2.0),
//                 borderRadius: BorderRadius.circular(4.0)),
//             color: Colors.white,
//             elevation: 0,
//             child: InkWell(
//               splashColor: Colors.transparent,
//               highlightColor: Colors.transparent,
//               onTap: () {
//                 setState(() {
//                   sampleData.forEach((element) => element.isSelected = false);
//                   sampleData[index].isSelected = true;
//                   print('step ${widget.step}');
//                   print('index ${index}');
//                   widget.[widget.step] = sampleData[index].time;
//                   print(answer[widget.step]);
//                 });
//               },
//               child: GridTile(
//                   child: GridTile(
//                       child: RadioItem(sampleData[index])) //RadioItem(),
//               ),
//             ));
//       },
//     );
//   }
// }
//
// class RadioItem extends StatelessWidget {
//   final RadioModel _item;
//   //String ID;
//   RadioItem(this._item);
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: FlatButton(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Icon(
//               _item.icon,
//               color: _item.isSelected ? Colors.redAccent : Colors.grey[500],
//               size: 35,
//             ),
//             Text(
//               _item.time,
//               style: TextStyle(
//                 fontSize: 15,
//                 color: _item.isSelected ? Colors.redAccent : Colors.grey[500],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class RadioModel {
//   bool isSelected;
//   String time;
//   IconData icon;
//   RadioModel(this.isSelected, this.time, this.icon);
// }
