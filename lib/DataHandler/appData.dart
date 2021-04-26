import 'package:customer_app/models/maps/direction_details.dart';
import 'package:flutter/cupertino.dart';
//import 'file:///G:/Programming/Projects/Flutter/AndroidStudio/GradProject/customer_app_1/lib/models/maps/address.dart';
import 'package:customer_app/models/maps/address.dart';

class AppData extends ChangeNotifier
{
  Address pickUpLocation;
  Address dropOffLocation;
  DirectionDetails tripDirectionDetails;
  int estimatedFare;

  void updatePickUpLocationAddress(Address pickUpAddress)
  {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Address dropOffAddress)
  {
    dropOffLocation = dropOffAddress;
    notifyListeners();
  }

  void updateTripDirectionDetails(DirectionDetails tripDetails)
  {
    tripDirectionDetails = tripDetails;
    notifyListeners();
  }

  void updateEstimatedFare(int fare)
  {
    estimatedFare = fare;
    notifyListeners();
  }

}