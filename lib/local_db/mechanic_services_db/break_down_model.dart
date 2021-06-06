import 'package:hive/hive.dart';
part 'break_down_model.g.dart';

@HiveType(typeId: 3)
class BreakDownDB extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String category;
  @HiveField(2)
  final String problem;
  @HiveField(3)
  final String subproblem;
  @HiveField(4)
  final int expectedFare;
  @HiveField(5)
  final int v;

  BreakDownDB(
      {this.id,
      this.category,
      this.problem,
      this.subproblem,
      this.expectedFare,
      this.v});
}
