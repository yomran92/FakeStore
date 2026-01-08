import 'package:fakestore/features/category/data/datasources/category_remote_data_source.dart';
import 'package:fakestore/features/category/data/repositories/category_repository_impl.dart';
import 'package:fakestore/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:fakestore/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:fakestore/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/dio/factory.dart';
import 'features/category/domain/usecases/get_all_categorys_use_case.dart';
import 'features/category/presentation/bloc/category_bloc.dart';
import 'features/products/data/datasources/product_remote_data_source.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/domain/usecases/get_all_products_use_case.dart';
import 'features/products/presentation/bloc/product_bloc.dart';
import 'features/products/presentation/bloc/bloc_detail/product_detail_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton(DioFactory.create);
  sl.registerFactory(ProductBloc.new);
  sl.registerFactory(ProductDetailBloc.new);
  sl.registerFactory(CategoryBloc.new);
  sl.registerFactory(CartBloc.new);
  sl.registerLazySingleton(() => GetAllProductUseCase(sl()));
  sl.registerLazySingleton(() => GetAllCategorysUseCase(sl()));

  sl.registerLazySingleton(() => ProductRepository(sl()));
  sl.registerLazySingleton(() => CategoryRepository(sl()));
  sl.registerLazySingleton(() => ProductRemoteDataSource(client: sl()));
  sl.registerLazySingleton(() => CategoryRemoteDataSource(client: sl()));
  sl.registerLazySingleton(() => CartRepository(sl()));
  sl.registerLazySingleton(() => CartLocalDataSource());
}
