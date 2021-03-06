import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_akhir/data/pickup/pickup_data.dart';
import 'package:tugas_akhir/data/pickup/pickup_data_mock.dart';
import 'package:tugas_akhir/data/pickup/pickup_data_prod.dart';

class PickupMock extends MockPickupRepository {}
class PickupProd extends ProdPickupRepository {}

main () {
  group('mock pickup testing', () {
    var mock = PickupMock();
    test('mock fetch pickups by user', () async {
      var result = await mock.fetchPickupsByUser("userId");
      expect(result, isInstanceOf<List<Pickup>>());
    });
    test('mock fetch pickups by agent', () async {
      var result = await mock.fetchPickupsByAgent("agentId");
      expect(result, isInstanceOf<List<Pickup>>());
    });
    test('fetch single pickup', () async {
      var pickupId = 'pickupA';
      var pickup = await mock.fetchPickup(pickupId);
      expect(pickup.id, pickupId);
    });
  });

  /*group('prod pickup testing', () {
    var prod = PickupProd();
    test('prod fetch pickups by user success', () async {
      var result = await prod.fetchPickupsByUser("userId");
      expect(result, isInstanceOf<List<Pickup>>());
    });
    test('prod fetch pickups by agent success', () async {
      var result = await prod.fetchPickupsByAgent("agentId");
      expect(result, isInstanceOf<List<Pickup>>());
    });
    test('prod fetch pickups by user failed', () async {
      var result = await prod.fetchPickupsByUser("fakeUserId");
      expect(result, throwsException);
    });
    test('prod fetch pickups by agent success', () async {
      var result = await prod.fetchPickupsByAgent("fakeAgentId");
      expect(result, throwsException);
    });
  });*/
}