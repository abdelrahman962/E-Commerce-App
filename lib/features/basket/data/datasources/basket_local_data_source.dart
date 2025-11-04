import 'package:sqflite/sqflite.dart';
import '../../../../core/db/database.dart';
import '../models/basket_model.dart';

abstract class BasketLocalDataSource {
  Future<List<BasketItemModel>> getBasketItems();
  Future<int> addItem(BasketItemModel item);
  Future<int> updateItem(BasketItemModel item);
  Future<int> removeItem(int id);
  Future<int> clearBasket();
}

class BasketLocalDataSourceImpl implements BasketLocalDataSource {
  final DatabaseHelper databaseHelper;
  BasketLocalDataSourceImpl(this.databaseHelper);

  Future<Database> get db async => await databaseHelper.database;

  @override
  Future<int> addItem(BasketItemModel item) async {
    final database = await db;

    final product = await database.query(
      'products',
      where: 'id = ?',
      whereArgs: [item.product.id],
    );

    if (product.isEmpty) {
      throw Exception('Product not found');
    }

    final id = await database.insert('basket', item.toJson());

    return id;
  }

  @override
  Future<int> clearBasket() async {
    final database = await db;
    return await database.delete('basket');
  }

  @override
  Future<List<BasketItemModel>> getBasketItems() async {
    final database = await db;
    final maps = await database.query('basket', orderBy: 'id DESC');
    return maps.map((m) => BasketItemModel.fromJson(m)).toList();
  }

  @override
  Future<int> removeItem(int id) async {
    final database = await db;
    return await database.delete('basket', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<int> updateItem(BasketItemModel item) async {
    final database = await db;
    return await database.update(
      'basket',
      item.toJson(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }
}
