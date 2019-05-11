import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddItemPage extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan barang'),
      ),
      body: Padding(
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
            ),
            SizedBox(height: 8,),
            TextField(
              decoration: InputDecoration(
                hintText: 'Berat barang',
              ),
              keyboardType: TextInputType.number,
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
            ),
            SizedBox(height: 8,),
            TextField(
              decoration: InputDecoration(
                hintText: 'Alamat pengirim',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
            SizedBox(height: 8,),
            TextField(
              decoration: InputDecoration(
                hintText: 'No telepon pengirim',
              ),
              keyboardType: TextInputType.number,
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
            ),
            SizedBox(height: 8,),
            TextField(
              decoration: InputDecoration(
                hintText: 'Alamat penerima',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
            SizedBox(height: 8,),
            TextField(
              decoration: InputDecoration(
                hintText: 'No telepon penerima',
              ),
              keyboardType: TextInputType.number,
            )
          ],
        ),
      )
    );
  }
}