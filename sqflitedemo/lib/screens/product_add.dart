import 'package:flutter/material.dart';
import 'package:sqflitedemo/data/dbHelper.dart';
import 'package:sqflitedemo/models/product.dart';

import '../MyWidgets/MyWidgets.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({Key? key}) : super(key: key);

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  var dbHelper = DbHelper();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtUnitPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: Text("Yeni Ürün Ekle"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(txt: txtName,labelText:"Ürünün Adı",),
            MyTextField(txt: txtDescription,labelText:"Ürünün Açıklaması",),
            MyTextField(txt: txtUnitPrice,labelText:"Ürünün Fiyatı",),
            buildSaveButton(),
          ],
        ),
      ),
    );
  }

  ElevatedButton buildSaveButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        elevation: 1,

      ),
      onPressed: () => addProduct(),
      child: Text("EKLE",style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 18,

      ),),
    );
  }


  addProduct() async {
    var result = await dbHelper.insert(
      Product.withoutId(
        txtName.text,
        txtDescription.text,
        double.tryParse(txtUnitPrice.text) ?? 0.0,
      ),
    );
    Navigator.pop(context, true);
  }
}


