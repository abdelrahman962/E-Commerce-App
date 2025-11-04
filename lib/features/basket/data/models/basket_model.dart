import '../../domain/entities/basket_item.dart';
import '../../../products/data/models/product_model.dart';

class BasketItemModel extends BasketItem {
  const BasketItemModel({
    super.id,
    required ProductModel super.product,
    required super.quantity,
  });

  factory BasketItemModel.fromJson(Map<String, dynamic> json) {
    return BasketItemModel(
      id: json['id'] as int?,
      product: ProductModel.fromJson({
        'id': json['productId'],
        'name': json['name'],
        'description': json['description'],
        'price': json['price'],
        'image': json['image'] ?? 'assets/images/default.png',
      }),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': product.id,
      'name': product.name,
      'description': product.description,
      'price': product.price,
      'quantity': quantity,
      'image': product.image,
    };
  }
}
