import 'package:customer_app/models/maps/direction_details.dart';
import 'package:customer_app/services/maps_services/maps_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:customer_app/models/maps/address.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapsProvider extends ChangeNotifier {
  Address pickUpLocation;
  Address dropOffLocation;
  DirectionDetails tripDirectionDetails;
  int estimatedFare;
  Position currentPosition;
  GoogleMapController googleMapController;

  void updatePickUpLocationAddress(Address pickUpAddress) {
    pickUpLocation = pickUpAddress;
    pickUpLocation.descriptor = "PickUp";
    notifyListeners();
  }

  void updateDropOffLocationAddress(Address dropOffAddress) {
    dropOffLocation = dropOffAddress;
    dropOffLocation.descriptor = "DropOff";
    notifyListeners();
  }

  void updateTripDirectionDetails(DirectionDetails tripDetails) {
    tripDirectionDetails = tripDetails;
    notifyListeners();
  }

  void updateEstimatedFare(int fare) {
    estimatedFare = fare;
    notifyListeners();
  }

  void locatePosition(context) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        new CameraPosition(target: latLatPosition, zoom: 15.5);
    if (pickUpLocation != null) {}
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    Address pickUpAddress =
        await MapsApiService.searchCoordinateAddress(position, context);

    Provider.of<MapsProvider>(context, listen: false)
        .updatePickUpLocationAddress(pickUpAddress);

    print("This is your address:: " + pickUpAddress.placeName);
    notifyListeners();
  }
}
