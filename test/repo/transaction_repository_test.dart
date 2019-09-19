import 'package:flutter_test/flutter_test.dart';
import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/data/transaction/transaction_data_mock.dart';
import 'package:tugas_akhir/data/transaction/transaction_data_prod.dart';

class TransactionMock extends MockTransactionRepository {}
class TransactionProd extends ProdTransactionRepository {}

main () {
  group('mock transaction testing', () {
    var mock = TransactionMock();
    test('mock fetch list of transaction', () async {
      var result = await mock.fetchTransactions("pickupId");
      expect(result, isInstanceOf<List<Transaction>>());
    });
    test('mock fetch single transaction', () async {
      var transactionId = 'transactionA';
      var result = await mock.fetchTransaction(transactionId);
      expect(result.id, transactionId);
    });
  });

  /*group('production transaction testing', () {
    var prod = TransactionProd();
    test('prod fetch list of transaction', () async {
      var result = await prod.fetchTransactions("pickupId");
      expect(result, isInstanceOf<List<Transaction>>());
    });
    test('prod fetch single transaction', () async {
      var result = await prod.fetchTransaction('transactionId');
      expect(result, isInstanceOf<Transaction>());
    });
    test('prod fetch list of transaction failed', () async {
      var result = await prod.fetchTransactions("pickupIdUnavailable");
      expect(result, throwsException);
    });
    test('prod fetch single transaction failed', () async {
      var result = await prod.fetchTransaction('transactionUnavailableId');
      expect(result, throwsException);
    });
  });*/
}