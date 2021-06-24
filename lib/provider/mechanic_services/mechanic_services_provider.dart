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
      id: "60a369f7fad68b17c41f6759",
      category: "Engine",
      problem: "محرك السيارة لا يستجيب  لمحاولة إعادة الدوارة",
      v: 0,
    ),
    LoadBreakDownModel(
      id: "60a369984d78ab4b98dc983b",
      category: "Engine",
      problem: "توقف فجائي لمحرك السيارة",
      subproblem: "نفاذ الوقود",
      expectedFare: 0,
      v: 0,
    ),
    LoadBreakDownModel(
      id: "60a3691e4262f5368455aa66",
      category: "Exterior",
      problem: "اضائة لمبة البطارية",
      subproblem: "تم استبدال البطارية خلال عام",
      expectedFare: 0,
      v: 0,
    ),
    LoadBreakDownModel(
      id: "60a3691e4262f5368455aa68",
      category: "chassis",
      problem: "حادث",
      subproblem: "مطلوب اصلاح مؤقت لتتمكن السيارة من استكمال الرحلة",
      expectedFare: 0,
      v: 0,
    ),
    LoadBreakDownModel(
      id: "60a3691e4262f5368455aa67",
      category: "Interior",
      problem: "الفرامل",
      subproblem: "لايوجد فرامل في السيارة",
      expectedFare: 0,
      v: 0,
    ),
    LoadBreakDownModel(
      id: "60a3691e4262f5368455aa67",
      category: "Interior",
      problem: "الفرامل",
      subproblem: "وجود صوت في احد العجلات عند الضغط علي بدال الفرامل",
      expectedFare: 0,
      v: 0,
    ),
  ];
  //List<LoadBreakDownModel> breakDownApiList = [];
  // Box<BreakDownDB> breakDownDB = Hive.box<BreakDownDB>("BreakDownDB");
  Map<dynamic, List<LoadBreakDownModel>> mapOne = {};
  Map<dynamic, List<dynamic>> mapTwo = {};

  Map<dynamic, Map<dynamic, List<LoadBreakDownModel>>> breakDownsByCategoryMap =
      {};
  // Map<dynamic, Map<dynamic, List<LoadBreakDownModel>>> breakDownsByProblemsMap =
  //     {};
  List<dynamic> convertedListOfCategoryKeys;
  List<Map<dynamic, List<LoadBreakDownModel>>> convertedListOfCategoryValues;

  // List<LoadBreakDownModel> convertedListOfProblemsKeys;
  // List<Map<dynamic, List<LoadBreakDownModel>>> convertedListOfProblemsValues;

  MechanicApiServices mechanicApiServices = new MechanicApiServices();

  bool loading;
  List<List<LoadBreakDownModel>> onItemTapList;
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

  onTapList(selectedIndex) {
    onItemTapList = mapOne.values.toList(); //mapOne.entries.toList();
    //print(onItemTap);
    // print(onItemTapList[selectedIndex].length);
    notifyListeners();
  }

  getItems() {
    for (var j in breakDownApiList) {
      if (mapOne.containsKey(j.category)) {
        mapOne.putIfAbsent(j.category, () => null).add(LoadBreakDownModel(
            id: j.id,
            category: j.category,
            problem: j.problem,
            subproblem: j.subproblem,
            expectedFare: j.expectedFare,
            v: j.v));
      } else
        mapOne.addAll({
          j.category: [
            LoadBreakDownModel(
                id: j.id,
                category: j.category,
                problem: j.problem,
                subproblem: j.subproblem,
                expectedFare: j.expectedFare,
                v: j.v)
          ]
        });
    }
    mapOne.forEach((key, value) {
      print('$key: ${value}');
    });
  }

  getBreakDownByCategory() {
    print(breakDownApiList.length);
    for (var j in breakDownApiList) {
      if (breakDownsByCategoryMap.containsKey(j.category)) {
        print(breakDownsByCategoryMap.values
            .any((element) => element.containsKey(j.problem)));
        if (breakDownsByCategoryMap.values
                .any((element) => element.containsKey(j.problem)) ==
            true) {
          breakDownsByCategoryMap
              .putIfAbsent(j.category, () => null)
              .putIfAbsent(j.problem, () => null)
              .add(LoadBreakDownModel(
                  id: j.id,
                  // category: j.category,
                  problem: j.problem,
                  subproblem: j.subproblem,
                  expectedFare: j.expectedFare,
                  v: j.v));
        } else if (breakDownsByCategoryMap.values
                .any((element) => element.containsKey(j.problem)) ==
            false) {
          // print(breakDownsByCategoryMap.values
          //     .elementAt(counter)
          //     .containsKey(j.problem));

          // print(breakDownsByCategoryMap.values
          //     .map((e) => e.containsKey(j.problem))
          //     .toString());
          breakDownsByCategoryMap.putIfAbsent(j.category, () => null).addAll({
            j.problem: [
              LoadBreakDownModel(
                  id: j.id,
                  // category: j.category,
                  problem: j.problem,
                  subproblem: j.subproblem,
                  expectedFare: j.expectedFare,
                  v: j.v)
            ]
          });
        } else
          print("error");
      } else {
        print("new  category ${j.category}");
        breakDownsByCategoryMap.addAll({
          j.category: {
            j.problem: [
              LoadBreakDownModel(
                  id: j.id,
                  // category: j.category,
                  problem: j.problem,
                  subproblem: j.subproblem,
                  expectedFare: j.expectedFare,
                  v: j.v)
            ]
          }
        });
      }
    }
    breakDownsByCategoryMap.forEach((key, value) {
      print('${key}: ${value}');
    });
    convertedListOfCategoryKeys = breakDownsByCategoryMap.keys.toList();
    convertedListOfCategoryValues = breakDownsByCategoryMap.values.toList();
    notifyListeners();
    //print(convertedListOfCategoryValues[0].values.elementAt(0)[2].subproblem);
  }

  // getBreakDownByCategory() {
  //   print(breakDownApiList.length);
  //   for (var j in breakDownApiList) {
  //     if (breakDownsByCategoryMap.containsKey(j.category)) {
  //       print(breakDownsByCategoryMap.values.elementAt(0));
  //       // .map((e) => e.keys.toList() /*containsKey(j.problem)*/));
  //       if (breakDownsByCategoryMap.values
  //           .map((e) => e.containsKey(j.problem))
  //           .toString() ==
  //           "(true)") {
  //         breakDownsByCategoryMap
  //             .putIfAbsent(j.category, () => null)
  //             .putIfAbsent(j.problem, () => null)
  //             .add(LoadBreakDownModel(
  //             id: j.id,
  //             // category: j.category,
  //             // problem: j.problem,
  //             subproblem: j.subproblem,
  //             expectedFare: j.expectedFare,
  //             v: j.v));
  //       } else if (breakDownsByCategoryMap.values
  //           .map((e) => e.containsKey(j.problem))
  //           .toString() ==
  //           "(false)") {
  //         // print(breakDownsByCategoryMap.values
  //         //     .map((e) => e.containsKey(j.problem))
  //         //     .toString());
  //         breakDownsByCategoryMap.putIfAbsent(j.category, () => null).addAll({
  //           j.problem: [
  //             LoadBreakDownModel(
  //                 id: j.id,
  //                 // category: j.category,
  //                 // problem: j.problem,
  //                 subproblem: j.subproblem,
  //                 expectedFare: j.expectedFare,
  //                 v: j.v)
  //           ]
  //         });
  //       } else
  //         print("error");
  //     } else {
  //       print("new  category ${j.category}");
  //       breakDownsByCategoryMap.addAll({
  //         j.category: {
  //           j.problem: [
  //             LoadBreakDownModel(
  //                 id: j.id,
  //                 // category: j.category,
  //                 // problem: j.problem,
  //                 subproblem: j.subproblem,
  //                 expectedFare: j.expectedFare,
  //                 v: j.v)
  //           ]
  //         }
  //       });
  //     }
  //   }
  //   breakDownsByCategoryMap.forEach((key, value) {
  //     print('${key}: ${value}');
  //   });
  //   convertedListOfCategoryKeys = breakDownsByCategoryMap.keys.toList();
  //   convertedListOfCategoryValues = breakDownsByCategoryMap.values.toList();
  //   notifyListeners();
  //   //print(convertedListOfCategoryValues[0].values.elementAt(1).toList());
  // }
  // getServicesByProblems() {
  //   for (var j in breakDownApiList) {
  //     if (breakDownsByProblemsMap.containsKey(j.problem)) {
  //       breakDownsByProblemsMap
  //           .putIfAbsent(j.problem, () => null)
  //           .putIfAbsent(j.category, () => null)
  //           .add(LoadBreakDownModel(
  //               id: j.id,
  //               category: j.category,
  //               problem: j.problem,
  //               subproblem: j.subproblem,
  //               expectedFare: j.expectedFare,
  //               v: j.v));
  //     } else
  //       breakDownsByProblemsMap.addAll({
  //         j.problem: {
  //           j.category: [
  //             LoadBreakDownModel(
  //                 id: j.id,
  //                 category: j.category,
  //                 problem: j.problem,
  //                 subproblem: j.subproblem,
  //                 expectedFare: j.expectedFare,
  //                 v: j.v)
  //           ]
  //         }
  //       });
  //   }
  //   convertedListOfProblemsKeys = breakDownsByProblemsMap.keys.toList();
  //   convertedListOfProblemsValues = breakDownsByProblemsMap.values;
  //   notifyListeners();
  //   // breakDownsByProblemsMap.forEach((key, value) {
  //   //   print('$key: ${value}');
  //   // });
  // }
}
