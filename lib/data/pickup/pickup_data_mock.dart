import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';

import 'package:tugas_akhir/data/pickup/pickup_data.dart';

class MockPickupRepository implements PickupRepository {
  @override
  Future<List<Pickup>> fetchPickupsByUser(String userId) {
    return new Future.value(pickups);
  }

  @override
  Future<List<Pickup>> fetchPickupsByAgent(String agentId) {
    return Future.value(pickups);
  }

  @override
  Future<Pickup> fetchPickup(String pickupId) {
    return Future.value(pickups[0]);
  }

  @override
  Future<void> postPickup(Pickup pickup) {
    // TODO: implement postPickup
    return null;
  }

  @override
  Future<void> postPickups(List<Pickup> pickups) {
    // TODO: implement postPickups
    return null;
  }
}

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

var pickups = <Pickup>[
  Pickup(
    id: "pickupA",
    agentId: agents[0].id,
    userId: users[0].id,
    status: "Sukses",
    geoPoint: fs.GeoPoint(-7.828114, 110.406007),
    timestamp: fs.Timestamp.now()
  ),
  Pickup(
    id: "pickupB",
    agentId: agents[0].id,
    userId: users[0].id,
    status: "Sukses",
    geoPoint: fs.GeoPoint(-7.828114, 110.406007),
    timestamp: fs.Timestamp.now()
  ),
  Pickup(
    id: "pickupC",
    agentId: agents[0].id,
    userId: users[0].id,
    status: "Sukses",
    geoPoint: fs.GeoPoint(-7.828114, 110.406007),
    timestamp: fs.Timestamp.now()
  )
];