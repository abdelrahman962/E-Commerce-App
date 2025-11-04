import '../entities/basket_item.dart';
import '../repositories/basket_repository.dart';

class GetBasketItems {
  final BasketRepository repository;
  GetBasketItems(this.repository);

  Future<List<BasketItem>> call() async {
    return await repository.getBasketItems();
  }
}

class AddBasketItem {
  final BasketRepository repository;
  AddBasketItem(this.repository);

  Future<void> call(BasketItem item) async {
    await repository.addItem(item);
  }
}

class UpdateBasketItem {
  final BasketRepository repository;
  UpdateBasketItem(this.repository);

  Future<void> call(BasketItem item, {int previousQuantity = 0}) async {
    await repository.updateItem(item);
  }
}

class RemoveBasketItem {
  final BasketRepository repository;
  RemoveBasketItem(this.repository);

  Future<void> call(BasketItem item) async {
    await repository.removeItem(item.id!);
  }
}

class ClearBasket {
  final BasketRepository repository;
  ClearBasket(this.repository);

  Future<void> call(List<BasketItem> items) async {
    await repository.clearBasket();
  }
}
