import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_akhir/data/location/location_data_mock.dart';
import 'package:tugas_akhir/data/location/location_data_prod.dart';

class LocationMock extends MockLocationRepository {}
class LocationProd extends ProdLocationRepository {}

main () {
  group('mock location test', () {
    var mock = LocationMock();

  });

  group('production location test', () {
    var prod = LocationProd();

  });
}