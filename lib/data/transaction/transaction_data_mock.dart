import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/data/item/item_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';

class MockTransactionRepository implements TransactionRepository {
  @override
  Future<List<Transaction>> fetchTransactions(String pickupId) {
    return new Future.value(transactions);
  }

  @override
  Future<Transaction> fetchTransaction(String transactionId) {
    return new Future.value(transactions[0]);
  }
}

var items = <Item>[
  Item(
    name: "Kopi Robusta",
    type: "Makanan",
    weight: 1,
  ),
  new Item(
    name: "Headphone",
    type: "Elektronik",
    weight: 2,
  ),
  new Item(
    name: "Matras Yoga",
    type: "Peralatan",
    weight: 1,
  ),
  new Item(
    name: "Nintendo Switch",
    type: "Elektronik",
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
      isReceiveOrder: true,
      name: "Agenpos Jogoragan",
      phone: "0224207081",
      timeOpen: "07:00",
      timeClose: "19:00",
      geoPoint: fs.GeoPoint(-7.821813, 110.417288),
  ),
  new Agent(
      id: "agentB",
      address: "Jl. Sorogenen No. 1",
      isReceiveOrder: false,
      name: "Post Office Sorogenen",
      phone: "02749171179",
      timeOpen: "07:00",
      timeClose: "21:00",
      geoPoint: fs.GeoPoint(-7.828114, 110.406007),
  ),
  new Agent(
      id: "agentC",
      address: "Jl. Kemasan No. 1",
      isReceiveOrder: true,
      name: "Kantorpos Yogyakarta Kotagede",
      phone: "02743994632",
      timeOpen: "09:00",
      timeClose: "15:00",
      geoPoint: fs.GeoPoint(-7.827481, 110.400527),
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
  ),
];