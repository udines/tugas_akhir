import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_akhir/data/item/item_data.dart';
import 'package:tugas_akhir/data/item/item_data_mock.dart';
import 'package:tugas_akhir/data/item/item_data_prod.dart';

class ItemMock extends MockItemRepository {}
class ItemProd extends ProdItemRepository {}

main () {
  group('mock item testing', () {
    var mock = ItemMock();
    test('mock fetch single item', () async {
      var result = mock.fetchItem("pickupId", "transactionId", "itemId");
      expect(result, isInstanceOf<Item>());
    });
    test('mock fetch list item', () async {
      var result = mock.fetchItems("transactionId");
      expect(result, isInstanceOf<List<Item>>());
    });
  });

  group('prod item testing', () {
    var prod = ItemProd();
    test('prod fetch single item', () async {
      var result = prod.fetchItem('pickupId', 'transactionId', 'itemId');
      expect(result, isInstanceOf<Item>());
    });
    test('prod fetch list item', () async {
      var result = prod.fetchItems('transactionId');
      expect(result, isInstanceOf<List<Item>>());
    });
    test('prod fetch single item failed', () async {
      var result = prod.fetchItem('pickupIdFake', 'transactionIdFake', 'itemIdFake');
      expect(result, throwsException);
    });
    test('prod fetch list item failed', () async {
      var result = prod.fetchItems('transactionIdFake');
      expect(result, throwsException);
    });
  });
}