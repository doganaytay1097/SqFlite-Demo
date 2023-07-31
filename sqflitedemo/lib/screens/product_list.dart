import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sqflitedemo/data/dbHelper.dart';
import 'package:sqflitedemo/models/product.dart';
import 'package:sqflitedemo/screens/product_add.dart';
import 'package:sqflitedemo/screens/product_detail.dart';

import '../MyWidgets/MyWidgets.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  static List<String> harflere = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "R",
    "S",
    "T",
    "V",
    "Y",
    "Z",
  ];
  int harfNumara = Random().nextInt(harflere.length);
  var dbHelper = DbHelper();
  late List<Product> products;
  int productCount = 0;

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text("Ürün Listesi"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () => goToProductAdd(),
        child: Icon(Icons.add),
        tooltip: "Yeni Ürün ekle",
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
      itemCount: productCount,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Color(0xFFA78295),
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black12,
              child: Text(harflere[harfNumara],style: buildTextStyle(),),
            ),
            title: Text(products[position].name,style: buildTextStyle(),),
            subtitle: Text(products[position].description,style: buildTextStyle()),
            onTap: () {
              goToDetail(products[position]);
            },
          ),
        );
      },
    );
  }



  void goToProductAdd() async {
    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductAdd()),
    );
    if (result != null && result) {
      getProducts();
    }
  }

  void getProducts() async {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then(
      (data) {
        setState(() {
          products = data;
          productCount = data.length;
        });
      },
    );
  }

  void goToDetail(Product product) async {
    bool result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetail(product),
        ));
    if (result != null) {
      if (result) {
        getProducts();
      }
    }
  }
}
