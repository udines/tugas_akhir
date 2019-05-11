class Item {
  String id;
  String name;
  String type;
  int value;
  int weight;

  Item({
    this.id,
    this.type,
    this.name,
    this.value,
    this.weight
  });
}

abstract class BarangRepository {
  Future<List<Item>> fetchBarangs();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}