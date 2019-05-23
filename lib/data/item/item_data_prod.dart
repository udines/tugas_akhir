import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:tugas_akhir/data/item/item_data.dart';

class ProdItemRepository implements ItemRepository {
  @override
  Future<List<Item>> fetchItems(String transactionId) {
    // TODO: implement fetchBarangs
    return null;
  }

  @override
  Future<Item> fetchItem(String pickupId, String transactionId, String itemId) async {
    Item item;
    Firestore.instance.collection('pickups').document(pickupId)
    .collection('transactions').document(transactionId)
    .collection('item').document(itemId).get().then((data) => {
      item = data as Item
    });
    return item;
  }
}