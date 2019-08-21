import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tugas_akhir/data/agent/agent_data.dart';
import 'package:tugas_akhir/data/transaction/transaction_data.dart';
import 'package:tugas_akhir/data/user/user_data.dart';
import 'package:tugas_akhir/presenter/customer/add_item_presenter.dart';

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
  final inputSenderProvince = TextEditingController();
  final inputSenderPhone = TextEditingController();
  final inputReceiverName = TextEditingController();
  final inputReceiverAddress = TextEditingController();
  final inputReceiverProvince = TextEditingController();
  final inputReceiverPhone = TextEditingController();
  AddItemPresenter _presenter;
  bool _validate = false;

  _AddItemState() {
    _presenter = AddItemPresenter(this);
    _presenter.getSenderAddress();
    _presenter.getSenderProvince();
  }

  @override
  void initState() {
    inputSenderName.text = widget.user.name;
    inputSenderPhone.text = widget.user.phone;
    super.initState();
  }

  @override
  void dispose() {
    inputName.dispose();
    inputType.dispose();
    inputWeight.dispose();
    inputSenderName.dispose();
    inputSenderAddress.dispose();
    inputSenderProvince.dispose();
    inputSenderPhone.dispose();
    inputReceiverName.dispose();
    inputReceiverAddress.dispose();
    inputReceiverProvince.dispose();
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
                  hintText: 'Nama barang'
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
                  hintText: 'Berat barang (kg)',
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
              TextField(
                decoration: InputDecoration(
                  hintText: 'Provinsi pengirim',
                ),
                textCapitalization: TextCapitalization.sentences,
                controller: inputSenderProvince,
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
              TextField(
                decoration: InputDecoration(
                  hintText: 'Provinsi penerima',
                ),
                textCapitalization: TextCapitalization.sentences,
                controller: inputReceiverProvince,
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
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Harap lengkapi data',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 1,
                      fontSize: 16.0
                    );
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
      inputSenderProvince.text.isNotEmpty ? _validate = true : _validate = false;
      inputSenderPhone.text.isNotEmpty ? _validate = true : _validate = false;
      inputReceiverName.text.isNotEmpty ? _validate = true : _validate = false;
      inputReceiverAddress.text.isNotEmpty ? _validate = true : _validate = false;
      inputReceiverProvince.text.isNotEmpty ? _validate = true : _validate = false;
      inputReceiverPhone.text.isNotEmpty ? _validate = true : _validate = false;
    });
  }

  void _constructData() {
    //construct transaction object
    Transaction transaction = Transaction(
      id: _presenter.createTransactionId(),
      pickupId: '',
      agentId: widget.agent.id,
      userId: widget.user.id,
      itemName: inputName.text,
      itemWeight: int.parse(inputWeight.text),
      itemType: inputType.text,
      senderName: inputSenderName.text,
      senderAddress: inputSenderAddress.text,
      senderProvince: inputSenderProvince.text,
      senderPhone: inputSenderPhone.text,
      receiverName: inputReceiverName.text,
      receiverAddress: inputReceiverAddress.text,
      receiverProvince: inputReceiverProvince.text,
      receiverPhone: inputReceiverPhone.text,
    );

    Navigator.pop(context, transaction);
  }

  @override
  void onGetSenderAddressSuccess(String address) {
    setState(() {
      inputSenderAddress.text = address;
    });
  }

  @override
  void onGetSenderProvinceSuccess(String province) {
    setState(() {
      inputSenderProvince.text = province;
    });
  }
}