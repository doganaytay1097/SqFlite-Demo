import 'package:flutter/material.dart';
import 'package:sqflitedemo/MyWidgets/MyWidgets.dart'; // Kendi oluşturduğumuz özelleştirilmiş widgetlar
import 'package:sqflitedemo/data/dbHelper.dart'; // Veritabanı işlemleri için dbHelper sınıfı
import '../models/product.dart'; // Ürün model sınıfı

class ProductDetail extends StatefulWidget {
  final Product product;

  ProductDetail(this.product);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

enum Options { delete, update }

class _ProductDetailState extends State<ProductDetail> {
  late Product product;

  @override
  void initState() {
    super.initState();
    product = widget.product; // Widget'in yapılandırıcısından alınan ürünü state değişkenine atıyoruz.
  }

  DbHelper dbHelper = DbHelper(); // Veritabanı işlemleri için dbHelper nesnesi oluşturuyoruz.

  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtUnitPrice = TextEditingController();

  @override
  void didChangeDependencies() {
    // Ürün detayları sayfasına geçiş yaptığımızda, text alanları başlangıçta mevcut ürün değerleriyle doldurulacak
    txtName.text = product.name;
    txtUnitPrice.text = product.unitPrice.toString();
    txtDescription.text = product.description;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(child: Text("${product.name}")),
        actions: [
          PopupMenuButton<Options>(
            color: Colors.white,
            onSelected: selectProcess,
            itemBuilder: (context) => <PopupMenuEntry<Options>>[
              const PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Sil"),
              ),
              const PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Güncelle"),
              ),
            ],
          )
        ],
      ),
      body: buildProductDetail(),
    );
  }

  Widget buildProductDetail() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0,right: 30,top: 30,bottom: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Kendi oluşturduğumuz özelleştirilmiş widgetlar ile text alanlarını oluşturuyoruz.
            MyTextField(txt: txtName, labelText: "Ürün Adı"),
            MyTextField(txt: txtDescription, labelText: "Ürün Açıklaması"),
            MyTextField(txt: txtUnitPrice, labelText: "Ürün Fiyatı"),
          ],
        ),
      ),
    );
  }

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
      // Ürünü veritabanından silme işlemi
        await dbHelper.delete(product.id!);
        Navigator.pop(context, true); // Geri dön ve sayfanın güncellenmiş halini göster
        break;
      case Options.update:
      // Text alanlarındaki değerleri alıp, mevcut ürünü güncelleme işlemi
        product.name = txtName.text;
        product.description = txtDescription.text;
        product.unitPrice = double.tryParse(txtUnitPrice.text) ?? 0.0;
        await dbHelper.update(product);
        Navigator.pop(context, true); // Geri dön ve sayfanın güncellenmiş halini göster
        break;
    }
  }
}

