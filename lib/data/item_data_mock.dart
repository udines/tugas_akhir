import 'item_data.dart';

class MockBarangRepository implements BarangRepository {
  @override
  Future<List<Barang>> fetchBarangs() {
    return new Future.value(barangs);
  }
}

var barangs = <Barang>[
  new Barang(
    id: "barangA",
    name: "Kopi Robusta",
    type: "Makanan",
    value: 150000,
    weight: 1,
  ),
  new Barang(
    id: "barangB",
    name: "Headphone",
    type: "Elektronik",
    value: 500000,
    weight: 2,
  ),
  new Barang(
    id: "barangC",
    name: "Matras Yoga",
    type: "Peralatan",
    value: 80000,
    weight: 1,
  ),
  new Barang(
    id: "barangD",
    name: "Nintendo Switch",
    type: "Elektronik",
    value: 5000000,
    weight: 2,
  ),
];