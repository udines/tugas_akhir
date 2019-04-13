import 'agen_data.dart';
import 'barang_data.dart';
import 'user_data.dart';

class Transaction {
  String id;
  String noResi;
  //Sender information
  String senderName;
  String senderPhone;
  String senderProvince;
  String senderAddress;
  //Receiver information
  String receiverName;
  String receiverPhone;
  String receiverProvince;
  String receiverAddress;
  DateTime date;
  //Relations
  Barang barang;
  User user;
  Agen agen;
}