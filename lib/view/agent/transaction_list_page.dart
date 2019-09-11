import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/presenter/agent/transaction_list_presenter.dart';

class TransactionListPage extends StatefulWidget {
  final String pickupId;

  @override
  _TransactionListState createState() => _TransactionListState();

  TransactionListPage({Key key, @required this.pickupId}) : super(key: key);
}

class _TransactionListState extends State<TransactionListPage>
    implements TransactionListViewContract {
  bool _isLoading;
  TransactionListPresenter _presenter;
  List<Transaction> _transactions;

  _TransactionListState() {
    _presenter = TransactionListPresenter(this);
  }

  @override
  void initState() {
    _isLoading = true;
    _presenter.loadTransactions(widget.pickupId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar transaksi'),
      ),
      body: Container(
          child: _isLoading ?
          Center(
            child: CircularProgressIndicator(),
          ) : _transactionListContainer()
      ),
    );
  }

  Widget _transactionListContainer() {
    return Container(
        color: Colors.grey[100],
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 4, bottom: 4),
                itemCount: _transactions.length,
                itemBuilder: (BuildContext context, int index) {
                  return _itemTransaction(_transactions[index]);
                },
              ),
            )
          ],
        )
    );
  }

  Widget _itemTransaction(Transaction transaction) {
    return Card(
      margin: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
      child: Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _title('Data Barang'),
            _content('Nama barang', transaction.itemName),
            _content('Jenis barang', transaction.itemType),
            _content('Berat barang', transaction.itemWeight.toString() + "kg"),
            _title('Data Pengirim'),
            _content('Nama pengirim', transaction.senderName),
            _content('Alamat pengirim', transaction.senderAddress),
            _content('No telp pengirim', transaction.senderPhone),
            _title('Data Penerima'),
            _content('Nama penerima', transaction.receiverName),
            _content('Alamat penerima', transaction.receiverAddress),
            _content('No telp penerima', transaction.receiverPhone)
          ],
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(text, style: TextStyle(fontSize: 18, color: Colors.black)),
        SizedBox(height: 16,)
      ],
    );
  }

  Widget _content(String hint, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(hint, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
        Text(content, style: TextStyle(fontSize: 16, color: Colors.black)),
        SizedBox(height: 16,)
      ],
    );
  }

  @override
  void onLoadTransactionComplete(List<Transaction> transactions) {
    setState(() {
      _isLoading = false;
      _transactions = transactions;
    });
  }

  @override
  void onLoadTransactionError() {
    _isLoading = false;
    Fluttertoast.showToast(
        msg: 'Gagal memuat transaksi',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: 16.0
    );
  }
}