import '../entities/basket_item.dart';

abstract class BasketRepository {
  Future<List<BasketItem>> getBasketItems();
  Future<void> addItem(BasketItem item);
  Future<void> updateItem(BasketItem item);
  Future<void> removeItem(int id);
  Future<void> clearBasket();
}
