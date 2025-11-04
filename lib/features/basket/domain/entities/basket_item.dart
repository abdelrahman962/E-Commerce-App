import 'package:equatable/equatable.dart';

import '../../../products/domain/entities/product.dart';

class BasketItem extends Equatable {
  final int? id;
  final Product product;
  final int quantity;

  const BasketItem({this.id, required this.product, required this.quantity});

  @override
  List<Object?> get props => [id, product, quantity];
}
