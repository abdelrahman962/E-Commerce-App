import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';
import '../../domain/usecases/return_products.dart';
import '../../domain/usecases/product_description.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProducts getAllProducts;
  final GetProductDetail getProductDetail;

  ProductBloc({required this.getAllProducts, required this.getProductDetail})
    : super(ProductInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
  }

  Future<void> _onLoadProducts(
    LoadProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await getAllProducts.call();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductOperationFailure('Failed to load products: $e'));
    }
  }
}
