import 'package:customer_app/local_db/cutomer_owned_cars_model.dart';
import 'package:hive/hive.dart';
part 'customer_info_db_model.g.dart';

@HiveType(typeId: 1)
class customerInfoDB extends HiveObject {
  @HiveField(0)
  final String CURRENT_LANGUAGE;
  @HiveField(1)
  final String JWT_TOKEN;
  @HiveField(2)
  final String FIREBASE_ID;
  @HiveField(3)
  final String BACKEND_ID;
  @HiveField(4)
  final String FIRST_NAME;
  @HiveField(5)
  final String LAST_NAME;
  @HiveField(6)
  final String PHONE_NUMBER;
  @HiveField(7)
  final String IAT;
  @HiveField(8)
  final String SOCIAL_IMAGE;
  @HiveField(9)
  final String SOCIAL_EMAIL;

  customerInfoDB(
      {this.CURRENT_LANGUAGE,
      this.JWT_TOKEN,
      this.FIREBASE_ID,
      this.BACKEND_ID,
      this.FIRST_NAME,
      this.LAST_NAME,
      this.PHONE_NUMBER,
      this.IAT,
      this.SOCIAL_IMAGE,
      this.SOCIAL_EMAIL});
}
