import 'package:hive/hive.dart';
part 'cutomer_owned_cars_model.g.dart';

@HiveType(typeId: 0)
class customerOwnedCarsDB extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String CarBrand;
  @HiveField(2)
  final String Model;
  @HiveField(3)
  final String Year;
  @HiveField(4)
  final String OwnerId;
  @HiveField(5)
  final String Plates;
  @HiveField(6)
  final String v;

  customerOwnedCarsDB(
      {this.id,
      this.CarBrand,
      this.Model,
      this.Year,
      this.OwnerId,
      this.Plates,
      this.v});
}
