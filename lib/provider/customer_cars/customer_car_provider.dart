import 'package:customer_app/local_db/cutomer_owned_cars_model.dart';
import 'package:customer_app/models/cars/add_new_car_model.dart';
import 'package:customer_app/models/cars/load_user_cars_model.dart';
import 'package:customer_app/services/car_services/car_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

class CustomerCarProvider extends ChangeNotifier {
  List customerOwnedCarList = [];
  Box<customerOwnedCarsDB> customerOwnedCars =
      Hive.box<customerOwnedCarsDB>("customerCarsDBBox");
  CarApiService carApiService = new CarApiService();
  AddNewCarResponseModel addNewCarResponseModel = AddNewCarResponseModel();
  bool loading = false;
  int currentIndex = 0;

  getCurrentIndex(index) {
    currentIndex = index;
    notifyListeners();
  }

  getCustomerCarsFromBackend(token) async {
    if (customerOwnedCars.isEmpty) {
      loading = true;
      customerOwnedCarList = await carApiService.loadUserCars(token);
      loading = false;
      for (var x in customerOwnedCarList) {
        addNewCarToDB(
            id: x.id,
            carBrand: x.carBrand,
            model: x.model,
            plates: x.plates,
            year: x.year,
            ownerId: x.ownerId,
            v: x.v);
      }
      notifyListeners();
    }
  }

  addNewCarToDB({id, carBrand, model, plates, year, ownerId, v}) {
    customerOwnedCarsDB carInfo = customerOwnedCarsDB(
        id: id,
        CarBrand: carBrand,
        Model: model,
        Plates: plates,
        Year: year.toString(),
        OwnerId: ownerId,
        v: v.toString());
    customerOwnedCars.put(id, carInfo);
    notifyListeners();
  }

  postNewCarToBackend(addNewCarRequestModel, token) async {
    loading = true;
    addNewCarResponseModel =
        await carApiService.addUserNewCar(addNewCarRequestModel, token);
    loading = false;
    print(addNewCarResponseModel.id);
    notifyListeners();
  }

  deleteCustomerCars(id) {
    customerOwnedCars.delete(id);
    notifyListeners();
  }
}
