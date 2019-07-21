import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/presenter/customer/item_list_presenter.dart';

class ItemListPage extends StatefulWidget{
  @override
  _ItemListState createState() => new _ItemListState();
}

class _ItemListState extends State<ItemListPage> implements ItemListViewContract {
  ItemListPresenter _presenter;
  List<Transaction> _transactions;
  bool _isLoading;

  _ItemListState() {
    _presenter = ItemListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar barang'),),
      body: Container(
          child: _isLoading ?
          Center(
            child: new CircularProgressIndicator(),
          ) : _pickupListContainer()
      ),
    );
  }

  Widget _pickupListContainer() {
    return Container(
        color: Colors.grey[100],
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 4, bottom: 4),
                itemCount: _transactions.length,
                itemBuilder: (BuildContext context, int index) {
                  return _itemCard(_transactions[index], index);
                },
              ),
            )
          ],
        )
    );
  }

  Widget _itemCard(Transaction transaction, int position) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ListTile(
              onTap: () {
                //go to detail item
              },
            ),
            SizedBox(height: 8,),
            Text('Penerima', style: TextStyle(fontSize: 18),),
            SizedBox(height: 4,),
            Text(transaction.receiverName),
            Text(transaction.receiverAddress),
            Text(transaction.receiverPhone),
            SizedBox(height: 8,),
            Text('Pengirim', style: TextStyle(fontSize: 18),),
            SizedBox(height: 4,),
            Text(transaction.senderName),
            Text(transaction.senderAddress),
            Text(transaction.senderPhone),
          ],
        ),
      ),
    );
  }
}