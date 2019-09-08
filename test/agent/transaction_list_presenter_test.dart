import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/presenter/agent/transaction_list_presenter.dart';

class MockView extends Mock implements TransactionListViewContract {}
class MockTransRepo extends Mock implements TransactionRepository {}

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final view = MockView();
  final repo = MockTransRepo();
  TransactionListPresenter presenter;

  setUp(() {
    presenter = TransactionListPresenter(view);
    presenter.testConstructor(view, repo);
  });

  test('get transaction list', () async {
    final throwable = Exception();
    final pickupId = 'pickupId';
    List<Transaction> transactions = [];
    transactions.add(Transaction());
    when(repo.fetchTransactions(pickupId)).thenAnswer((_) async => Future.value(transactions));
    await presenter.loadTransactions(pickupId);
    verify(repo.fetchTransactions(pickupId));
    verify(view.onLoadTransactionComplete(transactions));
    verifyNever(view.onLoadTransactionError());

    clearInteractions(repo);
    clearInteractions(view);
    when(repo.fetchTransactions(pickupId)).thenThrow(throwable);
    await presenter.loadTransactions(pickupId);
    verify(repo.fetchTransactions(pickupId));
    verifyNever(view.onLoadTransactionComplete(transactions));
    verify(view.onLoadTransactionError());
  });
}
