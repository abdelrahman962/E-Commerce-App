import '../../domain/entities/basket_item.dart';
import '../../domain/repositories/basket_repository.dart';
import '../datasources/basket_local_data_source.dart';
import '../models/basket_model.dart';
import '../../../products/data/models/product_model.dart';

class BasketRepositoryImpl implements BasketRepository {
  final BasketLocalDataSource localDataSource;

  BasketRepositoryImpl(this.localDataSource);

  @override
  Future<void> addItem(BasketItem item) async {
    final model = BasketItemModel(
      id: item.id,
      product: ProductModel(
        id: item.product.id,
        name: item.product.name,
        description: item.product.description,
        price: item.product.price,
        image: item.product.image,
      ),
      quantity: item.quantity,
    );
    await localDataSource.addItem(model);
  }

  @override
  Future<void> clearBasket() async {
    await localDataSource.clearBasket();
  }

  @override
  Future<List<BasketItem>> getBasketItems() async {
    return await localDataSource.getBasketItems();
  }

  @override
  Future<void> removeItem(int id) async {
    await localDataSource.removeItem(id);
  }

  @override
  Future<void> updateItem(BasketItem item) async {
    final model = BasketItemModel(
      id: item.id,
      product: ProductModel(
        id: item.product.id,
        name: item.product.name,
        description: item.product.description,
        price: item.product.price,
        image: item.product.image,
      ),
      quantity: item.quantity,
    );
    await localDataSource.updateItem(model);
  }
}
