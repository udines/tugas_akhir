import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tugas_akhir/data/agent_data.dart';
import 'package:tugas_akhir/data/item_data.dart';
import 'package:tugas_akhir/data/transaction_data.dart';
import 'package:tugas_akhir/data/user_data.dart';
import 'package:tugas_akhir/presenter/add_item_presenter.dart';

class AddItemPage extends StatefulWidget {

  final Agent agent;
  final User user;

  AddItemPage({Key key, this.agent, this.user}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItemPage> implements AddItemViewContract {

  final inputName = TextEditingController();
  final inputType = TextEditingController();
  final inputWeight = TextEditingController();
  final inputSenderName = TextEditingController();
  final inputSenderAddress = TextEditingController();
  final inputSenderPhone = TextEditingController();
  final inputReceiverName = TextEditingController();
  final inputReceiverAddress = TextEditingController();
  final inputReceiverPhone = TextEditingController();
  AddItemPresenter _presenter;
  bool _validate = false;

  _AddItemState() {
    _presenter = AddItemPresenter(this);
  }

  @override
  void dispose() {
    inputName.dispose();
    inputType.dispose();
    inputWeight.dispose();
    inputSenderName.dispose();
    inputSenderAddress.dispose();
    inputSenderPhone.dispose();
    inputReceiverName.dispose();
    inputReceiverAddress.dispose();
    inputReceiverPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan barang'),
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text('Data barang',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Nama barang (opsional)'
                ),
                textCapitalization: TextCapitalization.words,
                controller: inputName,
              ),
              SizedBox(height: 8,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Jenis barang'
                ),
                textCapitalization: TextCapitalization.sentences,
                controller: inputType,
              ),
              SizedBox(height: 8,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Berat barang',
                ),
                keyboardType: TextInputType.number,
                controller: inputWeight,
              ),
              SizedBox(height: 24,),
              Text('Data pengirim',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black
                ),
              ),
              SizedBox(height: 8,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Nama pengirim',
                ),
                textCapitalization: TextCapitalization.words,
                controller: inputSenderName,
              ),
              SizedBox(height: 8,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Alamat pengirim',
                ),
                textCapitalization: TextCapitalization.sentences,
                controller: inputSenderAddress,
              ),
              SizedBox(height: 8,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'No telepon pengirim',
                ),
                keyboardType: TextInputType.number,
                controller: inputSenderPhone,
              ),

              SizedBox(height: 24,),
              Text('Data penerima',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black
                ),
              ),
              SizedBox(height: 8,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Nama penerima',
                ),
                textCapitalization: TextCapitalization.words,
                controller: inputReceiverName,
              ),
              SizedBox(height: 8,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Alamat penerima',
                ),
                textCapitalization: TextCapitalization.sentences,
                controller: inputReceiverAddress,
              ),
              SizedBox(height: 8,),
              TextField(
                decoration: InputDecoration(
                  hintText: 'No telepon penerima',
                ),
                keyboardType: TextInputType.number,
                controller: inputReceiverPhone,
              ),
              SizedBox(height: 16,),
              RaisedButton(
                child: Text('Tambahkan barang'),
                onPressed: () {
                  _validateData();
                  if (_validate) {
                    _constructData();
                  }
                },
              ),
            ],
          ),
        ),
      )
    );
  }

  void _validateData() {
    setState(() {
      inputType.text.isNotEmpty ? _validate = true : _validate = false;
      inputWeight.text.isNotEmpty ? _validate = true : _validate = false;
      inputSenderName.text.isNotEmpty ? _validate = true : _validate = false;
      inputSenderAddress.text.isNotEmpty ? _validate = true : _validate = false;
      inputSenderPhone.text.isNotEmpty ? _validate = true : _validate = false;
      inputReceiverName.text.isNotEmpty ? _validate = true : _validate = false;
      inputReceiverAddress.text.isNotEmpty ? _validate = true : _validate = false;
      inputReceiverPhone.text.isNotEmpty ? _validate = true : _validate = false;
    });
  }

  void _constructData() {
    //construct item object
    Item item = Item(
      id: _presenter.createItemId(),
      name: inputName.text.isNotEmpty ? inputName.text : "Barang",
      type: inputType.text,
      weight: int.parse(inputWeight.text)
    );

    //construct transaction object
    Transaction transaction = Transaction(
      id: _presenter.createTransactionId(),
      senderName: inputSenderName.text,
      senderAddress: inputSenderAddress.text,
      senderPhone: inputSenderPhone.text,
      receiverName: inputReceiverName.text,
      receiverAddress: inputReceiverAddress.text,
      receiverPhone: inputReceiverPhone.text,
      date: DateTime.now(),
      item: item,
      user: widget.user,
      agent: widget.agent
    );

    Navigator.pop(context, transaction);
  }

  @override
  onGetIdError() {
    // TODO: implement onGetIdError
  }

  @override
  onGetIdSuccess(String id) {
    
  }

  @override
  void onGetCurrentUserError() {
    // TODO: implement onGetCurrentUserError
  }

  @override
  void onGetCurrentUserSuccess(User user) {
    
  }
}