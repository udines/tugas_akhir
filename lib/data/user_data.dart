import 'package:location/location.dart';

class User {
  String id;
  String name;
  String address;
  String phone;
  Location location;

  User({this.id, this.name, this.address, this.phone, this.location});
}