import 'package:cloud_firestore/cloud_firestore.dart';

import 'item_data.dart';

class ProdBarangRepository implements ItemRepository {
  @override
  Future<List<Item>> fetchItems() {
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