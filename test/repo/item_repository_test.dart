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
}