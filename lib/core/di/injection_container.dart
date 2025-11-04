import 'package:get_it/get_it.dart';
import 'package:e_commerce_app/core/db/database.dart';

import 'package:e_commerce_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:e_commerce_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/login.dart';
import 'package:e_commerce_app/features/auth/domain/usecases/signup.dart';
import 'package:e_commerce_app/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:e_commerce_app/features/basket/data/datasources/basket_local_data_source.dart';
import 'package:e_commerce_app/features/basket/data/repositories/basket_repository_impl.dart';
import 'package:e_commerce_app/features/basket/domain/repositories/basket_repository.dart';
import 'package:e_commerce_app/features/basket/domain/usecases/get_basket.dart';
import 'package:e_commerce_app/features/basket/presentation/bloc/basket_bloc.dart';

import 'package:e_commerce_app/features/products/data/datasources/product_local_data_source.dart';
import 'package:e_commerce_app/features/products/data/repositories/product_repository_impl.dart';
import 'package:e_commerce_app/features/products/domain/repositories/product_repository.dart';
import 'package:e_commerce_app/features/products/domain/usecases/return_products.dart';
import 'package:e_commerce_app/features/products/domain/usecases/product_description.dart';
import 'package:e_commerce_app/features/products/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => SignUp(sl()));
  sl.registerFactory(() => AuthBloc(login: sl(), signUp: sl()));

  sl.registerLazySingleton<BasketLocalDataSource>(
    () => BasketLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<BasketRepository>(() => BasketRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetBasketItems(sl()));
  sl.registerLazySingleton(() => AddBasketItem(sl()));
  sl.registerLazySingleton(() => UpdateBasketItem(sl()));
  sl.registerLazySingleton(() => RemoveBasketItem(sl()));
  sl.registerLazySingleton(() => ClearBasket(sl()));
  sl.registerFactory(
    () => BasketBloc(
      getBasketItems: sl(),
      addBasketItem: sl(),
      updateBasketItem: sl(),
      removeBasketItem: sl(),
      clearBasket: sl(),
    ),
  );

  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() {
    return GetAllProducts(sl());
  });

  sl.registerLazySingleton(() {
    return GetProductDetail(sl());
  });

  sl.registerFactory(() {
    return ProductBloc(getAllProducts: sl(), getProductDetail: sl());
  });
}
