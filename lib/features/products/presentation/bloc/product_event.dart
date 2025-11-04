import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadProductsEvent extends ProductEvent {}

class LoadProductDetailEvent extends ProductEvent {
  final int id;
  LoadProductDetailEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddProductEvent extends ProductEvent {
  final Product product;
  AddProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class UpdateProductEvent extends ProductEvent {
  final Product product;
  UpdateProductEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class DeleteProductEvent extends ProductEvent {
  final int id;
  DeleteProductEvent(this.id);

  @override
  List<Object?> get props => [id];
}
