import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflitedemo/models/product.dart';

class DbHelper {
  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }

    _db = await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "etrade.db");
    var eTradeDb = await openDatabase(path, version: 1, onCreate: createDb);
    return eTradeDb;
  }

  Future<void> createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS products(id INTEGER PRIMARY KEY, name TEXT, description TEXT, unitPrice REAL)");
  }

  Future<List<Product>> getProducts() async {
    Database? db = await this.db;
    if (db == null) {
      throw Exception("Database not initialized!");
    }
    var result = await db.query("products");
    return List.generate(result.length, (index) {
      return Product.fromMap(result[index]);
    });
  }

  Future<int> insert(Product product) async {
    Database? db = await this.db;
    if (db == null) {
      throw Exception("Database not initialized!");
    }
    var result = await db.insert("products", product.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database? db = await this.db;
    if (db == null) {
      throw Exception("Database not initialized!");
    }
    var result = await db.rawDelete("DELETE FROM products WHERE id = $id");
    return result;
  }

  Future<int> update(Product product) async {
    Database? db = await this.db;
    if (db == null) {
      throw Exception("Database not initialized!");
    }
    var result = await db.update(
      "products",
      product.toMap(),
      where: "id = ?",
      whereArgs: [product.id],
    );
    return result;
  }
}




