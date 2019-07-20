import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tugas_akhir/presenter/customer/add_item_presenter.dart';

class AddItemMock extends Mock {
  static AddItemViewContract view;
  AddItemPresenter presenter = AddItemPresenter(view);
}

main() {
  group('create ids test', () {
    AddItemMock mock = AddItemMock();
    test('mock create item id', () {
      var result = true;
      var id1 = mock.presenter.createItemId();
      var id2 = mock.presenter.createItemId();
      for (int i = 0; i < 1000; i++) {
        if (id1 != id2) {
          result = result && true;
        } else {
          result = result && false;
          break;
        }
        id1 = mock.presenter.createItemId();
        id2 = mock.presenter.createItemId();
      }
      expect(result, true);
    });

    test('mock create transaction id', () {
      var result = true;
      var id1 = mock.presenter.createTransactionId();
      var id2 = mock.presenter.createTransactionId();
      for (int i = 0; i < 1000; i++) {
        if (id1 != id2) {
          result = result && true;
        } else {
          result = result && false;
          break;
        }
        id1 = mock.presenter.createTransactionId();
        id2 = mock.presenter.createTransactionId();
      }
      expect(result, true);
    });
  });
}