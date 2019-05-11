import 'transaction_data.dart';
import 'item_data.dart';
import 'user_data.dart';
import 'agent_data.dart';

class MockTransactionRepository implements TransactionRepository {
  @override
  Future<List<Transaction>> fetchTransactions() {
    return new Future.value(transactions);
  }

  @override
  Future<Transaction> fetchTransaction(String transactionId) {
    return new Future.value(transactions[0]);
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

var users = <User>[
  new User(
    id: "userA",
    name: "Farhan",
    address: "Jalan Sukabirus No. 418",
    phone: "08976378464"
  ),
  new User(
    id: "userB",
    name: "Aisyah",
    address: "Perumahan paradice no. F20",
    phone: "08976378464"
  ),
  new User(
    id: "userC",
    name: "Karisma",
    address: "Pogung dalangan RT 50",
    phone: "08976378464"
  ),
];

var agents = <Agent>[
  new Agent(
      id: "agentA",
      address: "Baturetno, Banguntapan",
      costPerKM: 1000,
      costPerKG: 1000,
      isReceiveOrder: true,
      name: "Agenpos Jogoragan",
      phone: "0224207081",
      timeOpen: "07:00",
      timeClose: "19:00",
      latitude: -7.821813,
      longitude: 110.417288,
      userAdmin: new User(
          id: "userAgentA",
          name: "Pranowo",
          address: "Wiyoro Banguntapan",
          phone: "08978873886"
      )
  ),
  new Agent(
      id: "agentB",
      address: "Jl. Sorogenen No. 1",
      costPerKM: 1000,
      costPerKG: 2000,
      isReceiveOrder: false,
      name: "Post Office Sorogenen",
      phone: "02749171179",
      timeOpen: "07:00",
      timeClose: "21:00",
      latitude: -7.828114,
      longitude: 110.406007,
      userAdmin: new User(
          id: "userAgentB",
          name: "Hamid",
          address: "Sorogenen",
          phone: "089619237368"
      )
  ),
  new Agent(
      id: "agentC",
      address: "Jl. Kemasan No. 1",
      costPerKM: 2000,
      costPerKG: 1000,
      isReceiveOrder: true,
      name: "Kantorpos Yogyakarta Kotagede",
      phone: "02743994632",
      timeOpen: "09:00",
      timeClose: "15:00",
      latitude: -7.827481,
      longitude: 110.400527,
      userAdmin: new User(
          id: "userAgentC",
          name: "Somad",
          address: "Karanglo",
          phone: "08917327493"
      )
  )
];

var transactions = <Transaction>[
  new Transaction(
      id: "transactionA",
      senderName: "Paiman",
      senderPhone: "08976384657",
      senderProvince: "Yogyakarta",
      senderAddress: "Jalan Ngeksigondo No. 21A",
      receiverName: "Painah",
      receiverPhone: "098934757",
      receiverProvince: "Jawa Timur",
      receiverAddress: "Jalan Bali No. 5",
      date: new DateTime.now(),
      barang: barangs[0],
      user: users[0],
      agent: agents[0]
  ),
  new Transaction(
      id: "transactionA",
      senderName: "Paiman",
      senderPhone: "08976384657",
      senderProvince: "Yogyakarta",
      senderAddress: "Jalan Ngeksigondo No. 21A",
      receiverName: "Painah",
      receiverPhone: "098934757",
      receiverProvince: "Jawa Timur",
      receiverAddress: "Jalan Bali No. 5",
      date: new DateTime.now(),
      barang: barangs[1],
      user: users[0],
      agent: agents[0]
  ),
  new Transaction(
      id: "transactionA",
      senderName: "Paiman",
      senderPhone: "08976384657",
      senderProvince: "Yogyakarta",
      senderAddress: "Jalan Ngeksigondo No. 21A",
      receiverName: "Painah",
      receiverPhone: "098934757",
      receiverProvince: "Jawa Timur",
      receiverAddress: "Jalan Bali No. 5",
      date: new DateTime.now(),
      barang: barangs[1],
      user: users[0],
      agent: agents[0]
  ),
];