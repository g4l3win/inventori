import 'database_connection.dart';
import 'package:sqflite/sqflite.dart';

class ProductRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> addProduct(Map<String, dynamic> product) async {
    final db = await _databaseHelper.database;
    return await db.insert('products', product);
  }

  Future<List<Map<String, dynamic>>> getAllProducts() async {
    final db = await _databaseHelper.database;
    return await db.query('products');
  }

  Future<int> updateProduct(String code, Map<String, dynamic> product) async {
    final db = await _databaseHelper.database;
    return await db
        .update('products', product, where: 'code = ?', whereArgs: [code]);
  }

  Future<int> deleteProduct(String code) async {
    final db = await _databaseHelper.database;
    return await db.delete('products', where: 'code = ?', whereArgs: [code]);
  }
}
