import 'package:tugas_akhir/data/item/item_data.dart';

class MockBarangRepository implements ItemRepository {
  @override
  Future<List<Item>> fetchItems() {
    return new Future.value(barangs);
  }

  @override
  Future<Item> fetchItem(String pickupId, String transactionId, String itemId) {
    return new Future.value(barangs[0]);
  }
}

var barangs = <Item>[
  new Item(
    id: "barangA",
    name: "Kopi Robusta",
    type: "Makanan",
    value: 150000,
    weight: 1,
  ),
  new Item(
    id: "barangB",
    name: "Headphone",
    type: "Elektronik",
    value: 500000,
    weight: 2,
  ),
  new Item(
    id: "barangC",
    name: "Matras Yoga",
    type: "Peralatan",
    value: 80000,
    weight: 1,
  ),
  new Item(
    id: "barangD",
    name: "Nintendo Switch",
    type: "Elektronik",
    value: 5000000,
    weight: 2,
  ),
];