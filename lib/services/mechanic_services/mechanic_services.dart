import 'package:customer_app/models/mechanic_services/load_break_down_model.dart';
import 'package:customer_app/models/mechanic_services/load_routine_maintanence_model.dart';
import 'package:http/http.dart' as http;

class MechanicApiServices {
  Future<List<LoadBreakDownModel>> loadBreakDownData() async {
    //Load All Car Blocks from Backend
    Uri url = Uri.parse('http://161.97.155.244/api/info/GetAllProblems');
    final response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return LoadBreakDownModel.parseBreakDowns(response.body);
    } else {
      throw Exception("failed to load Data");
    }
  }

  Future<List<LoadRoutineMaintenanceModel>> loadRoutineMaintenance() async {
    //Load All Car Blocks from Backend
    Uri url = Uri.parse('http://161.97.155.244/api/info/GetAllServices');
    final response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print("response.body:${response.body}");
      return LoadRoutineMaintenanceModel.parseRoutineMaintenance(response.body);
    } else {
      throw Exception("failed to load Data");
    }
  }
}
