class Barang {
  String id;
  String name;
  String type;
  int value;
  int weight;

  Barang({
    this.id,
    this.name,
    this.type,
    this.value,
    this.weight
  });
}

abstract class BarangRepository {
  Future<List<Barang>> fetchBarangs();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}