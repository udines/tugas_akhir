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
}

abstract class ItemRepository {
  Future<List<Item>> fetchBarangs();
  Future<String> createId();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}