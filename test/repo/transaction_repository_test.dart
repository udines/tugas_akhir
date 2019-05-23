import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/data/transaction/transaction_data_mock.dart';
import 'package:tugas_akhir/data/transaction/transaction_data_prod.dart';

class MockTransaction extends MockTransactionRepository {}
class ProdTransaction extends ProdTransactionRepository {}

main () {
  group('mock transaction testing', () {
    var mock = MockTransaction();
    test('mock fetch list of transaction', () async {
      var result = await mock.fetchTransactions("pickupId");
      expect(result, isInstanceOf<List<Transaction>>());
    });
    test('mock fetch single transaction', () async {
      var result = await mock.fetchTransaction("pickupId", "transactionId");
      expect(result, isInstanceOf<Transaction>());
    });
  });

  group('production transaction testing', () {
    var prod = ProdTransaction();
    test('prod fetch list of transaction', () async {
      var result = await prod.fetchTransactions("pickupId");
      expect(result, isInstanceOf<List<Transaction>>());
    });
    test('prod fetch single transaction', () async {
      var result = await prod.fetchTransaction("pickupId", "transactionId");
      expect(result, isInstanceOf<Transaction>());
    });
    test('prod fetch list of transaction failed', () async {
      var result = await prod.fetchTransactions("pickupIdUnavailable");
      expect(result, throwsException);
    });
    test('prod fetch single transaction failed', () async {
      var result = await prod.fetchTransaction("pickupIdUnavailable", "transactionIdUnavailable");
      expect(result, throwsException);
    });
  });
}