import 'package:customer_app/local_db/mechanic_services_db/break_down_model.dart';
import 'package:customer_app/models/mechanic_services/load_break_down_model.dart';
import 'package:customer_app/services/mechanic_services/mechanic_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MechanicServiceProvider extends ChangeNotifier {
  List<LoadBreakDownModel> breakDownApiList = [
    LoadBreakDownModel(
      id: "60a369134262f5368455aa54",
      category: "Exterior",
      problem: "عدم الاستجابة  لتوجية",
      subproblem: "صعوبة وتقل في الدركسيون",
      expectedFare: 0,
      v: 0,
    ),
    LoadBreakDownModel(
      id: "60a3691e4262f5368455aa55",
      category: "Exterior",
      problem: "عدم الاستجابة  لتوجية",
      subproblem: "طارة الدركسيون بتلف علي الفاضي",
      expectedFare: 0,
      v: 0,
    ),
    LoadBreakDownModel(
      id: "60a3695cb299754c4419c868",
      category: "Exterior",
      problem: "إطارات",
      subproblem: "انفجار  في احد الإطارات  و يوجد استبن  سليم بالسيارة",
      expectedFare: 0,
      v: 0,
    ),
    LoadBreakDownModel(
      id: "60a3695cb299754c4419c868",
      category: "Exterior",
      problem: "إطارات",
      subproblem: "انفجار  في احد الإطارات  ولا يوجد استبن  سليم بالسيارة",
      expectedFare: 0,
      v: 0,
    ),
    LoadBreakDownModel(
      id: "60a369984d78ab4b98dc983b",
      category: "Engine",
      problem: "توقف فجائي لمحرك السيارة",
      subproblem: "نفاذ الوقود",
      expectedFare: 0,
      v: 0,
    )
  ];
  //List<LoadBreakDownModel> breakDownApiList = [];
  // Box<BreakDownDB> breakDownDB = Hive.box<BreakDownDB>("BreakDownDB");
  Map<dynamic, List<dynamic>> mapOne = {};
  Map<dynamic, List<dynamic>> mapTwo = {};

  Map<dynamic, Map<dynamic, List<dynamic>>> mapThree = {};
  MechanicApiServices mechanicApiServices = new MechanicApiServices();
  bool loading;

  int selectedIndex = 0;
  SwiperController scrollController = new SwiperController();
  TabController tabController;

  getCurrentIndex(index) {
    selectedIndex = index;
    print("current swiped index ${index + 1}");
    notifyListeners();
  }

  getCurrentTab(index) {
    scrollController.move(index);
    print("current Tabbed index ${index + 1}");
    notifyListeners();
  }

  getBreakDownListFromBackend() async {
    loading = true;
    breakDownApiList = await mechanicApiServices.loadBreakDownData();
    loading = false;
    breakDownApiList.forEach((element) {
      print(element);
    });
  }

  getItems() {
    for (var j in breakDownApiList) {
      if (mapOne.containsKey(j.category)) {
        mapOne.putIfAbsent(j.category, () => null).add(
            [j.id, j.category, j.problem, j.subproblem, j.expectedFare, j.v]);
      } else
        mapOne.addAll({
          j.category: [
            j.id,
            j.category,
            j.problem,
            j.subproblem,
            j.expectedFare,
            j.v
          ]
        });
    }
    mapOne.forEach((key, value) {
      print('$key: ${value}');
    });
  }

  getBreakDownByCategory() {
    for (var j in breakDownApiList) {
      if (mapThree.containsKey(j.category)) {
        if (mapThree.values.map((e) => e.containsKey(j.problem)).toString() ==
            "(true)") {
          mapThree
              .putIfAbsent(j.category, () => null)
              .putIfAbsent(j.problem, () => null)
              .add([
            j.id,
            //j.category,
            //j.problem,
            j.subproblem,
            j.expectedFare,
            j.v
          ]);
        } else if (mapThree.values
                .map((e) => e.containsKey(j.problem))
                .toString() ==
            "(false)") {
          mapThree.putIfAbsent(j.category, () => null).addAll({
            j.problem: [
              j.id,
              //j.category,
              //j.problem,
              j.subproblem,
              j.expectedFare,
              j.v
            ]
          });
        }
      } else {
        mapThree.addAll({
          j.category: {
            j.problem: [
              j.id,
              // j.category,
              //j.problem,
              j.subproblem,
              j.expectedFare,
              j.v
            ]
          }
        });
      }
    }
    notifyListeners();
    mapThree.forEach((key, value) {
      print('${key}: ${value}');
    });
  }

  getServicesByProblems() {
    for (var j in breakDownApiList) {
      if (mapThree.containsKey(j.problem)) {
        mapThree
            .putIfAbsent(j.problem, () => null)
            .putIfAbsent(j.category, () => null)
            .add([
          j.id,
          //j.category,
          //j.problem,
          j.subproblem,
          j.expectedFare,
          j.v
        ]);
      } else
        mapThree.addAll({
          j.problem: {
            j.category: [
              j.id,
              // j.category,
              //j.problem,
              j.subproblem,
              j.expectedFare,
              j.v
            ]
          }
        });
    }
    notifyListeners();
    mapThree.forEach((key, value) {
      print('$key: ${value}');
    });
  }
}
