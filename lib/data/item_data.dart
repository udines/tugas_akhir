class Item {
  String id;
  String name = "Barang";
  String type;
  int value = 0;
  int weight;

  Item({
    this.id,
    this.type,
    this.name,
    this.value,
    this.weight
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'type': type,
    'value': value,
    'weight': weight
  };
}

abstract class ItemRepository {
  Future<List<Item>> fetchItems();
  Future<Item> fetchItem(String pickupId, String transactionId, String itemId);
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}