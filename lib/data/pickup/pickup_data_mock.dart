import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';

import 'package:tugas_akhir/data/pickup/pickup_data.dart';

class MockPickupRepository implements PickupRepository {
  @override
  Future<List<Pickup>> fetchPickupsByUser(String userId) {
    List<Pickup> list = [];
    for (var pickup in pickups) {
      if (pickup.userId == userId) {
        list.add(pickup);
      }
    }
    return Future.value(list);
  }

  @override
  Future<List<Pickup>> fetchPickupsByAgent(String agentId) {
    List<Pickup> list = [];
    for (var pickup in pickups) {
      if (pickup.agentId == agentId) {
        list.add(pickup);
      }
    }
    return Future.value(list);
  }

  @override
  Future<Pickup> fetchPickup(String pickupId) {
    return Future.value(
      pickups.firstWhere(
          (pickup) => pickup.id == pickupId
      )
    );
  }

  @override
  Future<void> postPickup(Pickup pickup) {
    return Future.value(true);
  }

  @override
  Future<void> postPickups(List<Pickup> pickups) {
    return Future.value(true);
  }

  @override
  Future<void> updateStatus(String status, String pickupId) {
    return Future.value(true);
  }
}

var users = <User>[
  User(
      id: "userA",
      name: "Farhan",
      address: "Jalan Sukabirus No. 418",
      phone: "08976378464"
  ),
  User(
      id: "userB",
      name: "Aisyah",
      address: "Perumahan paradice no. F20",
      phone: "08976378464"
  ),
  User(
      id: "userC",
      name: "Karisma",
      address: "Pogung dalangan RT 50",
      phone: "08976378464"
  ),
];

var agents = <Agent>[
  Agent(
      id: "agentA",
      address: "Baturetno, Banguntapan",
      isReceiveOrder: true,
      name: "Agenpos Jogoragan",
      phone: "0224207081",
      timeOpen: "07:00",
      timeClose: "19:00",
      geoPoint: fs.GeoPoint(-7.821813, 110.417288),
  ),
  Agent(
      id: "agentB",
      address: "Jl. Sorogenen No. 1",
      isReceiveOrder: false,
      name: "Post Office Sorogenen",
      phone: "02749171179",
      timeOpen: "07:00",
      timeClose: "21:00",
      geoPoint: fs.GeoPoint(-7.828114, 110.406007),
  ),
  Agent(
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
  Transaction(
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
  Transaction(
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
  Transaction(
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