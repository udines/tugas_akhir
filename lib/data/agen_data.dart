import 'package:location/location.dart';

import 'company_setting_data.dart';
import 'user_data.dart';

class Agen {
  String id;
  String address;
  String name;
  String phone;
  String timeOpen;
  String timeClose;
  Location location;
  CompanySetting setting;
  User userAdmin;
}