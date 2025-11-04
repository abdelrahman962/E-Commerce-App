import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;
  ProductRepositoryImpl(this.localDataSource);

  @override
  Future<List<Product>> getAllProducts() async {
    return await localDataSource.getAllProducts();
  }

  @override
  Future<Product> getProductDetail(int id) async {
    final product = await localDataSource.getProductById(id);
    if (product != null) return product;
    throw Exception('Product not found with id $id');
  }
}
