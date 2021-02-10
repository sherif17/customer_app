import 'package:customer_app/DataHandler/appData.dart';
import 'package:customer_app/models/placePredictions.dart';
import 'package:customer_app/services/RequestAssistant.dart';
import 'package:customer_app/widgets/divider.dart';
import 'package:customer_app/widgets/progress_Dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customer_app/models/address.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}


  class _SearchScreenState extends State<SearchScreen> {

    TextEditingController pickUpTextEditingController = TextEditingController();
    TextEditingController dropOffTextEditingController = TextEditingController();
    List<PlacePredictions> placePredictionList = [];


  @override
    Widget build(BuildContext context) {
    String placeAddress = Provider.of<AppData>(context).pickUpLocation.placeName ?? "";
    pickUpTextEditingController.text = placeAddress;


    Size size = MediaQuery.of(context).size;
        return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
              height: size.height * 0.30,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 6.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7,0.7),
                    ),
                  ],
                ),

                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.02, vertical: size.height * 0.02),
                  child: Column(
                      children: [
                  SizedBox(height: size.height * 0.05),
                        Stack(
                          children: [
                            GestureDetector(
                                onTap:(){
                                  Navigator.pop(context);
                                },
                                child: Icon(Icons.arrow_back)
                            ),
                            Center(
                              child: Text("Set Drop Off", style: Theme.of(context).textTheme.bodyText2,),
                            ),
                          ],
                        ),

                  SizedBox(height: size.height * 0.016),
                  Row(
                    children: [
                      //Image.asset("images/pickicon.png", height: 16.0, width: 16.0,),
                      Icon(
                        Icons.location_pin,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(height: size.height * 0.018,),
                      Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              //color: Colors.grey[400],
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: TextField(
                                controller: pickUpTextEditingController,
                                decoration: InputDecoration(
                                  hintText: "Pickup Location",
                                  fillColor: Theme.of(context).accentColor,
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(left: 11.0, top: 8.0, bottom: 8.0,),
                                ),
                              ),
                            ),


                          ),
                      ),

                    ],
                  ),

                  SizedBox(height: size.height * 0.01),
                  Row(
                    children: [
                      //Image.asset("images/desticon.png", height: 16.0, width: 16.0,),
                      Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(height: size.height * 0.018,),
                      Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              //color: Colors.grey[400],
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: TextField(
                                onChanged: (val) {
                                  findPlace(val);
                                },
                                controller: dropOffTextEditingController,
                                decoration: InputDecoration(
                                  hintText: "Where to?",
                                  fillColor: Theme.of(context).accentColor,
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(left: 11.0, top: 8.0, bottom: 8.0,),
                                ),
                              ),
                            ),


                          ),
                      ),



                    ],
                  ),

                ]
                ),
                  ),

                ),

                  SizedBox(height: 10.0,),
                  (placePredictionList.length > 0)
                      ? Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0,),
                            child: ListView.separated(
                                padding: EdgeInsets.all(0.0),
                                itemBuilder: (context, index){
                                  return PredictionTile(placePredictions: placePredictionList[index],);
                                },
                                separatorBuilder: (BuildContext context, int index) => DividerWidget(),
                                itemCount: placePredictionList.length,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),

                            ),

                  )
                      : Container(


                  ),

                  SizedBox(height: 24.0),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.2),
                    child: Row(
                      children: [
                        Icon(
                          Icons.push_pin, color: Theme
                            .of(context)
                            .primaryColorDark,),
                        SizedBox(width: 12.0,),
                        GestureDetector(
                          child: Text(
                              "Set A location on the map"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Padding(
                    padding: EdgeInsets.only(left: size.width*0.07,),
                    child: Row(
                      children: [
                        Icon(Icons.home, color: Theme
                            .of(context)
                            .primaryColorDark,),
                        SizedBox(width: 12.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          children: [
                            Text("Add Home"),
                            SizedBox(height: 4.0,),
                            Text(
                              "Your living home address",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1,),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  DividerWidget(),
                  SizedBox(height: 18.0),
                  Padding(
                    padding: EdgeInsets.only(left: size.width*0.07,),
                    child: Row(
                      children: [
                        Icon(Icons.work, color: Theme
                            .of(context)
                            .primaryColorDark,),
                        SizedBox(width: 12.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start,
                          children: [
                            Text("Add Work"),
                            SizedBox(height: 4.0,),
                            Text("Your office address",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyText1,),
                          ],
                        )
                      ],
                    ),
                  ),


                ],
              ),
            ),

);

}


void findPlace(String placeName) async {
    String mapKey = "AIzaSyAbT3_43qH7mG81Ufy4xS-GbqDjo9rrPAU";
    if (placeName.length > 1)
      {
        String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=1234567890&components=country:eg";
        
        var res = await RequestAssistant.getRequest(autoCompleteUrl);

        if(res == "failed")
          {
            return;
          }
        //print("Places Predictions Response :: ");
        //print(res);
        if (res["status"] == "OK")
          {
            var predictions = res["predictions"];

            var placeList = (predictions as List).map((e) => PlacePredictions.fromJson(e)).toList();
            setState(() {
              placePredictionList = placeList;

            });
          }
      }

}


}

class PredictionTile extends StatelessWidget
{
  final PlacePredictions placePredictions;
  PredictionTile({Key key, this.placePredictions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FlatButton(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.008, vertical: size.height * 0.008),
      onPressed: (){
        getPlaceAddressDetails(placePredictions.place_id, context);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(width: 10.0,),
             Row(
              children: [
                Icon(Icons.add_location, color: Theme.of(context).primaryColor,),
                SizedBox(width: 14.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0,),
                      Text(placePredictions.main_text, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyText2,),
                      SizedBox(height: 8.0,),
                      Text(placePredictions.secondary_text, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodyText1,),
                      SizedBox(height: 8.0,),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: 10.0,),
          ],

      ),
      ),
    );
  }

  void getPlaceAddressDetails (String placeId, context) async
  {

    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(message: "Setting DropOff, \n"
            "Please wait....")
    );

    String mapKey = "AIzaSyAbT3_43qH7mG81Ufy4xS-GbqDjo9rrPAU";
    String placeDetailsUrl = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey";

    var res = await RequestAssistant.getRequest(placeDetailsUrl);
    print(res);

    Navigator.pop(context);

    if (res == "failed")
      {
        return;
      }
    if (res["status"] == "OK")
      {
        Address address = Address();
        address.placeName = res["result"]["name"];
        address.placeId = placeId;
        address.latitude = res["result"]["geometry"]["location"]["lat"];
        address.longitude = res["result"]["geometry"]["location"]["lng"];
        print("Drop off Address Latitude::");
        print(address.latitude);
        print("Drop Off Address Longitude::");
        print(address.longitude);

        Provider.of<AppData>(context, listen: false).updateDropOffLocationAddress(address);
        //print("This is drop off location :: $address");
        print("Drop off address name :: " + address.placeName);
      }
  }

}
