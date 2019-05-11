import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tugas_akhir/presenter/add_item_presenter.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItemPage> {

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

  @override
  void dispose() {
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
      inputType.text.isEmpty ? _validate = true : _validate = false;
      inputWeight.text.isEmpty ? _validate = true : _validate = false;
      inputSenderName.text.isEmpty ? _validate = true : _validate = false;
      inputSenderAddress.text.isEmpty ? _validate = true : _validate = false;
      inputSenderPhone.text.isEmpty ? _validate = true : _validate = false;
      inputReceiverName.text.isEmpty ? _validate = true : _validate = false;
      inputReceiverAddress.text.isEmpty ? _validate = true : _validate = false;
      inputReceiverPhone.text.isEmpty ? _validate = true : _validate = false;
    });
  }

  void _constructData() {
    
  }
}