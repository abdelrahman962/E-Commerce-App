import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<Product> products;
  ProductsLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductDetailLoaded extends ProductState {
  final Product product;
  ProductDetailLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class ProductOperationSuccess extends ProductState {}

class ProductOperationFailure extends ProductState {
  final String message;
  ProductOperationFailure(this.message);

  @override
  List<Object?> get props => [message];
}
