import 'package:customer_app/provider/maps_preparation/mapsProvider.dart';
import 'package:customer_app/provider/winch_request/winch_request_provider.dart';
import 'package:customer_app/screens/to_winch/to_winch_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AcceptedWinchDriverSheet extends StatefulWidget {
  static String routeName = '/AcceptedWinchDriverSheet';
  @override
  _AcceptedWinchDriverSheetState createState() =>
      _AcceptedWinchDriverSheetState();
}

class _AcceptedWinchDriverSheetState extends State<AcceptedWinchDriverSheet> {
  @override
  Widget build(BuildContext context) {
    String driverFirstName = Provider.of<WinchRequestProvider>(context, listen: false).checkRequestStatusResponseModel.firstName;
    String driverLastName = Provider.of<WinchRequestProvider>(context, listen: false).checkRequestStatusResponseModel.lastName;
    String carPlates = Provider.of<WinchRequestProvider>(context, listen: false).checkRequestStatusResponseModel.winchPlates;

    LatLng winchPosition = LatLng(
        (Provider.of<WinchRequestProvider>(context, listen: false).checkRequestStatusResponseModel.driverLocationLat) as double,
        (Provider.of<WinchRequestProvider>(context, listen: false).checkRequestStatusResponseModel.driverLocationLong) as double,
    );

    
    String carType = "Chevrolet";
    String estimatedArrivalTime;

    int estimatedFare = Provider.of<MapsProvider>(context, listen: false).estimatedFare;
    String estimatedDuration = Provider.of<MapsProvider>(context, listen: false).tripDirectionDetails.durationText;
    int estimatedDurationInSec = Provider.of<MapsProvider>(context, listen: false).tripDirectionDetails.durationValue;

    DateTime currentTime = new DateTime.now();

        int estimatedArrivalSec = estimatedDurationInSec + currentTime.second + currentTime.minute * 60 + currentTime.hour * 3600;
        double hoursDouble = estimatedArrivalSec/3600;
        int hours = hoursDouble.floor();
        double minutesDouble = estimatedArrivalSec/60 - (hours*60);
        int minutes = minutesDouble.floor();
        if (hours > 23)
          {
            hours = hours - 24;
            estimatedArrivalTime = "Tomorrow " + hours.toString() + ":" + minutes.toString();
          }
        else
          {
            estimatedArrivalTime = hours.toString() + ":" + minutes.toString();
        }





    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Consumer<WinchRequestProvider>(
        builder: (context, val, child) => DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.22,
          maxChildSize: 1.0,
          builder: (BuildContext myContext, controller) {
            return SingleChildScrollView(
              controller: controller,
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 17.0,
                    horizontal: 15.0,
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: 6,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 40.0,
                                  //backgroundImage: exist ? NetworkImage(profilePhoto) : AssetImage("assets/icons/profile.png"),
                                  backgroundImage:
                                      AssetImage("assets/icons/profile.png"),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                Row(children: [
                                  Text(driverFirstName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(driverLastName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1),
                                ]),
                              ],
                            ),
                            Expanded(child: Container()),
                            Column(
                              children: [
                                Text(
                                  carPlates,
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                Text(
                                  carType,
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Text(
                                "Estimated arrival time",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              //SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                              Expanded(child: Container()),
                              Text(
                                estimatedArrivalTime,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Text(
                                "Estimated fare",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.2,
                              ),
                              Expanded(child: Container()),
                              Text(
                                "EGP $estimatedFare",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Text(
                                "Estimated trip duration",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              //SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
                              Expanded(child: Container()),
                              Text(
                                estimatedDuration,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              print("call winch driver");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.phone,
                                color: Theme.of(context).primaryColorDark,
                                size: 26.0,
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          OutlinedButton(
                            onPressed: () {
                              print("message winch driver");
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.message,
                                color: Theme.of(context).primaryColorDark,
                                size: 26.0,
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                          OutlinedButton(
                            onPressed: () async {
                              var res = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ToWinchMap()));
                            },
                            child: Padding(
                              padding: EdgeInsets.all(17.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Cancel",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  Icon(
                                    Icons.close,
                                    color: Theme.of(context).primaryColorDark,
                                    size: 26.0,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
