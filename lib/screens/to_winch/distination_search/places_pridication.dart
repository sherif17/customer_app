import 'package:customer_app/DataHandler/appData.dart';
import 'package:customer_app/models/maps/address.dart';
import 'package:customer_app/models/maps/placePredictions.dart';
import 'package:customer_app/services/maps_services/RequestAssistant.dart';
import 'package:customer_app/widgets/progress_Dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PredictionTile extends StatelessWidget {
  final PlacePredictions placePredictions;
  String currentLang;
  PredictionTile({Key key, this.placePredictions, this.currentLang})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FlatButton(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.008, vertical: size.height * 0.008),
      onPressed: () {
        getPlaceAddressDetails(placePredictions.place_id, context);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(
              width: 10.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.add_location,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  width: 14.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        placePredictions.main_text,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        placePredictions.secondary_text,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        ),
      ),
    );
  }

  void getPlaceAddressDetails(String placeId, context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
            message: currentLang == "en"
                ? "Setting DropOff, \n"
                    "Please wait...."
                : "تحديد نقطه الوصول ,\n انتظر قليلا.."));

    String mapKey = "AIzaSyAbT3_43qH7mG81Ufy4xS-GbqDjo9rrPAU";
    String placeDetailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey";

    var res = await RequestAssistant.getRequest(placeDetailsUrl);
    print(res);

    Navigator.pop(context);

    if (res == "failed") {
      return;
    }
    if (res["status"] == "OK") {
      Address address = Address();
      address.placeName = res["result"]["name"];
      address.placeId = placeId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];
      print("Drop off Address Latitude::");
      print(address.latitude);
      print("Drop Off Address Longitude::");
      print(address.longitude);

      Provider.of<AppData>(context, listen: false)
          .updateDropOffLocationAddress(address);
      print("Drop off address name :: " + address.placeName);

      Navigator.pop(context, "obtainDirection");
    }
  }
}
