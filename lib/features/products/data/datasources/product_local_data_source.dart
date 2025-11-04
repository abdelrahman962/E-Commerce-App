import 'package:sqflite/sqflite.dart';
import '../../../../core/db/database.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel?> getProductById(int id);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final DatabaseHelper databaseHelper;
  ProductLocalDataSourceImpl(this.databaseHelper);

  Future<Database> get db async => await databaseHelper.database;

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final database = await db;
    final maps = await database.query('products', orderBy: 'id DESC');
    return maps.map((m) => ProductModel.fromJson(m)).toList();
  }

  @override
  Future<ProductModel?> getProductById(int id) async {
    final database = await db;
    final maps = await database.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ProductModel.fromJson(maps.first);
    }
    return null;
  }
}
